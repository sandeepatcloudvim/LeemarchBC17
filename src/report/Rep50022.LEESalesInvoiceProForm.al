report 50022 "LEE Sales - Pro Forma Inv"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LEESalesProFormaInv.rdl';
    WordLayout = './LEESalesProFormaInv.docx';
    Caption = 'Pro Forma Invoice';

    dataset
    {

        dataitem(Header;
        "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Pro Forma Invoice';
            column(DocumentDate;
            Format("Document Date", 0, 4))
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyEMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyVATRegNo; CompanyInformation.GetVATRegistrationNumber())
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(Payment_Method_Code; "Payment Method Code")
            {

            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(CustomerAddress1; CustomerAddress[1])
            {
            }
            column(CustomerAddress2; CustomerAddress[2])
            {
            }
            column(CustomerAddress3; CustomerAddress[3])
            {
            }
            column(CustomerAddress4; CustomerAddress[4])
            {
            }
            column(CustomerAddress5; CustomerAddress[5])
            {
            }
            column(CustomerAddress6; CustomerAddress[6])
            {
            }
            column(CustomerAddress7; CustomerAddress[7])
            {
            }
            column(CustomerAddress8; CustomerAddress[8])
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyLegalOffice; CompanyInformation.GetLegalOffice)
            {
            }
            column(SalesPersonName; SalespersonPurchaserName)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethodDescription)
            {
            }
            column(Currency; CurrencyCode)
            {
            }
            column(CustomerVATRegNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(CustomerVATRegistrationNoLbl; GetCustomerVATRegistrationNumberLbl())
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(DocumentTitleLbl; DocumentCaption())
            {
            }
            column(YourReferenceLbl; FieldCaption("Your Reference"))
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(CompanyLegalOfficeLbl; CompanyInformation.GetLegalOfficeLbl)
            {
            }
            column(SalesPersonLbl; SalesPersonLblText)
            {
            }
            column(EMailLbl; CompanyInformation.FieldCaption("E-Mail"))
            {
            }
            column(HomePageLbl; CompanyInformation.FieldCaption("Home Page"))
            {
            }
            column(CompanyPhoneNoLbl; CompanyInformation.FieldCaption("Phone No."))
            {
            }
            column(ShipmentMethodDescriptionLbl; DummyShipmentMethod.TableCaption)
            {
            }
            column(CurrencyLbl; DummyCurrency.TableCaption)
            {
            }
            column(ItemLbl; Item.TableCaption)
            {
            }
            column(TariffLbl; Item.FieldCaption("Tariff No."))
            {
            }
            column(UnitPriceLbl; Item.FieldCaption("Unit Price"))
            {
            }
            column(CountryOfManufactuctureLbl; CountryOfManufactuctureLbl)
            {
            }
            column(AmountLbl; Line.FieldCaption(Amount))
            {
            }
            column(VATPctLbl; Line.FieldCaption("VAT %"))
            {
            }
            column(VATAmountLbl; DummyVATAmountLine.VATAmountText)
            {
            }
            column(TotalWeightLbl; TotalWeightLbl)
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(TotalAmountInclVATLbl; TotalAmountInclVATLbl)
            {
            }
            column(QuantityLbl; Line.FieldCaption(Quantity))
            {
            }

            column(NetWeightLbl; Line.FieldCaption("Net Weight"))
            {
            }
            column(DeclartionLbl; DeclartionLbl)
            {
            }
            column(SignatureLbl; SignatureLbl)
            {
            }
            column(SignatureNameLbl; SignatureNameLbl)
            {
            }
            column(SignaturePositionLbl; SignaturePositionLbl)
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(No; "No.")
                {

                }
                column(ItemDescription; Description)
                {
                }
                column(ItemNo; "No.")
                {

                }
                column(LEE_Color_Code; Color.Description)
                {

                }
                column(Size_Code; "Size Code")
                {

                }
                column(CountryOfManufacturing; Item."Country/Region of Origin Code")
                {
                }
                column(Tariff; Item."Tariff No.")
                {
                }
                column(Line_Discount; "Line Discount %")
                {

                }
                column(Quantity; Quantity / ItemSizeCount)
                {
                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount; Amount / ItemSizeCount)
                {

                }
                column(VATAmount2; VATAmount / ItemSizeCount)
                {

                }
                column(Line_Amount; "Line Amount" / ItemSizeCount)
                {

                }

                column(Price; FormattedLinePrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(NetWeight; "Net Weight")
                {
                }
                column(LineAmount; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(VATPct; "VAT %")
                {
                }
                column(VATAmount; FormattedVATAmount)
                {
                }
                dataitem("Item Size"; "Item Size")
                {

                    DataItemLink = "Item No." = field("No.");
                    column(Size_Code2; "Size Code")
                    {
                    }
                    column(SizeValue; SizeValue)
                    {

                    }
                    trigger OnAfterGetRecord()


                    begin
                        SizeValue := 0;
                        if "Item Size"."Size Code" = Line."Size Code" then
                            SizeValue := Line.Quantity;

                    end;

                }






                trigger OnAfterGetRecord()
                var
                    AutoFormatType: Enum "Auto Format";



                begin
                    Clear(Color);
                    if Color.Get(Line."LEE_Color Code") then;

                    ItemSizeCount := 0;
                    ItemSize.Reset;
                    ItemSize.SetRange("Item No.", Line."No.");
                    if ItemSize.FindSet() then
                        ItemSizeCount := ItemSize.Count;






                    Item.Get("No.");
                    OnBeforeLineOnAfterGetRecord(Header, Line);

                    if Quantity = 0 then begin
                        LinePrice := "Unit Price";
                        LineAmount := 0;
                        VATAmount := 0;
                    end else begin
                        LinePrice := Round(Amount / Quantity, Currency."Unit-Amount Rounding Precision");
                        LineAmount := Round(Amount * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        VATAmount := Round(
                            Amount * "VAT %" / 100 * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");

                        TotalAmount += LineAmount;
                        TotalWeight += Round("Qty. to Invoice" * "Net Weight");
                        TotalVATAmount += VATAmount;
                        TotalAmountInclVAT += Round("Amount Including VAT" * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                    end;

                    FormattedLinePrice := Format(LinePrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                    FormattedLineAmount := Format(LineAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedVATAmount := Format(VATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;

                trigger OnPreDataItem()
                begin
                    TotalWeight := 0;
                    TotalAmount := 0;
                    TotalVATAmount := 0;
                    TotalAmountInclVAT := 0;
                    SetRange(Type, Type::Item);

                    OnAfterLineOnPreDataItem(Header, Line);
                end;


            }
            dataitem(Totals; "Integer")
            {
                MaxIteration = 1;
                column(TotalWeight; TotalWeight)
                {
                }
                column(TotalValue; FormattedTotalAmount)
                {
                }
                column(TotalVATAmount; FormattedTotalVATAmount)
                {
                }
                column(TotalAmountInclVAT; FormattedTotalAmountInclVAT)
                {
                }

                trigger OnPreDataItem()
                var
                    AutoFormatType: Enum "Auto Format";
                begin
                    FormattedTotalAmount := Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalVATAmount := Format(TotalVATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalAmountInclVAT := Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var

        CompanyInformation: Record "Company Information";
        DocumentTitleLbl: Label 'Pro Forma Invoice';
        PageLbl: Label 'Page';
        Item: Record Item;
        DummyVATAmountLine: Record "VAT Amount Line";
        DummyShipmentMethod: Record "Shipment Method";
        DummyCurrency: Record Currency;
        Currency: Record Currency;
        Language: Codeunit Language;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        AutoFormat: Codeunit "Auto Format";
        CompanyAddress: array[8] of Text[100];
        CustomerAddress: array[8] of Text[100];
        SalesPersonLblText: Text[50];
        CountryOfManufactuctureLbl: Label 'Country';
        TotalWeightLbl: Label 'Total Weight';
        SalespersonPurchaserName: Text;
        ShipmentMethodDescription: Text;
        TotalAmountLbl: Text[50];
        TotalAmountInclVATLbl: Text[50];
        FormattedLinePrice: Text;
        FormattedLineAmount: Text;
        FormattedVATAmount: Text;
        FormattedTotalAmount: Text;
        FormattedTotalVATAmount: Text;
        FormattedTotalAmountInclVAT: Text;
        CurrencyCode: Code[10];
        TotalWeight: Decimal;
        TotalAmount: Decimal;
        DeclartionLbl: Label 'For customs purposes only.';
        SignatureLbl: Label 'For and on behalf of the above named company:';
        SignatureNameLbl: Label 'Name (in print) Signature';
        SignaturePositionLbl: Label 'Position in company';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        TotalVATAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LinePrice: Decimal;
        LineAmount: Decimal;
        VATAmount: Decimal;
        SizeValue: Decimal;
        ItemSize: Record "item size";
        ItemSizeCount: Decimal;
        Color: Record LEE_Color;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        ResponsibilityCenter: Record "Responsibility Center";
        Customer: Record Customer;
        FormatDocument: Codeunit "Format Document";
        FormatAddress: Codeunit "Format Address";
        TotalAmounExclVATLbl: Text[50];
    begin
        with SalesHeader do begin
            Customer.Get("Sell-to Customer No.");
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonLblText);
            SalespersonPurchaserName := SalespersonPurchaser.Name;

            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
            ShipmentMethodDescription := ShipmentMethod.Description;

            FormatAddress.GetCompanyAddr("Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
            FormatAddress.SalesHeaderBillTo(CustomerAddress, SalesHeader);

            if "Currency Code" = '' then begin
                GeneralLedgerSetup.Get();
                GeneralLedgerSetup.TestField("LCY Code");
                CurrencyCode := GeneralLedgerSetup."LCY Code";
                Currency.InitRoundingPrecision;
            end else begin
                CurrencyCode := "Currency Code";
                Currency.Get("Currency Code");
            end;

            FormatDocument.SetTotalLabels("Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
        end;
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocumentTitleLbl);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesHeader: Record "Sales Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;


}

