report 50031 "Inventory Brand Export"
{
    Caption = 'Inventory Brand Export';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "LEE_Export Brand Group";
            dataitem("Item Variant"; "Item Variant")
            {
                DataItemLink = "Item No." = FIELD("No.");
                RequestFilterFields = "Code";

                trigger OnAfterGetRecord()
                var
                    _itemColour: Record "Item Color";
                    _itemSize: Record "Item Size";
                    _grossRequirement: Decimal;
                    _inventory: Decimal;
                    _plannedOrderReceipt: Decimal;
                    _projAvailBalance: Decimal;
                    _scheduledReceipt: Decimal;
                    _value: array[5] of Text[250];
                    _workOrders: Decimal;
                begin

                    IF (GUIALLOWED) AND NOT
                       (IsAutomated)
                    THEN
                        Dialogue.UPDATE(2, FORMAT(Code));

                    CalculateNeed("Item No.", Code, _inventory, _plannedOrderReceipt, _scheduledReceipt, _grossRequirement, _workOrders);

                    _projAvailBalance := _inventory + _scheduledReceipt - _grossRequirement;


                    IF (_itemColour.GET("Item No.", "Color Code")) THEN
                        _itemColour.CALCFIELDS("Color Description")
                    ELSE
                        CLEAR(_itemColour);

                    IF (_itemSize.GET("Item No.", "Size Code")) THEN
                        _itemSize.CALCFIELDS("Size Description")
                    ELSE
                        CLEAR(_itemSize);

                    CLEAR(_value);


                    _value[1] := Item."No.";
                    //--SBC 10/26/17: Removed Original and added Function to GetUPCCode
                    _value[2] := Code;
                    //_value[4] := '';
                    _value[3] := GetUPCCode("Item Variant");
                    _value[4] := FORMAT(_projAvailBalance);
                    _value[5] := FORMAT(Item."Unit Price");
                    //++

                    OutputFileWrite(_value);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //BFC006 -

                IF (GUIALLOWED) AND NOT
                   (IsAutomated)
                THEN BEGIN
                    i += 1;
                    Dialogue.UPDATE(1, FORMAT("No."));
                    Dialogue.UPDATE(3, ROUND(i / j * 10000, 1));
                END;
                //BFC006 +
            end;

            trigger OnPreDataItem()
            begin
                FilterLocation := Item.GetFilter("Location Filter");
                DateFilter := Item.GetFilter("Date Filter");


                IF (GETFILTER("Date Filter") <> '') THEN
                    SETRANGE("Date Filter");

                IF (GETFILTER("Location Filter") <> '') THEN
                    SETRANGE("Location Filter");

                IF (GETFILTER("Variant Filter") <> '') THEN
                    SETRANGE("Variant Filter");

                //BFC006 -

                IF (ExportBrandGrp <> '') THEN
                    SETRANGE("LEE_Export Brand Group", ExportBrandGrp);

                //do not execute the report if it is called by automation
                //and the dataset is empty
                IF (ISEMPTY) AND
                   (IsAutomated)
                THEN BEGIN
                    // FILE.ERASE(ExportFileName);
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

    trigger OnPreReport()
    begin

        // IF (ExportFileName = '') THEN
        //     ERROR(Text00002);

        //BFC006 -
        IF (GUIALLOWED) THEN
            Dialogue.OPEN(Text00010);

        IF (GUIALLOWED) AND NOT
           (IsAutomated)
        THEN
            Dialogue.OPEN(Text00010);
        //BFC006 +

        OutputFileOpen();
        OutputFileWriteHdr();

    end;

    var
        Instr: InStream;
        Outstr: OutStream;
        TempBlob: Codeunit "Temp Blob";

        ExportFile: File;
        ExportFileOutStream: OutStream;
        Dialogue: Dialog;
        ExportBrandGrp: Code[20];
        ExportFileName: Text[250];
        FilterLocation: Text[1024];
        DateFilter: Text[250];
        Text00001: Label 'CORAL';
        Text00002: Label 'Export file name has not been specified.';
        Text00003: Label 'Export file specified already exists.  Overwrite?';
        Text00004: Label 'Data export %1.';
        Text00010: Label 'Exporting item data... One moment, please...\\Item     #1##########\Variant  #2##########\Progress @3@@@@@@@@@@\';
        FilterPdEnd: Date;
        FilterPdStart: Date;
        i: Integer;
        IsAutomated: Boolean;
        j: Integer;
        ExcludeTrimWO: Decimal;
        InventoryQty: Decimal;
        QtyOnSalesHeader: Decimal;
        QtyOnPurchaseHeader: Decimal;


    local procedure CalculateNeed(_itemNo: Code[20]; _variantCode: Code[20]; var _inventory: Decimal; var _plannedOrderReceipt: Decimal; var _scheduledReceipt: Decimal; var _grossRequirement: Decimal; var _workOrders: Decimal)
    var
        _item: Record Item;
        recItemVariant: Record "Item Variant";
    begin

        _inventory := 0;
        _plannedOrderReceipt := 0;
        _scheduledReceipt := 0;
        _grossRequirement := 0;

        IF (_itemNo = '') THEN
            EXIT;

        _item.GET(_itemNo);

        if recItemVariant.GET(_itemNo, _variantCode) then;

        _item.SetFilter("Date Filter", DateFilter);
        IF (FilterLocation <> '') THEN
            _item.SETFILTER("Location Filter", FilterLocation);
        _item.SETFILTER("Variant Filter", recItemVariant.Code);

        _item.CALCFIELDS(
          "Qty. on Purch. Order"
          , "Qty. on Sales Order"
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

        //_inventory := (_item.Inventory + _item."Qty. on Purch. Order") - (_item."Qty. on Sales Order");

        _inventory := _item.Inventory;

        _grossRequirement := _item."Qty. on Sales Order";

        _scheduledReceipt := _item."Qty. on Purch. Order";


    end;

    procedure OutputFileClose()
    begin
        // ExportFile.Close();
        TempBlob.CreateInStream(Instr, TextEncoding::Windows);
        DownloadFromStream(Instr, '', '', '', ExportFileName)
    end;

    procedure OutputFileOpen()
    begin
        ExportFileName := 'Inventory Brand Export.csv';
        TempBlob.CreateOutStream(Outstr, TextEncoding::Windows);

    end;

    procedure OutputFileWrite(_value: array[5] of Text[250])
    var
        _v: Integer;
    begin
        FOR _v := 1 TO ARRAYLEN(_value) DO BEGIN
            //write delimiter
            IF (_v > 1) THEN
                Outstr.WRITETEXT(',');
            //write value
            Outstr.WRITETEXT(_value[_v]);
        END;

        Outstr.WRITETEXT();    //new line
    end;

    procedure OutputFileWriteHdr()
    var
        _value: array[51] of Text[250];
    begin

        //define header row values and write to file

        _value[1] := 'SKU';
        _value[2] := 'Variant';
        _value[3] := 'UPC';
        _value[4] := 'Quantity';
        _value[5] := 'Wholesale Price';

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
        END;

    end;
}

