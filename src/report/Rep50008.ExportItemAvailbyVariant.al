report 50008 "Export Item Avail. by Variant"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "LEE_Export Brand Group";
            dataitem("Item Variant"; "Item Variant")
            {

                trigger OnAfterGetRecord()
                var
                    _itemColour: Record "Item Color";
                    _itemSize: Record "Item Size";
                    _grossRequirement: Decimal;
                    _inventory: Decimal;
                    _plannedOrderReceipt: Decimal;
                    _projAvailBalance: Decimal;
                    _scheduledReceipt: Decimal;
                    _value: array[51] of Text[250];
                    _workOrders: Decimal;
                begin

                    //BFC006 -
                    //IF (GUIALLOWED) THEN
                    //  Dialogue.UPDATE(2,FORMAT(Code));

                    IF (GUIALLOWED) AND NOT
                       (IsAutomated)
                    THEN
                        Dialogue.UPDATE(2, FORMAT(Code));
                    //BFC006 +

                    //BFC008 Start
                    //CalculateNeed("Item No.",Code,_inventory,_plannedOrderReceipt,_scheduledReceipt,_grossRequirement);
                    CalculateNeed("Item No.", Code, _inventory, _plannedOrderReceipt, _scheduledReceipt, _grossRequirement, _workOrders);

                    //_projAvailBalance := _inventory + _plannedOrderReceipt + _scheduledReceipt - _grossRequirement;
                    _projAvailBalance := _inventory + _plannedOrderReceipt + _scheduledReceipt - _grossRequirement + _workOrders;
                    _projAvailBalance := _projAvailBalance - ExcludeTrimWO; //CAN_PS 08052019
                                                                            //BFC008 Finish

                    //BFC007 Start
                    //IF NOT (_projAvailBalance > 0) THEN
                    //  CurrReport.SKIP;
                    IF _projAvailBalance < 0
                      THEN
                        _projAvailBalance := 0;
                    //BFC007 End

                    IF (_itemColour.GET("Item No.", "Color Code")) THEN
                        _itemColour.CALCFIELDS("Color Description")
                    ELSE
                        CLEAR(_itemColour);

                    IF (_itemSize.GET("Item No.", "Size Code")) THEN
                        _itemSize.CALCFIELDS("Size Description")
                    ELSE
                        CLEAR(_itemSize);

                    CLEAR(_value);

                    //define field values and write to file
                    _value[1] := ' ';
                    _value[2] := ' ';
                    _value[3] := Item."No.";
                    //--SBC 10/26/17: Removed Original and added Function to GetUPCCode
                    //_value[4] := '';
                    _value[4] := GetUPCCode("Item Variant");
                    //++
                    _value[5] := ' ';
                    _value[6] := Description;
                    _value[7] := ' ';
                    _value[8] := ' ';
                    _value[9] := ' ';
                    _value[10] := _itemColour."Color Description";
                    _value[11] := "Color Code";
                    _value[12] := _itemSize."Size Description";
                    _value[13] := "Size Code";
                    _value[14] := "Description 2";
                    _value[15] := Code;
                    _value[16] := ' ';
                    _value[17] := ' ';
                    _value[18] := ' ';
                    _value[19] := ' ';
                    _value[20] := ' ';
                    _value[21] := ' ';
                    _value[22] := ' ';
                    _value[23] := ' ';
                    _value[24] := ' ';
                    _value[25] := ' ';
                    _value[26] := ' ';
                    _value[27] := ' ';
                    _value[28] := ' ';
                    _value[29] := ' ';
                    _value[30] := ' ';
                    _value[31] := ' ';
                    _value[32] := ' ';
                    _value[33] := ' ';
                    _value[34] := ' ';
                    _value[35] := FORMAT(_projAvailBalance);
                    _value[36] := ' ';
                    _value[37] := ' ';
                    _value[38] := ' ';
                    _value[39] := FORMAT(Item."Unit Price");
                    _value[40] := ' ';
                    _value[41] := ' ';
                    _value[42] := ' ';
                    _value[43] := ' ';
                    _value[44] := ' ';
                    _value[45] := ' ';
                    _value[46] := ' ';
                    _value[47] := ' ';
                    _value[48] := ' ';
                    _value[49] := ' ';
                    _value[50] := ' ';
                    _value[51] := ' ';

                    OutputFileWrite(_value);
                end;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                IF (GETFILTER("Date Filter") <> '') THEN
                    SETRANGE("Date Filter");

                IF (GETFILTER("Location Filter") <> '') THEN
                    SETRANGE("Location Filter");

                IF (GETFILTER("Variant Filter") <> '') THEN
                    SETRANGE("Variant Filter");

                //BFC006 -
                //IF (GUIALLOWED) THEN BEGIN
                //  i := 0;
                //  j := Item.COUNT;
                //END;

                IF (ExportBrandGrp <> '') THEN
                    SETRANGE("LEE_Export Brand Group", ExportBrandGrp);

                //do not execute the report if it is called by automation
                //and the dataset is empty
                IF (ISEMPTY) AND
                   (IsAutomated)
                THEN BEGIN
                    // FILE.ERASE(ExportFileName); //CV__PS
                    CurrReport.QUIT;
                END;

                IF (GUIALLOWED) AND NOT
                   (IsAutomated)
                THEN BEGIN
                    i := 0;
                    j := Item.COUNT;
                END;
                //BFC006 +
            end;

            trigger OnAfterGetRecord()
            begin

                //BFC006 -
                //IF (GUIALLOWED) THEN BEGIN
                //  i += 1;
                //  Dialogue.UPDATE(1,FORMAT("No."));
                //  Dialogue.UPDATE(3,ROUND(i / j * 10000,1));
                //END;

                IF (GUIALLOWED) AND NOT
                   (IsAutomated)
                THEN BEGIN
                    i += 1;
                    Dialogue.UPDATE(1, FORMAT("No."));
                    Dialogue.UPDATE(3, ROUND(i / j * 10000, 1));
                END;
                //BFC006 +
            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    trigger OnPreReport()
    begin

        IF (ExportFileName = '') THEN
            ERROR(Text00002);

        //BFC006 -
        //IF (GUIALLOWED) THEN
        //  Dialogue.OPEN(Text00010);

        IF (GUIALLOWED) AND NOT
           (IsAutomated)
        THEN
            Dialogue.OPEN(Text00010);
        //BFC006 +

        OutputFileOpen();
        OutputFileWriteHdr();
    end;

    trigger OnPostReport()
    begin

        OutputFileClose();

        //BFC006 -
        //IF (GUIALLOWED) THEN BEGIN
        //  Dialogue.CLOSE;
        //  MESSAGE(Text00004,'complete');
        //END;

        IF (GUIALLOWED) AND NOT
           (IsAutomated)
        THEN BEGIN
            Dialogue.CLOSE;
            MESSAGE(Text00004, 'complete');
        END;
        //BFC006 +
    end;

    var
        ExportFile: File;
        ExportFileOutStream: OutStream;
        Dialogue: Dialog;
        ExportBrandGrp: Code[20];
        ExportFileName: Text[250];
        FilterLocation: Text;
        FilterPdEnd: Date;
        FilterPdStart: Date;
        i: Integer;
        IsAutomated: Boolean;
        j: Integer;
        ExcludeTrimWO: Decimal;
        Text00001: Label 'CORAL';
        Text00002: Label 'Export file name has not been specified.';
        Text00003: Label 'Export file specified already exists.  Overwrite?';
        Text00004: Label 'Data export %1.';
        Text00010: Label 'Exporting item data... One moment, please...\\Item     #1##########\Variant  #2##########\Progress @3@@@@@@@@@@\';


    procedure CalculateNeed(_itemNo: Code[20]; _variantCode: Code[20]; VAR _inventory: Decimal; VAR _plannedOrderReceipt: Decimal; VAR _scheduledReceipt: Decimal; var _grossRequirement: Decimal; var _workOrders: Decimal)
    var
        _item: Record Item;
    begin
        _inventory := 0;
        _plannedOrderReceipt := 0;
        _scheduledReceipt := 0;
        _grossRequirement := 0;

        IF (_itemNo = '') THEN
            EXIT;

        _item.GET(_itemNo);

        IF (FilterPdStart <> 0D) OR
           (FilterPdEnd <> 0D)
        THEN
            _item.SETRANGE("Date Filter", FilterPdStart, FilterPdEnd);
        IF (FilterLocation <> '') THEN
            _item.SETFILTER("Location Filter", FilterLocation);
        _item.SETFILTER("Variant Filter", _variantCode);

        _item.CALCFIELDS(
          "Qty. on Purch. Order"
          , "LEE_Qty. on Work Order" //BFC008
          , "Qty. on Sales Order"
        //   , "Qty. on Kit Sales Lines" CV_PS
          , "Qty. on Service Order"
          , Inventory
          , "Net Change"
          , "Scheduled Receipt (Qty.)"
          , "Scheduled Need (Qty.)"
          , "Planning Issues (Qty.)"
          , "Planned Order Receipt (Qty.)"
          , "FP Order Receipt (Qty.)"
          , "Rel. Order Receipt (Qty.)"
          , "Planned Order Release (Qty.)"
          , "Purch. Req. Receipt (Qty.)"
          , "Purch. Req. Release (Qty.)");
        IF (FilterLocation <> '') THEN
            _item.CALCFIELDS(
              "Trans. Ord. Shipment (Qty.)"
              , "Qty. in Transit"
              , "Trans. Ord. Receipt (Qty.)");

        _inventory := _item.Inventory;

        //BFC008 Start
        _workOrders := _item."LEE_Qty. on Work Order";
        //BFC008 Finish

        // _grossRequirement := _item."Qty. on Sales Order" + _item."Qty. on Kit Sales Lines" + _item."Qty. on Service Order" + _item."Scheduled Need (Qty.)" + _item."Planning Issues (Qty.)" + _item."Trans. Ord. Shipment (Qty.)";
        _grossRequirement := _item."Qty. on Sales Order" + _item."Qty. on Service Order" + _item."Scheduled Need (Qty.)" + _item."Planning Issues (Qty.)" + _item."Trans. Ord. Shipment (Qty.)";

        _plannedOrderReceipt := _item."Planned Order Receipt (Qty.)" + _item."Purch. Req. Receipt (Qty.)";

        _scheduledReceipt := _item."FP Order Receipt (Qty.)" + _item."Rel. Order Receipt (Qty.)" + _item."Qty. on Purch. Order" + _item."Qty. in Transit" + _item."Trans. Ord. Receipt (Qty.)";

        //CAN_PS 08052019 START
        CLEAR(ExcludeTrimWO);
        _item.SETFILTER("LEE_Production Status Filter", '<>%1', 'TRIMMING');
        _item.CALCFIELDS("LEE_Qty. on Work Order");
        ExcludeTrimWO := _item."LEE_Qty. on Work Order";
        CLEAR(_item."LEE_Production Status Filter");
        //CAN_PS 08052019 STOP
    end;

    procedure OutputFileClose()
    begin
        // ExportFile.CLOSE();CV_PS
    end;

    procedure OutputFileOpen()
    begin
        // IF FILE.EXISTS(ExportFileName) THEN BEGIN CV_PS
        //BFC006 -
        //IF (GUIALLOWED) THEN BEGIN
        //  IF NOT (CONFIRM(Text00003,FALSE)) THEN
        //    ERROR(Text00004,'cancelled')
        //END;

        IF (GUIALLOWED) AND NOT
           (IsAutomated)
        THEN BEGIN
            IF NOT (CONFIRM(Text00003, FALSE)) THEN
                ERROR(Text00004, 'cancelled')
        END;
        //BFC006 +

        // FILE.ERASE(ExportFileName);CV_PS>>
        // END;

        // ExportFile.WRITEMODE(TRUE);
        // ExportFile.TEXTMODE(TRUE);
        // ExportFile.CREATE(ExportFileName);
        // ExportFile.CREATEOUTSTREAM(ExportFileOutStream); CV_PS<<
    end;

    procedure OutputFileWrite(_value: array[51] of Text[250])
    var
        _v: Integer;
    begin
        FOR _v := 1 TO ARRAYLEN(_value) DO BEGIN
            //write delimiter
            IF (_v > 1) THEN
                ExportFileOutStream.WRITETEXT(',');
            //write value
            ExportFileOutStream.WRITETEXT(_value[_v]);
        END;

        ExportFileOutStream.WRITETEXT();    //new line

    end;

    procedure OutputFileWriteHdr()
    var
        _value: array[51] of Text[250];
    begin
        //define header row values and write to file
        _value[1] := 'Product ID';
        _value[2] := 'Variant ID';
        _value[3] := 'SKU';
        _value[4] := 'UPC';
        _value[5] := 'Product Title';
        _value[6] := 'Product Description';
        _value[7] := 'Product Primary Category';
        _value[8] := 'Product Secondary Category';
        _value[9] := 'Product Vendor';
        _value[10] := 'Option 1 Name';
        _value[11] := 'Option 1 Value';
        _value[12] := 'Option 2 Name';
        _value[13] := 'Option 2 Value';
        _value[14] := 'Option 3 Name';
        _value[15] := 'Option 3 Value';
        _value[16] := 'Option 4 Name';
        _value[17] := 'Option 4 Value';
        _value[18] := 'Option 5 Name';
        _value[19] := 'Option 5 Value';
        _value[20] := 'Product Image 1';
        _value[21] := 'Product Image 2';
        _value[22] := 'Product Image 3';
        _value[23] := 'Product Image 4';
        _value[24] := 'Product Image 5';
        _value[25] := 'Product Image 6';
        _value[26] := 'Product Image 7';
        _value[27] := 'Product Image 8';
        _value[28] := 'Product Image 9';
        _value[29] := 'Product Image 10';
        _value[30] := 'Product Tags';
        _value[31] := 'Description';
        _value[32] := 'Primary Category';
        _value[33] := 'Secondary Category';
        _value[34] := 'Vendor';
        _value[35] := 'Quantity';
        _value[36] := 'Grams';
        _value[37] := 'Currency Code';
        _value[38] := 'Retail Price';
        _value[39] := 'Wholesale Price';
        _value[40] := 'Condition';
        _value[41] := 'Image 1';
        _value[42] := 'Image 2';
        _value[43] := 'Image 3';
        _value[44] := 'Image 4';
        _value[45] := 'Image 5';
        _value[46] := 'Image 6';
        _value[47] := 'Image 7';
        _value[48] := 'Image 8';
        _value[49] := 'Image 9';
        _value[50] := 'Image 10';
        _value[51] := 'Tags';

        OutputFileWrite(_value);
    end;

    procedure SetDefaultFilters()
    var
        _srSetup: Record "Sales & Receivables Setup";
    begin
        FilterPdStart := 0D;
        FilterPdEnd := WORKDATE;

        IF (_srSetup.GET()) THEN
            FilterLocation := _srSetup."Default Availability Location";

        //IF (FilterLocation = '') THEN
        //  FilterLocation := Text00001;
    end;

    procedure SetExportFileName()
    var
        _fileName: Text[80];
    begin
        _fileName :=
          'InvtAvailByVariant-' + FORMAT(DATE2DMY(WORKDATE, 3));

        IF (DATE2DMY(WORKDATE, 2) < 10) THEN
            _fileName := _fileName + '0' + FORMAT(DATE2DMY(WORKDATE, 2))
        ELSE
            _fileName := _fileName + FORMAT(DATE2DMY(WORKDATE, 2));

        IF (DATE2DMY(WORKDATE, 1) < 10) THEN
            _fileName := _fileName + '0' + FORMAT(DATE2DMY(WORKDATE, 1))
        ELSE
            _fileName := _fileName + FORMAT(DATE2DMY(WORKDATE, 1));

        _fileName := _fileName + '.csv';

        // ExportFileName := _commonDlgMgmt.OpenFile('Export File', _fileName, 4, '*.csv', 1); CV_PS
    end;

    procedure SetParameters(_filterPdStart: Date; _filterPdEnd: Date; _filterLocation: Text[1024]; _exportBrandGrp: Code[20]; _exportFileName: Text[250]; _isAutomated: Boolean)
    begin
        FilterPdStart := _filterPdStart;
        FilterPdEnd := _filterPdEnd;
        FilterLocation := _filterLocation;

        //BFC006 -
        //new parameters
        ExportBrandGrp := _exportBrandGrp;
        ExportFileName := _exportFileName;
        IsAutomated := _isAutomated;
        //BFC006 +
    end;

    procedure GetUPCCode(ItemVariant: Record "Item Variant"): Code[20]
    var
        ItemCrossRef: Record "Item Cross Reference";
    begin
        WITH ItemCrossRef DO BEGIN
            RESET;
            SETRANGE("Item No.", ItemVariant."Item No.");
            SETRANGE("Variant Code", ItemVariant.Code);
            IF FINDFIRST THEN
                EXIT(ItemCrossRef."Cross-Reference No.")
            ELSE
                EXIT('');
        end;
    END;


}