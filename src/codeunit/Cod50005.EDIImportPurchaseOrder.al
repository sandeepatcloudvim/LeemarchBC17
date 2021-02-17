codeunit 50005 "EDI Import Purchase Order"
{
    // OPS09 11/7/08 BLO - added a SalesHeader.MODIFY to solve lack of Shipment Date for Line Item creation.


    trigger OnRun();
    begin
        ImportPurchaseOrders;
    end;

    var
        Customer: Record Customer;
        CustShipTo: Record "Ship-to Address";
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        SkipSalesHeader: Record "Sales Header" temporary;
        SalesInvHeader: Record "Sales Invoice Header";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        Dialog1: Dialog;
        FileIndicator: Integer;
        FileProgress: Integer;
        FileTotal: Integer;
        DialogOpenInWrapper: Boolean;
        ImportedHeaderCount: Integer;
        ImportedLineCount: Integer;
        SkippedHeaderCount: Integer;
        SkippedLineCount: Integer;
        RecordType: Text[30];
        SPSTradingPartnerID: Text[30];
        PurchaseOrderNumber: Code[20];
        UnsavedOrder: Boolean;
        UnsavedLine: Boolean;
        BufferText: Text[1024];
        FoundOrder: Boolean;
        Dummy: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LastLineNo: Integer;
        ItemNo: Code[20];
        VariantCode: Code[20];
        UnitPrice: Decimal;
        BypassCurrentItem: Boolean;
        // InboxFiles: Record File;//CV_PS 11232020
        TempBlob: Record TemplBlob;
        DoNotDedupe: Boolean;
        TXT_ERRORITEMCREATE: Label 'Item %1 Color %2 Size %3 Document %4 could not be created';
        TXT_ERR_NO_TRADINGPARTNER: TextConst ENU = 'E.D.I. Trade Partner doesn''t exist for Code= ''%1''.';
        TXT_ERR_BADTRADEPTNRID: Label 'Trading Partner ID in file (%1) doesn''t match Setup value (%2).';

    procedure ImportPurchaseOrders();
    var
        UtilityFunctions: Codeunit "Utility Functions";
    begin

        // CURRENTLY UNUSED. This Codeunit is typically called from a Report format.
        /*
                ImportedHeaderCount := 0;
                ImportedLineCount := 0;

                SkippedHeaderCount := 0;
                SkippedLineCount := 0;

                IF (GUIALLOWED) THEN BEGIN
                    DialogOpenInWrapper := TRUE;
                    FileProgress := 0;
                    FileIndicator := 0;
                    FileTotal := InboxFiles.COUNT;

                    Dialog1.OPEN('Importing Purchase Orders...         \' +
                                 'Imported Header Count:     #1########\' +
                                 'Imported Line Count:       #2########\' +
                                 'Skipped Header Count:      #3########\' +
                                 'Skipped Line Count:        #4########',
                                 ImportedHeaderCount,
                                 ImportedLineCount,
                                 SkippedHeaderCount,
                                 SkippedLineCount);
                END;

                REPEAT

                    IF (ImportPurchaseOrder(InboxFiles.Path + InboxFiles.Name)) THEN BEGIN
                        COMMIT;
                    END;

                    IF (GUIALLOWED) THEN BEGIN
                        FileProgress += 1;
                        FileIndicator := ROUND((FileProgress / FileTotal) * 10000, 1);
                        Dialog1.UPDATE(1);
                    END;

                UNTIL (InboxFiles.NEXT = 0);

                IF (GUIALLOWED) THEN
                    Dialog1.CLOSE;
                    */
    end;

    procedure ImportPurchaseOrder(ImportFilePath: Text[512]) Success: Boolean;
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ImportFile: File;
        InStream1: InStream;
        InHeader: Boolean;
        ValidHeader: Boolean;
        BlobCU: codeunit "Temp Blob";
    begin
        Success := TRUE;

        // IF (EXISTS(ImportFilePath)) THEN BEGIN
        BEGIN
            ImportedHeaderCount := 0;
            ImportedLineCount := 0;

            SkippedHeaderCount := 0;
            SkippedLineCount := 0;

            IF (GUIALLOWED)
             AND NOT (DialogOpenInWrapper) THEN BEGIN
                Dialog1.OPEN('Importing Purchase Orders...     \' +
                             'Imported Header Count: #1########\' +
                             'Imported Line Count:   #2########\' +
                             'Skipped Header Count:  #3########\' +
                             'Skipped Line Count:    #4########',
                             ImportedHeaderCount,
                             ImportedLineCount,
                             SkippedHeaderCount,
                             SkippedLineCount);
            END;

            // ImportFile.OPEN(ImportFilePath);
            // ImportFile.CREATEINSTREAM(InStream1);
            TempBlob.Get();
            TempBlob.CalcFields(MyBlob);
            if TempBlob.MyBlob.HasValue then
                TempBlob.MyBlob.CreateInStream(InStream1);


            WHILE NOT (InStream1.EOS) DO BEGIN
                InStream1.READTEXT(BufferText);

                SPSTradingPartnerID := GetNextField(BufferText);

                PurchaseOrderNumber := GetNextField(BufferText);
                RecordType := GetNextField(BufferText);

                IF RecordType = 'HO' THEN BEGIN
                    IF ValidHeader AND UnsavedOrder THEN
                        SaveOrder;
                    InHeader := TRUE;
                    UnsavedOrder := TRUE;
                    ValidHeader := ParseRecTypeHO;
                END;

                IF ValidHeader THEN
                    CASE RecordType OF
                        'HT':
                            ParseRecTypeHT;
                        'DH':
                            ParseRecTypeDH;
                        'HA':
                            ParseRecTypeHA;
                        'RH':
                            ParseRecTypeRH;
                        'LI':
                            ParseRecTypeLI;
                        'LD':
                            IF NOT BypassCurrentItem THEN
                                ParseRecTypeLD;
                    END;

                IF (GUIALLOWED) THEN Dialog1.UPDATE;

            END; // WHILE loop

            IF ValidHeader AND UnsavedOrder THEN
                SaveOrder;

            CLEAR(InStream1);
            // ImportFile.CLOSE;

            IF (GUIALLOWED)
             AND NOT (DialogOpenInWrapper) THEN
                Dialog1.CLOSE;

        END;

        MESSAGE('Imported %1 Purchase Order Header(s) and %2 Purchase Order Line(s).\\Skipped %3 order(s) and %4 line(s).',
                ImportedHeaderCount, ImportedLineCount, SkippedHeaderCount, SkippedLineCount);

        EXIT(Success);
    end;

    procedure GetNextField(var InBufferText: Text[1024]) FieldValue: Text[512];
    var
        SearchString: Text[512];
    begin
        SearchString := ',';

        IF (InBufferText[1] = '"')
         AND (STRPOS(InBufferText, SearchString) <> 1) THEN
            InBufferText := COPYSTR(InBufferText, 2);

        IF (STRPOS(InBufferText, SearchString) > 0) THEN BEGIN
            IF (STRPOS(InBufferText, SearchString) > 1) THEN
                FieldValue := COPYSTR(InBufferText, 1, STRPOS(InBufferText, SearchString) - 1);

            InBufferText := COPYSTR(InBufferText, STRPOS(InBufferText, SearchString) + STRLEN(SearchString));
        END ELSE BEGIN
            IF (STRLEN(InBufferText) > 0) THEN BEGIN
                IF (InBufferText[STRLEN(InBufferText)] = '"') THEN
                    InBufferText := COPYSTR(InBufferText, 1, STRLEN(InBufferText) - 1);
            END;

            FieldValue := InBufferText;
            InBufferText := '';
        END;

        EXIT(FieldValue);
    end;

    procedure TestNoSeries(InSalesHeader: Record "Sales Header");
    begin
        CASE InSalesHeader."Document Type" OF
            InSalesHeader."Document Type"::Quote:
                SalesSetup.TESTFIELD("Quote Nos.");
            InSalesHeader."Document Type"::Order:
                SalesSetup.TESTFIELD("Order Nos.");
            InSalesHeader."Document Type"::Invoice:
                BEGIN
                    SalesSetup.TESTFIELD("Invoice Nos.");
                    SalesSetup.TESTFIELD("Posted Invoice Nos.");
                END;
            InSalesHeader."Document Type"::"Return Order":
                SalesSetup.TESTFIELD("Return Order Nos.");
            InSalesHeader."Document Type"::"Credit Memo":
                BEGIN
                    SalesSetup.TESTFIELD("Credit Memo Nos.");
                    SalesSetup.TESTFIELD("Posted Credit Memo Nos.");
                END;
            InSalesHeader."Document Type"::"Blanket Order":
                SalesSetup.TESTFIELD("Blanket Order Nos.");
        END;
    end;

    procedure FormatDate(InDate: Text[30]) OutDate: Date;
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        EVALUATE(OutDate, InDate);
    end;

    procedure ParseRecTypeHO() OutValidHeader: Boolean;
    var
        NoSeriesCode: Code[10];
        HOTestPurposeCode: Text[30];
        HOPurchaseOrderTypeCode: Text[30];
        HOReleaseNumber: Text[30];
        HOPurchaseOrderDate: Text[30];
        HOContractNumber: Text[30];
        HOContractType: Text[30];
        HOAcknowledgementType: Text[30];
        HOInvoiceTypeCode: Text[30];
        HOShipCompleteCode: Text[30];
        HOBuyersCurrency: Text[30];
        HOSellersCurrency: Text[30];
        HOExchangeRate: Text[30];
        HOTaxExemptCode: Text[30];
        HOLetterOfCredit: Text[30];
        HODepartment: Text[30];
        HOVendor: Text[30];
        TXT_ERROR_NO_SPS: Label 'No Customer found with SPS Vendor No. %1!\\Go to the Customer Card in question\and add an appropriate SPS Vendor No.';
    begin
        // HO = Header Order

        CLEAR(SalesHeader);
        SalesHeader.SetHideValidationDialog(TRUE);
        SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
        SalesHeader.INSERT(TRUE);

        HOTestPurposeCode := GetNextField(BufferText);
        HOPurchaseOrderTypeCode := GetNextField(BufferText);
        HOReleaseNumber := GetNextField(BufferText);
        HOPurchaseOrderDate := GetNextField(BufferText);
        HOContractNumber := GetNextField(BufferText);
        HOContractType := GetNextField(BufferText);
        HOAcknowledgementType := GetNextField(BufferText);
        HOInvoiceTypeCode := GetNextField(BufferText);
        HOShipCompleteCode := GetNextField(BufferText);
        HOBuyersCurrency := GetNextField(BufferText);
        HOSellersCurrency := GetNextField(BufferText);
        HOExchangeRate := GetNextField(BufferText);
        HOTaxExemptCode := GetNextField(BufferText);
        HOLetterOfCredit := GetNextField(BufferText);
        HODepartment := GetNextField(BufferText);
        HOVendor := GetNextField(BufferText);

        Customer.SETRANGE("SPS Vendor No.", HOVendor);

        IF NOT Customer.FINDFIRST THEN BEGIN

            ERROR(TXT_ERROR_NO_SPS, HOVendor);
            SkipSalesHeader."No." := PurchaseOrderNumber;
            Dummy := SkipSalesHeader.INSERT;
            SkippedHeaderCount += 1;

        END ELSE BEGIN

            IF NOT DoNotDedupe THEN BEGIN

                // Check if PO already exists
                SalesHeader2.RESET;
                SalesHeader2.SETFILTER("Document Type", '%1|%2', SalesHeader2."Document Type"::Quote, SalesHeader2."Document Type"::Order);
                SalesHeader2.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesHeader2.SETRANGE("Your Reference", PurchaseOrderNumber);
                FoundOrder := NOT SalesHeader2.ISEMPTY;

                IF NOT FoundOrder THEN BEGIN
                    SalesHeader2.RESET;
                    SalesHeader2.SETFILTER("Document Type", '%1|%2', SalesHeader2."Document Type"::Quote, SalesHeader2."Document Type"::Order);
                    SalesHeader2.SETRANGE("Sell-to Customer No.", Customer."No.");
                    SalesHeader2.SETRANGE("External Document No.", PurchaseOrderNumber);
                    FoundOrder := NOT SalesHeader2.ISEMPTY;
                END;

                IF NOT FoundOrder THEN BEGIN
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("Sell-to Customer No.", Customer."No.");
                    SalesInvHeader.SETRANGE("Your Reference", PurchaseOrderNumber);
                    FoundOrder := NOT SalesInvHeader.ISEMPTY;
                END;

                IF NOT FoundOrder THEN BEGIN
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("Sell-to Customer No.", Customer."No.");
                    SalesInvHeader.SETRANGE("External Document No.", PurchaseOrderNumber);
                    FoundOrder := NOT SalesInvHeader.ISEMPTY;
                END;

            END;

            IF NOT FoundOrder THEN BEGIN

                IF PurchaseOrderNumber = '' THEN BEGIN
                    TestNoSeries(SalesHeader);
                    NoSeriesCode := 'SQ';
                    NoSeriesMgt.InitSeries(SalesSetup."Quote Nos.", '', WORKDATE, PurchaseOrderNumber, NoSeriesCode);
                END;

                EVALUATE(SalesHeader."Order Date", COPYSTR(HOPurchaseOrderDate, 5, 4) + COPYSTR(HOPurchaseOrderDate, 1, 4));
                SalesHeader.VALIDATE("Order Date");

                // SalesHeader."EDI Order" := TRUE;
                SalesHeader.VALIDATE("Document Date", WORKDATE);
                SalesHeader.VALIDATE("Sell-to Customer No.", Customer."No.");
                SalesHeader."External Document No." := COPYSTR(PurchaseOrderNumber, 1, MAXSTRLEN(SalesHeader."External Document No."));
                SalesHeader."Your Reference" := PurchaseOrderNumber;

                IF SalesHeader.MODIFY(TRUE) THEN BEGIN
                    EXIT(TRUE);
                    ImportedHeaderCount += 1;
                END;

            END ELSE BEGIN
                IF (GUIALLOWED) THEN ERROR('An order already exists with Reference No. "' + PurchaseOrderNumber + '".');
                SkipSalesHeader."No." := PurchaseOrderNumber;
                Dummy := SkipSalesHeader.INSERT;
                SkippedHeaderCount += 1;
            END;

        END;
    end;

    procedure ParseRecTypeHT();
    var
        PayTerms: Record "Payment Terms";
        HTTermsType: Text[30];
        HTTermsBasisDateCode: Text[30];
        HTTermsDiscountPercentage: Text[30];
        HTTermsDiscountDate: Text[30];
        HTTermsDiscountDueDays: Text[30];
        HTTermsNetDueDate: Text[30];
        HTTermsNetDueDays: Text[30];
        HTTermsDiscountAmount: Text[30];
        HTTermsDeferredDueDate: Text[30];
        HTTermsDeferredAmountDue: Text[30];
        HTPercentOfInvoicePayable: Text[30];
        HTTermsDescription: Text[30];
        HTTermsDueDay: Text[30];
    begin
        // HT = Header Payment Terms

        HTTermsType := GetNextField(BufferText);
        HTTermsBasisDateCode := GetNextField(BufferText);
        HTTermsDiscountPercentage := GetNextField(BufferText);
        HTTermsDiscountDate := GetNextField(BufferText);
        HTTermsDiscountDueDays := GetNextField(BufferText);
        HTTermsNetDueDate := GetNextField(BufferText);
        HTTermsNetDueDays := GetNextField(BufferText);
        HTTermsDiscountAmount := GetNextField(BufferText);
        HTTermsDeferredDueDate := GetNextField(BufferText);
        HTTermsDeferredAmountDue := GetNextField(BufferText);
        HTPercentOfInvoicePayable := GetNextField(BufferText);
        HTTermsDescription := GetNextField(BufferText);
        HTTermsDueDay := GetNextField(BufferText);

        PayTerms.SETRANGE(Code, HTTermsNetDueDays);
        IF NOT (PayTerms.FINDFIRST) THEN BEGIN
            PayTerms.SETFILTER(Code, '%1', '*' + FORMAT(HTTermsNetDueDays) + '*');
            PayTerms.SETRANGE("Discount %", 0);
            IF (PayTerms.FINDFIRST) THEN BEGIN
                HTTermsNetDueDays := PayTerms.Code;
                SalesHeader.VALIDATE("Payment Terms Code", PayTerms.Code);
            END;
        END ELSE
            SalesHeader.VALIDATE("Payment Terms Code", HTTermsNetDueDays);
    end;

    procedure ParseRecTypeDH();
    var
        DHDateTimeQualifier1: Text[30];
        DHDate1: Text[30];
        DHTime1: Text[30];
        DHTimeCode1: Text[30];
        DHdateTimeFormQualifier1: Text[30];
    begin
        // DH = Date Header

        DHDateTimeQualifier1 := GetNextField(BufferText);
        DHDate1 := GetNextField(BufferText);
        DHTime1 := GetNextField(BufferText);
        DHTimeCode1 := GetNextField(BufferText);
        DHdateTimeFormQualifier1 := GetNextField(BufferText);

        CASE DHDateTimeQualifier1 OF
            '1', '001':
                EVALUATE(SalesHeader."Shipment Date", COPYSTR(DHDate1, 5, 4) + COPYSTR(DHDate1, 1, 4));
            '2', '002':
                EVALUATE(SalesHeader."Requested Delivery Date", COPYSTR(DHDate1, 5, 4) + COPYSTR(DHDate1, 1, 4));
            '10', '010':
                EVALUATE(SalesHeader."Shipment Date", COPYSTR(DHDate1, 5, 4) + COPYSTR(DHDate1, 1, 4));
            '37', '037':
                EVALUATE(SalesHeader."LEE_Start Ship Date", COPYSTR(DHDate1, 5, 4) + COPYSTR(DHDate1, 1, 4));
            ELSE BEGIN
                    EVALUATE(SalesHeader."Shipment Date", COPYSTR(DHDateTimeQualifier1, 5, 4) + COPYSTR(DHDateTimeQualifier1, 1, 4));
                    EVALUATE(SalesHeader."LEE_Start Ship Date", COPYSTR(DHTimeCode1, 5, 4) + COPYSTR(DHTimeCode1, 1, 4));
                END;
        END;
        //OPS09 11/7/08
        SalesHeader.MODIFY;
    end;

    procedure ParseRecTypeHA();
    var
        HAAddressTypeCode: Text[30];
        HALocationCodeQualifier: Text[30];
        HAAddressLocationNumber: Text[30];
        HAAddressName: Text[60];
        HAAddressAlternateName: Text[60];
        HAAddress1: Text[100];
        HAAddress2: Text[100];
        HAAddress3: Text[100];
        HAAddress4: Text[100];
        HACity: Text[60];
        HAState: Text[60];
        HAPostalCode: Text[60];
        HACountry: Text[60];
        HAContactName: Text[60];
        HAContactPhone: Text[30];
        HAContactFax: Text[30];
        HAContactEmail: Text[60];
        HAAddressTaxIdNumber: Text[30];
        HAAddressTaxExemptNumber: Text[30];
        HAAddressAlternateName2: Text[60];
        ShipToAddress: Record "Ship-to Address";
    begin
        // HA = Header Address

        HAAddressTypeCode := GetNextField(BufferText);
        HALocationCodeQualifier := GetNextField(BufferText);
        HAAddressLocationNumber := GetNextField(BufferText);
        HAAddressName := GetNextField(BufferText);
        HAAddressAlternateName := GetNextField(BufferText);
        HAAddress1 := GetNextField(BufferText);
        HAAddress2 := GetNextField(BufferText);
        HAAddress3 := GetNextField(BufferText);
        HAAddress4 := GetNextField(BufferText);
        HACity := GetNextField(BufferText);
        HAState := GetNextField(BufferText);
        HAPostalCode := GetNextField(BufferText);
        HACountry := GetNextField(BufferText);
        HAContactName := GetNextField(BufferText);
        HAContactPhone := GetNextField(BufferText);
        HAContactFax := GetNextField(BufferText);
        HAContactEmail := GetNextField(BufferText);
        HAAddressTaxIdNumber := GetNextField(BufferText);
        HAAddressTaxExemptNumber := GetNextField(BufferText);
        HAAddressAlternateName2 := GetNextField(BufferText);

        CASE HAAddressTypeCode OF
            'BD':
                //BD = Buyer Dept
                SalesHeader."Ship-to Contact" := HAContactName;
            'ST':
                BEGIN
                    SalesHeader."Ship-to Code" := HAAddressLocationNumber;
                    IF NOT ShipToAddress.GET(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code") THEN BEGIN
                        CLEAR(ShipToAddress);
                        ShipToAddress."Customer No." := SalesHeader."Sell-to Customer No.";
                        ShipToAddress.Code := SalesHeader."Ship-to Code";
                        ShipToAddress.INSERT(TRUE);
                    END;
                    // update/populate ship to address data
                    ShipToAddress.GET(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code");
                    IF (HAAddressName <> '') THEN
                        ShipToAddress.Name := HAAddressName;
                    IF (HAAddressAlternateName <> '') THEN
                        ShipToAddress."Name 2" := HAAddressAlternateName;
                    IF (HAAddress1 <> '') THEN
                        ShipToAddress.Address := HAAddress1;
                    IF (HAAddress2 <> '') THEN
                        ShipToAddress."Address 2" := HAAddress2;
                    IF (HACity <> '') THEN
                        ShipToAddress.City := HACity;
                    IF (HAContactName <> '') THEN
                        ShipToAddress.Contact := HAContactName;
                    IF (HAContactPhone <> '') THEN
                        ShipToAddress."Phone No." := HAContactPhone;
                    IF (HAContactFax <> '') THEN
                        ShipToAddress."Fax No." := HAContactFax;
                    IF (HAContactEmail <> '') THEN
                        ShipToAddress."E-Mail" := HAContactEmail;
                    ShipToAddress.MODIFY(TRUE);
                END;
        END;
    end;

    procedure ParseRecTypeRH();
    var
        RHReferenceQual: Text[30];
        RHReferenceID: Text[30];
        RHDescription: Text[30];
    begin
        // RH = Reference Header

        RHReferenceQual := GetNextField(BufferText);
        RHReferenceID := GetNextField(BufferText);
        RHDescription := GetNextField(BufferText);

        SalesHeader."Reference ID" := RHReferenceID; //CV_PS 11232020
        SalesHeader."Reference Description1" := RHDescription; //CV_PS 11232020
    end;

    procedure ParseRecTypeLI();
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        ItemXRef: Record "Item Cross Reference";
        LILineSequenceNumber: Text[30];
        LIBuyerPartNumber: Text[30];
        LIVendorPartNumber: Text[30];
        LIConsumerPackageCode: Text[30];
        LIGTIN: Text[30];
        LIUPCCaseCode: Text[30];
        LINatlDrugCode: Text[30];
        LIPartNumberQualifier1: Text[30];
        LIPartNumber1: Text[30];
        LIPartNumberQualifier2: Text[30];
        LIPartNumber2: Text[30];
        LIPartNumberQualifier3: Text[30];
        LIPartNumber3: Text[30];
        LIPartNumberQualifier4: Text[30];
        LIPartNumber4: Text[30];
        LIRetailInformation: Text[30];
        LIPartDescription1: Text[30];
        LIPartDescription2: Text[30];
        LIOrderQty: Decimal;
        LIOrderQtyUOM: Text[30];
        LIUnitPrice: Decimal;
        LIUnitPriceBasis: Text[30];
        LIMfgSuggestedRetailPrice: Text[30];
        LIRetailUnitPrice: Text[30];
        LIOuterPack: Text[30];
        LIPackSize: Text[30];
        LIPackUOM: Text[30];
        LIPackWeight: Text[30];
        LIPackWeightUOM: Text[30];
        LIPackVolume: Text[30];
        LIPackVolumeUOM: Text[30];
        LIPackLength: Text[30];
        LIPackWidth: Text[30];
        LIPackHeight: Text[30];
        LIInnerPack: Text[30];
        LIShipQty: Text[30];
        LIShipQtyUOM: Text[30];
        LIShipDate: Text[30];
        LIQtyLeftToReceive: Text[30];
        LIExtendedItemtotal: Text[30];
        LIProductSizeCode: Text[30];
        LIProductSizeDescription: Text[30];
        LIProductColorCode: Text[30];
        LIProductColorDescription: Text[30];
        LIProductFabricCode: Text[30];
        LIProductFabricDescription: Text[30];
        LIProductProcessCode: Text[30];
        LIProductProcessDescription: Text[30];
        LIDepartment: Text[30];
        LIClass: Text[30];
        LIGender: Text[30];
        LISellerDateCode: Text[30];
        LIEventType: Text[30];
        LIEventTypeInformation: Text[30];
        LITicketType: Text[30];
        LITicketTypeInformation: Text[30];
        LIItemStatusCode: Text[30];
        FoundItem: Boolean;
    begin
        // LI = Line Item

        LILineSequenceNumber := GetNextField(BufferText);
        LIBuyerPartNumber := GetNextField(BufferText);
        LIUPCCaseCode := GetNextField(BufferText);
        LINatlDrugCode := GetNextField(BufferText);
        LIVendorPartNumber := GetNextField(BufferText);
        LIConsumerPackageCode := GetNextField(BufferText);
        LIGTIN := GetNextField(BufferText);
        LIPartNumber1 := GetNextField(BufferText);
        LIPartNumber2 := GetNextField(BufferText);
        LIPartNumber3 := GetNextField(BufferText);
        LIPartNumber4 := GetNextField(BufferText);
        LIRetailInformation := GetNextField(BufferText);
        LIPartDescription1 := GetNextField(BufferText);
        LIPartDescription2 := GetNextField(BufferText);
        EVALUATE(LIOrderQty, GetNextField(BufferText));
        LIOrderQtyUOM := GetNextField(BufferText);
        EVALUATE(LIUnitPrice, GetNextField(BufferText));
        LIUnitPriceBasis := GetNextField(BufferText);
        LIMfgSuggestedRetailPrice := GetNextField(BufferText);
        LIRetailUnitPrice := GetNextField(BufferText);
        LIOuterPack := GetNextField(BufferText);
        LIPackSize := GetNextField(BufferText);
        LIPackUOM := GetNextField(BufferText);
        LIPackWeight := GetNextField(BufferText);
        LIPackWeightUOM := GetNextField(BufferText);
        LIPackVolume := GetNextField(BufferText);
        LIPackVolumeUOM := GetNextField(BufferText);
        LIPackLength := GetNextField(BufferText);
        LIPackWidth := GetNextField(BufferText);
        LIPackHeight := GetNextField(BufferText);
        LIInnerPack := GetNextField(BufferText);
        LIShipQty := GetNextField(BufferText);
        LIShipQtyUOM := GetNextField(BufferText);
        LIShipDate := GetNextField(BufferText);
        LIQtyLeftToReceive := GetNextField(BufferText);
        LIExtendedItemtotal := GetNextField(BufferText);
        LIProductSizeCode := GetNextField(BufferText);
        LIProductSizeDescription := GetNextField(BufferText);
        LIProductColorCode := GetNextField(BufferText);
        LIProductColorDescription := GetNextField(BufferText);
        LIProductFabricCode := GetNextField(BufferText);
        LIProductFabricDescription := GetNextField(BufferText);
        LIProductProcessCode := GetNextField(BufferText);
        LIProductProcessDescription := GetNextField(BufferText);
        LIDepartment := GetNextField(BufferText);
        LIClass := GetNextField(BufferText);
        LIGender := GetNextField(BufferText);
        LISellerDateCode := GetNextField(BufferText);
        LIEventType := GetNextField(BufferText);
        LIEventTypeInformation := GetNextField(BufferText);
        LITicketType := GetNextField(BufferText);
        LITicketTypeInformation := GetNextField(BufferText);
        LIItemStatusCode := GetNextField(BufferText);
        LIPartNumberQualifier1 := GetNextField(BufferText);
        LIPartNumberQualifier2 := GetNextField(BufferText);
        LIPartNumberQualifier3 := GetNextField(BufferText);
        LIPartNumberQualifier4 := GetNextField(BufferText);

        IF LIConsumerPackageCode = 'UK' THEN
            LIGTIN := COPYSTR(LIGTIN, 3, MAXSTRLEN(LIGTIN));

        ItemXRef.SETRANGE("UPC No.", TRUE);
        ItemXRef.SETRANGE("Cross-Reference No.", LIGTIN);

        FoundItem := NOT (ItemXRef.ISEMPTY);

        IF NOT (FoundItem) THEN BEGIN
            IF (COPYSTR(LIGTIN, 1, 2) = '00') THEN BEGIN
                LIGTIN := COPYSTR(LIGTIN, 3, MAXSTRLEN(LIGTIN));
                ItemXRef.SETRANGE("Cross-Reference No.", LIGTIN);
                FoundItem := NOT (ItemXRef.ISEMPTY);
            END;
        END;

        IF NOT (FoundItem) THEN BEGIN
            BypassCurrentItem := TRUE;
            ERROR('Can not find an Item Cross-Reference for PartNo = "' +
                  LIVendorPartNumber + '", Description="' + LIPartDescription1 + '" and UPC="' + LIGTIN + '"');
        END ELSE BEGIN
            ItemXRef.FINDFIRST;
            BypassCurrentItem := FALSE;
            ItemNo := ItemXRef."Item No.";
            VariantCode := ItemXRef."Variant Code";
            UnitPrice := LIUnitPrice;
        END;
    end;

    procedure ParseRecTypeLD();
    var
        LDDestination1: Text[30];
        LDQty1: Decimal;
        LDDestination2: Text[30];
        LDQty2: Decimal;
        LDDestination3: Text[30];
        LDQty3: Decimal;
        LDDestination4: Text[30];
        LDQty4: Decimal;
        LDDestination5: Text[30];
        LDQty5: Decimal;
        LDDestination6: Text[30];
        LDQty6: Decimal;
        LDDestination7: Text[30];
        LDQty7: Decimal;
        LDDestination8: Text[30];
        LDQty8: Decimal;
        LDDestination9: Text[30];
        LDQty9: Decimal;
        LDDestination10: Text[30];
        LDQty10: Decimal;
        LDQtyUOM: Text[30];
    begin
        // LD = Line Destination & Schedule

        LDDestination1 := GetNextField(BufferText);
        IF LDDestination1 <> '' THEN BEGIN
            EVALUATE(LDQty1, GetNextField(BufferText));
            SaveLine(LDDestination1, LDQty1);
        END ELSE
            GetNextField(BufferText);
        LDDestination2 := GetNextField(BufferText);
        IF LDDestination2 <> '' THEN BEGIN
            EVALUATE(LDQty2, GetNextField(BufferText));
            SaveLine(LDDestination2, LDQty2);
        END ELSE
            GetNextField(BufferText);
        LDDestination3 := GetNextField(BufferText);
        IF LDDestination3 <> '' THEN BEGIN
            EVALUATE(LDQty3, GetNextField(BufferText));
            SaveLine(LDDestination3, LDQty3);
        END ELSE
            GetNextField(BufferText);
        LDDestination4 := GetNextField(BufferText);
        IF LDDestination4 <> '' THEN BEGIN
            EVALUATE(LDQty4, GetNextField(BufferText));
            SaveLine(LDDestination4, LDQty4);
        END ELSE
            GetNextField(BufferText);
        LDDestination5 := GetNextField(BufferText);
        IF LDDestination5 <> '' THEN BEGIN
            EVALUATE(LDQty5, GetNextField(BufferText));
            SaveLine(LDDestination5, LDQty5);
        END ELSE
            GetNextField(BufferText);
        LDDestination6 := GetNextField(BufferText);
        IF LDDestination6 <> '' THEN BEGIN
            EVALUATE(LDQty6, GetNextField(BufferText));
            SaveLine(LDDestination6, LDQty6);
        END ELSE
            GetNextField(BufferText);
        LDDestination7 := GetNextField(BufferText);
        IF LDDestination7 <> '' THEN BEGIN
            EVALUATE(LDQty7, GetNextField(BufferText));
            SaveLine(LDDestination7, LDQty7);
        END ELSE
            GetNextField(BufferText);
        LDDestination8 := GetNextField(BufferText);
        IF LDDestination8 <> '' THEN BEGIN
            EVALUATE(LDQty8, GetNextField(BufferText));
            SaveLine(LDDestination8, LDQty8);
        END ELSE
            GetNextField(BufferText);
        LDDestination9 := GetNextField(BufferText);
        IF LDDestination9 <> '' THEN BEGIN
            EVALUATE(LDQty9, GetNextField(BufferText));
            SaveLine(LDDestination9, LDQty9);
        END ELSE
            GetNextField(BufferText);
        LDDestination10 := GetNextField(BufferText);
        IF LDDestination10 <> '' THEN BEGIN
            EVALUATE(LDQty10, GetNextField(BufferText));
            SaveLine(LDDestination10, LDQty10);
        END ELSE
            GetNextField(BufferText);

        LDQtyUOM := GetNextField(BufferText);
    end;

    procedure ParseRecTypeST();
    var
        STTotalAmount: Text[30];
        STTotalLineItemNumber: Text[30];
    begin
        // ST = Summary Total

        STTotalAmount := GetNextField(BufferText);
        STTotalLineItemNumber := GetNextField(BufferText);
        //TotalQuantity := GetNextField(BufferText);
    end;

    procedure SaveOrder();
    begin
        ImportedHeaderCount += 1;
        SalesHeader.MODIFY(TRUE);
        IF (GUIALLOWED) THEN Dialog1.UPDATE;
    end;

    procedure SaveLine(StoreNo: Text[30]; Qty: Decimal);
    begin
        LastLineNo := LastLineNo + 10000;

        SalesLine.SetHideValidationDialog(TRUE);
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine.VALIDATE("Document No.", SalesHeader."No.");
        SalesLine."Line No." := LastLineNo + 10000;
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine.VALIDATE("No.", ItemNo);
        SalesLine.VALIDATE("Variant Code", VariantCode);
        IF ItemVariant.GET(ItemNo, VariantCode) THEN BEGIN
            SalesLine.VALIDATE("LEE_Color Code", ItemVariant."Color Code");
            SalesLine.VALIDATE("Size Code", ItemVariant."Size Code");
        END;
        TestStoreNo(StoreNo);
        SalesLine.VALIDATE("Ship-to Code", StoreNo);//CV_PS 11202020
        SalesLine.VALIDATE(Quantity, Qty);
        SalesLine.VALIDATE("Unit Price", UnitPrice);

        ImportedLineCount += 1;

        SalesLine.INSERT(TRUE);

        IF (GUIALLOWED) THEN Dialog1.UPDATE;
    end;

    procedure TestStoreNo(InStoreNo: Text[30]);
    var
        ShipToAddress: Record "Ship-to Address";
    begin
        IF NOT ShipToAddress.GET(SalesHeader."Sell-to Customer No.", InStoreNo) THEN BEGIN
            CLEAR(ShipToAddress);
            ShipToAddress."Customer No." := SalesHeader."Sell-to Customer No.";
            ShipToAddress.Code := InStoreNo;
            ShipToAddress.INSERT(TRUE);
        END;
    end;

    procedure SetDoNotDedupe(InDoNotDedupe: Boolean);
    begin
        DoNotDedupe := InDoNotDedupe;
    end;
}

