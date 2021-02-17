page 50022 "Items by Size Matrix"
{
    // version NAVW111.00.00.19846

    CaptionML = ENU = 'Items by Location Matrix',
                ESM = 'Matriz artículos por ubic.',
                FRC = 'Matrice Articles par emplacement',
                ENC = 'Items by Location Matrix';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Item Availability Line";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = '';
                field("Date Filter"; DateFilter)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Item.SETFILTER("Date Filter", DateFilter);
                        FindPeriod('');
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Location Filter"; LocationFilter)
                {
                    ApplicationArea = All;
                    TableRelation = Location;
                    trigger OnValidate();
                    begin
                        Item.SETFILTER("Location Filter", LocationFilter);
                        LocationFilter := Item.GETFILTER("Location Filter");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            repeater(group)
            {
                Editable = false;
                field(Name; Name)
                {
                    ApplicationArea = Location;
                    ToolTipML = ENU = 'Specifies the number of the involved entry or record, according to the specified number series.',
                                ESM = 'Especifica el número de la entrada o el registro relacionado, según la serie numérica especificada.',
                                FRC = 'Spécifie le numéro de l''écriture ou de l''enregistrement concerné, en fonction de la série de numéros spécifiée.',
                                ENC = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    DecimalPlaces = 0 : 5;
                    Visible = Field1Visible;

                    trigger OnDrillDown();
                    begin
                        // MatrixOnDrillDown(1);
                        LookupEntries();
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    DecimalPlaces = 0 : 5;
                    Visible = Field2Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(2);
                        LookupEntries();
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    DecimalPlaces = 0 : 5;
                    Visible = Field3Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(3);
                        LookupEntries();
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    DecimalPlaces = 0 : 5;
                    Visible = Field4Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(4);
                        LookupEntries();
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    DecimalPlaces = 0 : 5;
                    Visible = Field5Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(5);
                        LookupEntries();
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    DecimalPlaces = 0 : 5;
                    Visible = Field6Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    DecimalPlaces = 0 : 5;
                    Visible = Field7Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    DecimalPlaces = 0 : 5;
                    Visible = Field8Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    DecimalPlaces = 0 : 5;
                    Visible = Field9Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    DecimalPlaces = 0 : 5;
                    Visible = Field10Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    DecimalPlaces = 0 : 5;
                    Visible = Field11Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    DecimalPlaces = 0 : 5;
                    Visible = Field12Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];
                    DecimalPlaces = 0 : 5;
                    Visible = Field13Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    DecimalPlaces = 0 : 5;
                    Visible = Field14Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    DecimalPlaces = 0 : 5;
                    Visible = Field15Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    DecimalPlaces = 0 : 5;
                    Visible = Field16Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    DecimalPlaces = 0 : 5;
                    Visible = Field17Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    DecimalPlaces = 0 : 5;
                    Visible = Field18Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    DecimalPlaces = 0 : 5;
                    Visible = Field19Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    DecimalPlaces = 0 : 5;
                    Visible = Field20Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    DecimalPlaces = 0 : 5;
                    Visible = Field21Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    DecimalPlaces = 0 : 5;
                    Visible = Field22Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    DecimalPlaces = 0 : 5;
                    Visible = Field23Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    DecimalPlaces = 0 : 5;
                    Visible = Field24Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    DecimalPlaces = 0 : 5;
                    Visible = Field25Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    DecimalPlaces = 0 : 5;
                    Visible = Field26Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    DecimalPlaces = 0 : 5;
                    Visible = Field27Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    DecimalPlaces = 0 : 5;
                    Visible = Field28Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    DecimalPlaces = 0 : 5;
                    Visible = Field29Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[30];
                    DecimalPlaces = 0 : 5;
                    Visible = Field30Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    DecimalPlaces = 0 : 5;
                    Visible = Field31Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = Location;
                    BlankNumbers = BlankZero;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    DecimalPlaces = 0 : 5;
                    Visible = Field32Visible;

                    trigger OnDrillDown();
                    begin
                        //MatrixOnDrillDown(32);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 0;
        if TempMatrixItemSize.FINDSET then
            repeat
                MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
                MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
            until (TempMatrixItemSize.NEXT = 0) or (MATRIX_CurrentColumnOrdinal = MATRIX_NoOfMatrixColumns);
    end;

    trigger OnClosePage();
    begin

        if Item."No." <> '' then begin
            LastVariant := ItemVariant.Code;
        end;
    end;

    trigger OnInit();
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;

        LineNo := 1;
    end;

    trigger OnOpenPage();
    begin
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);


        // OPS23: Begin
        if not (SRSetup.FINDFIRST) then
            CLEAR(SRSetup);
        IF (SRSetup."Default Availability Location" <> '') THEN BEGIN
            LocationFilter := SRSetup."Default Availability Location";
            Item.SETFILTER("Location Filter", LocationFilter);
        END;
        // OPS23: End

        // AmountType := AmountType::"Balance at Date";
        //Sainath
        // FindPeriod('');
        LineInit(AvailType::All, Item);
        MakeWhat;
        // FindPeriod('');
    end;

    var
        MatrixRecords: array[32] of Record "Item Size";
        TempMatrixItemSize: Record "Item Size" temporary;
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_ColumnCaption: array[32] of Text[1024];
        MATRIX_CurrSetLength: Integer;
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        [InDataSet]
        Field21Visible: Boolean;
        [InDataSet]
        Field22Visible: Boolean;
        [InDataSet]
        Field23Visible: Boolean;
        [InDataSet]
        Field24Visible: Boolean;
        [InDataSet]
        Field25Visible: Boolean;
        [InDataSet]
        Field26Visible: Boolean;
        [InDataSet]
        Field27Visible: Boolean;
        [InDataSet]
        Field28Visible: Boolean;
        [InDataSet]
        Field29Visible: Boolean;
        [InDataSet]
        Field30Visible: Boolean;
        [InDataSet]
        Field31Visible: Boolean;
        [InDataSet]
        Field32Visible: Boolean;
        "-----------------": Integer;
        Itemsize: Record "Item Size";
        SRSetup: Record "Sales & Receivables Setup";
        Item: Record Item;
        ItemColor: Record "Item Color";
        ItemVariant: Record "Item Variant";
        Calendar: Record Date;
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesLine: Record "Sales Line";
        ServLine: Record "Service Line";
        PurchLine: Record "Purchase Line";
        TransLine: Record "Transfer Line";
        ReqLine: Record "Requisition Line";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        PlanningComponent: Record "Planning Component";
        AvailType: Option "Gross Requirement","Planned Order Receipt","Scheduled Order Receipt","Planned Order Release",All,"Packed Quantity";
        Sign: Integer;
        LineNo: Integer;
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;
        AmountType: Option "Net Change","Balance at Date";
        LastVariant: Code[10];
        ColumnValue: Decimal;
        DateFilter: Text[250];
        LocationFilter: Text[250];
        Item2: Record Item;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer);
    var
        TempItem: Record "Item Availability Line" temporary;
    begin

        ItemVariant.SETRANGE("Item No.", Item."No.");
        ItemVariant.SETRANGE("Color Code", ItemColor."Color Code");
        ItemVariant.SETRANGE("Size Code", MatrixRecords[ColumnID]."Size Code");
        if ItemVariant.FIND('-') then begin

            Item.SETRANGE("Variant Filter", ItemVariant.Code);

            case "Table No." of

                DATABASE::"Item Ledger Entry":
                    begin
                        Item.CALCFIELDS(Inventory);
                        MATRIX_CellData[ColumnID] := Item.Inventory;
                    end;

                DATABASE::"Sales Line":
                    begin
                        Item.CALCFIELDS("Qty. on Sales Order");
                        MATRIX_CellData[ColumnID] := -Item."Qty. on Sales Order";
                    end;

                //    DATABASE::"Package Line":BEGIN
                //      IF (Item2.GET(ItemVariant."Item No.")) THEN BEGIN
                //        Item2.SETRANGE(Item2."Variant Filter",ItemVariant.Code);
                //        Item2.CALCFIELDS("Qty. in Packages");
                //        MATRIX_CellData[ColumnID] := -Item2."Qty. in Packages";
                //      END;
                //    END;

                DATABASE::"Service Line":
                    begin
                        Item.CALCFIELDS("Qty. on Service Order");
                        MATRIX_CellData[ColumnID] := -Item."Qty. on Service Order";
                    end;

                DATABASE::"Prod. Order Component":
                    begin
                        Item.CALCFIELDS("Scheduled Need (Qty.)");
                        MATRIX_CellData[ColumnID] := -Item."Scheduled Need (Qty.)";
                    end;

                DATABASE::"Planning Component":
                    begin
                        Item.CALCFIELDS("Planning Issues (Qty.)");
                        MATRIX_CellData[ColumnID] := -Item."Planning Issues (Qty.)";
                    end;

                DATABASE::"Transfer Line":
                    begin
                        case QuerySource of
                            Item.FIELDNO("Trans. Ord. Shipment (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Trans. Ord. Shipment (Qty.)");
                                    MATRIX_CellData[ColumnID] := -Item."Trans. Ord. Shipment (Qty.)";
                                end;
                            Item.FIELDNO("Qty. in Transit"):
                                begin
                                    Item.CALCFIELDS("Qty. in Transit");
                                    MATRIX_CellData[ColumnID] := Item."Qty. in Transit";
                                end;
                            Item.FIELDNO("Trans. Ord. Receipt (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Trans. Ord. Receipt (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."Trans. Ord. Receipt (Qty.)";
                                end;
                        end;
                    end;

                //    DATABASE::"Kit Sales Line":BEGIN
                //      Item.CALCFIELDS("Qty. on Kit Sales Lines");
                //      MATRIX_CellData[ColumnID] := -Item."Qty. on Kit Sales Lines";
                //    END;

                DATABASE::"Requisition Line":
                    begin
                        case QuerySource of
                            // Item.FIELDNO("Purch. Req. Receipt (Qty.)"):
                            //     begin
                            //         Item.CALCFIELDS("Purch. Req. Receipt (Qty.)");
                            //         MATRIX_CellData[ColumnID] := Item."Purch. Req. Receipt (Qty.)";
                            //     end;
                            Item.FIELDNO("Purch. Req. Receipt (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Purch. Req. Receipt (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."Purch. Req. Receipt (Qty.)";
                                end;
                            Item.FIELDNO("Purch. Req. Release (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Purch. Req. Release (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."Purch. Req. Release (Qty.)";
                                end;
                            Item.FIELDNO("Planning Release (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Planning Release (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."Planning Release (Qty.)";
                                end;
                        end;
                    end;

                DATABASE::"Purchase Line":
                    begin
                        Item.CALCFIELDS("Qty. on Purch. Order");
                        MATRIX_CellData[ColumnID] := Item."Qty. on Purch. Order";
                    end;

                //    DATABASE::"BOM Journal Line": BEGIN
                //      Item.CALCFIELDS("Qty. on Work Order");
                //      MATRIX_CellData[ColumnID] := Item."Qty. on Work Order";
                //    END;

                //    DATABASE::/

                DATABASE::"Prod. Order Line":
                    begin
                        case QuerySource of
                            Item.FIELDNO("Planned Order Release (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Planned Order Release (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."Planned Order Release (Qty.)";
                                end;
                            Item.FIELDNO("Planned Order Receipt (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Planned Order Receipt (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."Planned Order Receipt (Qty.)";
                                end;
                            Item.FIELDNO("FP Order Receipt (Qty.)"):
                                begin
                                    Item.CALCFIELDS("FP Order Receipt (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."FP Order Receipt (Qty.)";
                                end;
                            Item.FIELDNO("Rel. Order Receipt (Qty.)"):
                                begin
                                    Item.CALCFIELDS("Rel. Order Receipt (Qty.)");
                                    MATRIX_CellData[ColumnID] := Item."Rel. Order Receipt (Qty.)";
                                end;
                        end;
                    end;


                999999998:
                    MATRIX_CellData[ColumnID] := 0;

                999999999:
                    begin
                        Item.CALCFIELDS(Inventory,
                          "Qty. on Purch. Order",
                          "Qty. on Sales Order",
                          //"Qty. on Kit Sales Lines",
                          "Qty. on Service Order",
                          "Net Change",
                          "Scheduled Receipt (Qty.)",
                          "Scheduled Need (Qty.)",
                          "Planned Order Receipt (Qty.)",
                          "FP Order Receipt (Qty.)",
                          "Rel. Order Receipt (Qty.)",
                          "Planned Order Release (Qty.)",
                          "Purch. Req. Receipt (Qty.)",
                          "Planning Issues (Qty.)",
                          "Purch. Req. Release (Qty.)",
                          "Qty. in Transit",
                          "Trans. Ord. Shipment (Qty.)",
                          "Trans. Ord. Receipt (Qty.)");

                        //      Item.CALCFIELDS("Qty. on Work Order",
                        //                      "Qty. in Packages",
                        //                      "Qty. on WO Kit Lines");
                        //      WITH Item DO
                        //        MATRIX_CellData[ColumnID] := (
                        //          Inventory +
                        //          "Qty. on Purch. Order" +
                        //          "Scheduled Receipt (Qty.)" +
                        //          "Planned Order Receipt (Qty.)" +
                        //          "FP Order Receipt (Qty.)" +
                        //          "Rel. Order Receipt (Qty.)" +
                        //          "Planned Order Release (Qty.)" +
                        //          "Purch. Req. Receipt (Qty.)" +
                        //          "Purch. Req. Release (Qty.)" +
                        //          "Qty. in Transit" +
                        //          "Trans. Ord. Receipt (Qty.)" +
                        //          "Qty. on Work Order") -
                        //
                        //          ("Qty. in Packages"+
                        //          "Qty. on Sales Order" +
                        //          "Qty. on Service Order" +
                        //          "Scheduled Need (Qty.)" +
                        //          "Planning Issues (Qty.)" +
                        //          "Trans. Ord. Shipment (Qty.)"+
                        //          "Qty. on Kit Sales Lines" +
                        //          "Qty. on WO Kit Lines");
                    end;
            end;
        end else
            MATRIX_CellData[ColumnID] := 0;

        // MATRIX_CellData[ColumnID] := 1;
        SetVisible;
    end;

    // [Scope('Personalization')]
    procedure Load(MatrixColumns1: array[32] of Text[1024]; var MatrixRecords1: array[32] of Record "Item Size"; var MatrixRecord1: Record "Item Size"; CurrSetLength: Integer);
    begin
        MATRIX_CurrSetLength := CurrSetLength;
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        COPYARRAY(MatrixRecords, MatrixRecords1, 1);
        TempMatrixItemSize.COPY(MatrixRecord1, true);
    end;

    local procedure MatrixOnDrillDown(ColumnID: Integer);
    begin
        // ItemLedgerEntry.SETCURRENTKEY(
        //  "Item No.","Entry Type","Variant Code","Drop Shipment","Location Code","Posting Date");
        // ItemLedgerEntry.SETRANGE("Item No.","No.");
        // ItemLedgerEntry.SETRANGE("Location Code",MatrixRecords[ColumnID].Code);
        // PAGE.RUN(0,ItemLedgerEntry);
    end;

    // [Scope('Personalization')]
    procedure SetVisible();
    begin
        Field1Visible := MATRIX_CurrSetLength > 0;
        Field2Visible := MATRIX_CurrSetLength > 1;
        Field3Visible := MATRIX_CurrSetLength > 2;
        Field4Visible := MATRIX_CurrSetLength > 3;
        Field5Visible := MATRIX_CurrSetLength > 4;
        Field6Visible := MATRIX_CurrSetLength > 5;
        Field7Visible := MATRIX_CurrSetLength > 6;
        Field8Visible := MATRIX_CurrSetLength > 7;
        Field9Visible := MATRIX_CurrSetLength > 8;
        Field10Visible := MATRIX_CurrSetLength > 9;
        Field11Visible := MATRIX_CurrSetLength > 10;
        Field12Visible := MATRIX_CurrSetLength > 11;
        Field13Visible := MATRIX_CurrSetLength > 12;
        Field14Visible := MATRIX_CurrSetLength > 13;
        Field15Visible := MATRIX_CurrSetLength > 14;
        Field16Visible := MATRIX_CurrSetLength > 15;
        Field17Visible := MATRIX_CurrSetLength > 16;
        Field18Visible := MATRIX_CurrSetLength > 17;
        Field19Visible := MATRIX_CurrSetLength > 18;
        Field20Visible := MATRIX_CurrSetLength > 19;
        Field21Visible := MATRIX_CurrSetLength > 20;
        Field22Visible := MATRIX_CurrSetLength > 21;
        Field23Visible := MATRIX_CurrSetLength > 22;
        Field24Visible := MATRIX_CurrSetLength > 23;
        Field25Visible := MATRIX_CurrSetLength > 24;
        Field26Visible := MATRIX_CurrSetLength > 25;
        Field27Visible := MATRIX_CurrSetLength > 26;
        Field28Visible := MATRIX_CurrSetLength > 27;
        Field29Visible := MATRIX_CurrSetLength > 28;
        Field30Visible := MATRIX_CurrSetLength > 29;
        Field31Visible := MATRIX_CurrSetLength > 30;
        Field32Visible := MATRIX_CurrSetLength > 31;
    end;

    local procedure "----------------"();
    begin
    end;

    local procedure FindPeriod(SearchText: Code[10]);
    var
        PeriodFormMgt: Codeunit PeriodFormManagement;
    begin
        if Item.GETFILTER("Date Filter") <> '' then begin
            Calendar.SETFILTER("Period Start", Item.GETFILTER("Date Filter"));
            if not PeriodFormMgt.FindDate('+', Calendar, ItemPeriodLength) then
                PeriodFormMgt.FindDate('+', Calendar, ItemPeriodLength::Day);
            Calendar.SETRANGE("Period Start");
        end;
        PeriodFormMgt.FindDate(SearchText, Calendar, ItemPeriodLength);
        if AmountType = AmountType::"Net Change" then begin
            Item.SETRANGE("Date Filter", Calendar."Period Start", Calendar."Period End");
            if Item.GETRANGEMIN("Date Filter") = Item.GETRANGEMAX("Date Filter") then
                Item.SETRANGE("Date Filter", Item.GETRANGEMIN("Date Filter"));
        end else
            Item.SETRANGE("Date Filter", 0D, Calendar."Period End");
        DateFilter := Item.GETFILTER("Date Filter");
    end;

    procedure GetLastVariant(): Code[10];
    begin
        exit(LastVariant);
    end;

    procedure LineInit(NewType: Option "Gross Requirement","Planned Order Receipt","Scheduled Order Receipt","Planned Order Release",All,"Packed Quantity"; var NewItem: Record Item);
    begin
        AvailType := NewType;
        //Item.COPY(NewItem);
    end;

    local procedure MakeEntries();
    begin
        case AvailType of
            AvailType::"Packed Quantity":
                begin
                    //      Item.CALCFIELDS("Qty. in Packages"); CV_PS
                    //      InsertEntry(
                    //        DATABASE::"Package Line",
                    //        Item.FIELDNO("Qty. in Packages"),
                    //        Item.FIELDCAPTION("Qty. in Packages"),
                    //        Item."Qty. in Packages");

                end;
            AvailType::"Gross Requirement":
                begin
                    InsertEntry(
                      DATABASE::"Sales Line",
                      Item.FIELDNO("Qty. on Sales Order"),
                      Item.FIELDCAPTION("Qty. on Sales Order"),
                      Item."Qty. on Sales Order");


                    /*
                          InsertEntry(
                            DATABASE::"Service Line",
                            Item.FIELDNO("Qty. on Service Order"),
                            ServLine.TABLECAPTION,
                            Item."Qty. on Service Order");
                          InsertEntry(
                            DATABASE::"Prod. Order Component",
                            Item.FIELDNO("Scheduled Need (Qty.)"),
                            ProdOrderComp.TABLECAPTION,
                            Item."Scheduled Need (Qty.)");
                          InsertEntry(
                            DATABASE::"Planning Component",
                            Item.FIELDNO("Planning Issues (Qty.)"),
                            PlanningComponent.TABLECAPTION,
                            Item."Planning Issues (Qty.)");
                          InsertEntry(
                            DATABASE::"Transfer Line",
                            Item.FIELDNO("Trans. Ord. Shipment (Qty.)"),
                            Item.FIELDCAPTION("Trans. Ord. Shipment (Qty.)"),
                            Item."Trans. Ord. Shipment (Qty.)");
                    */
                    //      InsertEntry(
                    //        DATABASE::"Kit Sales Line",
                    //        Item.FIELDNO("Qty. on Kit Sales Lines"),
                    //        Item.FIELDCAPTION("Qty. on Kit Sales Lines"),
                    //        Item."Qty. on Kit Sales Lines");
                    //      InsertEntry(
                    //        DATABASE::"Kit BOM Journal Line",
                    //        Item.FIELDNO("Qty. on Kit Sales Lines"),
                    //        Item.FIELDCAPTION("Qty. on WO Kit Lines"),
                    //        Item."Qty. on WO Kit Lines");
                end;
            AvailType::"Planned Order Receipt":
                begin
                    /*
                          InsertEntry(
                            DATABASE::"Requisition Line",
                            Item.FIELDNO("Purch. Req. Receipt (Qty.)"),
                            ReqLine.TABLECAPTION,
                            Item."Purch. Req. Receipt (Qty.)");
                          InsertEntry(
                            DATABASE::"Prod. Order Line",
                            Item.FIELDNO("Planned Order Receipt (Qty.)"),
                            STRSUBSTNO(Text000,ProdOrderLine.TABLECAPTION),
                            Item."Planned Order Receipt (Qty.)");
                    */
                end;
            AvailType::"Planned Order Release":
                begin
                    /*
                          InsertEntry(
                            DATABASE::"Requisition Line",
                            Item.FIELDNO("Purch. Req. Release (Qty.)"),
                            ReqLine.TABLECAPTION,
                            Item."Purch. Req. Release (Qty.)");
                          InsertEntry(
                            DATABASE::"Prod. Order Line",
                            Item.FIELDNO("Planned Order Release (Qty.)"),
                            STRSUBSTNO(Text001,ProdOrderLine.TABLECAPTION),
                            Item."Planned Order Release (Qty.)");
                          InsertEntry(
                            DATABASE::"Requisition Line",
                            Item.FIELDNO("Planning Release (Qty.)"),
                            ReqLine.TABLECAPTION,
                            Item."Planning Release (Qty.)");
                    */
                end;
            AvailType::"Scheduled Order Receipt":
                begin
                    InsertEntry(
                      DATABASE::"Purchase Line",
                      Item.FIELDNO("Qty. on Purch. Order"),
                      Item.FIELDCAPTION("Qty. on Purch. Order"),
                      1);

                    //      InsertEntry(
                    //        DATABASE::"BOM Journal Line",
                    //        Item.FIELDNO("Qty. on Work Order"),
                    //        Item.FIELDCAPTION("Qty. on Work Order"),
                    //        Item."Qty. on Work Order");



                    /*
                          InsertEntry(
                            DATABASE::"Prod. Order Line",
                            Item.FIELDNO("FP Order Receipt (Qty.)"),
                            STRSUBSTNO(Text002,ProdOrderLine.TABLECAPTION),
                            Item."FP Order Receipt (Qty.)");
                          InsertEntry(
                            DATABASE::"Prod. Order Line",
                            Item.FIELDNO("Rel. Order Receipt (Qty.)"),
                            STRSUBSTNO(Text003,ProdOrderLine.TABLECAPTION),
                            Item."Rel. Order Receipt (Qty.)");
                          InsertEntry(
                            DATABASE::"Transfer Line",
                            Item.FIELDNO("Qty. in Transit"),
                            Item.FIELDCAPTION("Qty. in Transit"),
                            Item."Qty. in Transit");
                          InsertEntry(
                            DATABASE::"Transfer Line",
                            Item.FIELDNO("Trans. Ord. Receipt (Qty.)"),
                            Item.FIELDCAPTION("Trans. Ord. Receipt (Qty.)"),
                            Item."Trans. Ord. Receipt (Qty.)");
                    */

                end;
        end;

    end;

    local procedure MakeWhat();
    begin
        Sign := 1;
        if AvailType <> AvailType::All then
            MakeEntries
        else begin
            Item.SETRANGE("Date Filter", 0D, Item.GETRANGEMAX("Date Filter"));
            Item.CALCFIELDS(
              "Qty. on Sales Order",
              //    "Qty. on Kit Sales Lines",CV_PS
              "Qty. on Service Order",
              "Net Change",
              "Scheduled Receipt (Qty.)",
              "Scheduled Need (Qty.)",
              "Planned Order Receipt (Qty.)",
              "FP Order Receipt (Qty.)",
              "Rel. Order Receipt (Qty.)",
              "Planned Order Release (Qty.)",
              "Purch. Req. Receipt (Qty.)",
              "Planning Issues (Qty.)",
              "Purch. Req. Release (Qty.)",
              "Qty. in Transit",
              "Trans. Ord. Shipment (Qty.)",
              "Trans. Ord. Receipt (Qty.)");
            //    "Qty. in Packages",CV_PS
            //    "Qty. on Work Order");CV_PS

            //"Table No." := DATABASE::"Item Ledger Entry";

            InsertEntry(999999998,
                        999999998,
                        'Supply',
                        1);

            InsertEntry(DATABASE::"Item Ledger Entry",
                        Item.FIELDNO(Inventory),
                        Item.FIELDCAPTION(Inventory),
                        1);

            AvailType := AvailType::"Planned Order Receipt";
            Sign := 1;
            MakeEntries;

            AvailType := AvailType::"Scheduled Order Receipt";
            Sign := 1;
            MakeEntries;

            InsertEntry(999999998,
                        999999998,
                        'Demand',
                        1);

            AvailType := AvailType::"Gross Requirement";
            Sign := -1;
            MakeEntries;

            AvailType := AvailType::"Packed Quantity";
            Sign := 1;
            MakeEntries;

            InsertEntry(999999998,
                        999999998,
                        '----------',
                        1);
            InsertEntry(999999999,
                        999999999,
                        'Open to Sell',
                        1);

            AvailType := AvailType::All;

        end;
    end;

    local procedure LookupEntries();
    begin
        case "Table No." of
            DATABASE::"Item Ledger Entry":
                begin
                    ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                    ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                    ItemLedgerEntry.SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
                    ItemLedgerEntry.SETFILTER("Drop Shipment", Item.GETFILTER("Drop Shipment Filter"));
                    ItemLedgerEntry.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                    ItemLedgerEntry.SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
                    ItemLedgerEntry.SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
                    PAGE.RUNMODAL(0, ItemLedgerEntry);
                end;
            DATABASE::"Sales Line":
                begin
                    SalesLine.SETCURRENTKEY("Document Type", Type, "No.");
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    SalesLine.SETRANGE("No.", Item."No.");
                    Item.COPYFILTER("Variant Filter", SalesLine."Variant Code");
                    SalesLine.SETRANGE("Drop Shipment", false);
                    //      SalesLine.SETRANGE("Build Kit",FALSE);
                    Item.COPYFILTER("Date Filter", SalesLine."Shipment Date");
                    Item.COPYFILTER("Location Filter", SalesLine."Location Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", SalesLine."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", SalesLine."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, SalesLine);
                end;
            DATABASE::"Service Line":
                begin
                    ServLine.SETCURRENTKEY(Type, "No.", "Variant Code", "Location Code", "Posting Date");
                    ServLine.SETRANGE("Document Type", ServLine."Document Type"::Order);
                    ServLine.SETRANGE(Type, ServLine.Type::Item);
                    ServLine.SETRANGE("No.", Item."No.");
                    Item.COPYFILTER("Variant Filter", ServLine."Variant Code");
                    Item.COPYFILTER("Date Filter", ServLine."Posting Date");
                    Item.COPYFILTER("Location Filter", ServLine."Location Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", ServLine."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", ServLine."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, ServLine);
                end;
            DATABASE::"Purchase Line":
                begin
                    PurchLine.SETCURRENTKEY("Document Type", Type, "No.");
                    PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SETRANGE(Type, SalesLine.Type::Item);
                    PurchLine.SETRANGE("No.", Item."No.");
                    Item.COPYFILTER("Variant Filter", PurchLine."Variant Code");
                    PurchLine.SETRANGE("Drop Shipment", false);
                    Item.COPYFILTER("Date Filter", PurchLine."Expected Receipt Date");
                    Item.COPYFILTER("Location Filter", PurchLine."Location Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", PurchLine."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", PurchLine."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, PurchLine);
                end;
            DATABASE::"Transfer Line":
                begin
                    case QuerySource of
                        Item.FIELDNO("Trans. Ord. Shipment (Qty.)"):
                            begin
                                TransLine.SETCURRENTKEY(
                                  "Transfer-from Code", Status, "Derived From Line No.",
                                  "Item No.", "Variant Code",
                                  "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
                                  "Shipment Date", "In-Transit Code");
                                Item.COPYFILTER("Location Filter", TransLine."Transfer-from Code");
                                Item.COPYFILTER("Date Filter", TransLine."Shipment Date");
                            end;
                        Item.FIELDNO("Trans. Ord. Receipt (Qty.)"), Item.FIELDNO("Qty. in Transit"):
                            begin
                                TransLine.SETCURRENTKEY(
                                  "Transfer-to Code", Status, "Derived From Line No.",
                                  "Item No.", "Variant Code",
                                  "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code",
                                  "Receipt Date", "In-Transit Code");
                                Item.COPYFILTER("Location Filter", TransLine."Transfer-to Code");
                                Item.COPYFILTER("Date Filter", TransLine."Receipt Date");
                            end;
                    end;
                    TransLine.SETRANGE("Item No.", Item."No.");
                    TransLine.SETRANGE("Derived From Line No.", 0);
                    Item.COPYFILTER("Variant Filter", TransLine."Variant Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", TransLine."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", TransLine."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, TransLine);
                end;
            DATABASE::"Planning Component":
                begin
                    PlanningComponent.SETCURRENTKEY("Item No.");
                    PlanningComponent.SETRANGE("Item No.", Item."No.");
                    PlanningComponent.SETRANGE("Planning Line Origin", PlanningComponent."Planning Line Origin"::" ");
                    Item.COPYFILTER("Variant Filter", PlanningComponent."Variant Code");
                    Item.COPYFILTER("Date Filter", PlanningComponent."Due Date");
                    Item.COPYFILTER("Location Filter", PlanningComponent."Location Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", PlanningComponent."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", PlanningComponent."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, PlanningComponent);
                end;
            DATABASE::"Prod. Order Component":
                begin
                    ProdOrderComp.SETCURRENTKEY("Item No.", "Variant Code", "Location Code",
                      Status, "Due Date");
                    ProdOrderComp.SETRANGE(
                      Status,
                      ProdOrderComp.Status::Planned,
                      ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Item No.", Item."No.");
                    Item.COPYFILTER("Variant Filter", ProdOrderComp."Variant Code");
                    Item.COPYFILTER("Date Filter", ProdOrderComp."Due Date");
                    Item.COPYFILTER("Location Filter", ProdOrderComp."Location Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", ProdOrderComp."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", ProdOrderComp."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, ProdOrderComp);
                end;
            DATABASE::"Requisition Line":
                begin
                    ReqLine.SETRANGE("Planning Line Origin", ReqLine."Planning Line Origin"::" ");
                    case QuerySource of
                        Item.FIELDNO("Purch. Req. Receipt (Qty.)"):
                            begin
                                ReqLine.SETCURRENTKEY(
                                  Type, "No.", "Variant Code", "Location Code",
                                  "Sales Order No.", ReqLine."Planning Line Origin", "Due Date");
                                Item.COPYFILTER("Date Filter", ReqLine."Due Date");
                            end;
                        Item.FIELDNO("Purch. Req. Release (Qty.)"):
                            begin
                                ReqLine.SETCURRENTKEY(
                                  Type, "No.", "Variant Code", "Location Code", "Sales Order No.", "Order Date");
                                Item.COPYFILTER("Date Filter", ReqLine."Order Date");
                                ReqLine.SETFILTER("Planning Line Origin", '%1 | %2',
                                  ReqLine."Planning Line Origin"::" ", ReqLine."Planning Line Origin"::Planning);
                            end;
                    end;
                    ReqLine.SETRANGE(Type, ReqLine.Type::Item);
                    ReqLine.SETRANGE("No.", Item."No.");
                    ReqLine.SETRANGE("Sales Order No.", '');
                    Item.COPYFILTER("Variant Filter", ReqLine."Variant Code");
                    Item.COPYFILTER("Location Filter", ReqLine."Location Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", ReqLine."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", ReqLine."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, ReqLine);
                end;
            DATABASE::"Prod. Order Line":
                begin
                    ProdOrderLine.RESET;
                    ProdOrderLine.SETCURRENTKEY(Status, "Item No.");
                    case QuerySource of
                        Item.FIELDNO("Planned Order Receipt (Qty.)"):
                            begin
                                ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Planned);
                                Item.COPYFILTER("Date Filter", ProdOrderLine."Due Date");
                            end;
                        Item.FIELDNO("Planned Order Release (Qty.)"):
                            begin
                                ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Planned);
                                Item.COPYFILTER("Date Filter", ProdOrderLine."Starting Date");
                            end;
                        Item.FIELDNO("FP Order Receipt (Qty.)"):
                            begin
                                ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::"Firm Planned");
                                Item.COPYFILTER("Date Filter", ProdOrderLine."Due Date");
                            end;
                        Item.FIELDNO("Rel. Order Receipt (Qty.)"):
                            begin
                                ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
                                Item.COPYFILTER("Date Filter", ProdOrderLine."Due Date");
                            end;
                    end;
                    ProdOrderLine.SETRANGE("Item No.", Item."No.");
                    Item.COPYFILTER("Variant Filter", ProdOrderLine."Variant Code");
                    Item.COPYFILTER("Location Filter", ProdOrderLine."Location Code");
                    Item.COPYFILTER("Global Dimension 1 Filter", ProdOrderLine."Shortcut Dimension 1 Code");
                    Item.COPYFILTER("Global Dimension 2 Filter", ProdOrderLine."Shortcut Dimension 2 Code");
                    PAGE.RUNMODAL(0, ProdOrderLine);
                end;
        //>>CV_PS
        //  DATABASE::"Kit Sales Line":
        //    BEGIN
        //      KitSalesLine.SETCURRENTKEY("Document Type",Type,"No.");
        //      KitSalesLine.SETRANGE("Document Type",KitSalesLine."Document Type"::Order);
        //      KitSalesLine.SETRANGE(Type,KitSalesLine.Type::Item);
        //      KitSalesLine.SETRANGE("No.",Item."No.");
        //      Item.COPYFILTER("Variant Filter",KitSalesLine."Variant Code");
        //      Item.COPYFILTER("Date Filter",KitSalesLine."Shipment Date");
        //      Item.COPYFILTER("Location Filter",KitSalesLine."Location Code");
        //      Item.COPYFILTER("Global Dimension 1 Filter",KitSalesLine."Shortcut Dimension 1 Code");
        //      Item.COPYFILTER("Global Dimension 2 Filter",KitSalesLine."Shortcut Dimension 2 Code");
        //      PAGE.RUNMODAL(0,KitSalesLine);
        //    END;
        //  DATABASE::"BOM Journal Line":
        //    BEGIN
        //      BOMJnlLine.SETCURRENTKEY("Item No.", "Variant Code", "Location Code",
        //                               "Bin Code", "Production Status", "Expected Completion Date");
        //      BOMJnlLine.SETRANGE("Item No.", Item."No.");
        //      Item.COPYFILTER("Variant Filter", BOMJnlLine."Variant Code");
        //      Item.COPYFILTER("Date Filter", BOMJnlLine."Expected Completion Date");
        //      Item.COPYFILTER("Location Filter", BOMJnlLine."Location Code");
        //      Item.COPYFILTER("Global Dimension 1 Filter", BOMJnlLine."Shortcut Dimension 1 Code");
        //      Item.COPYFILTER("Global Dimension 2 Filter", BOMJnlLine."Shortcut Dimension 2 Code");
        //      PAGE.RUNMODAL(0, BOMJnlLine);
        //    END;
        //  DATABASE::"Package Line":
        //    BEGIN
        //      PackageLine.SETCURRENTKEY(Type,"No.","Variant Code","Color Code","Size Code");
        //      PackageLine.SETRANGE(PackageLine.Type,PackageLine.Type::Item);
        //      PackageLine.SETRANGE(PackageLine."No.",Item."No.");
        //      Item.COPYFILTER("Variant Filter", PackageLine."Variant Code");
        //      PAGE.RUNMODAL(0, PackageLine);
        //    END;
        //<<CV_PS
        end;
    end;

    local procedure InsertEntry("Table": Integer; "Field": Integer; TableName: Text[100]; Qty: Decimal);
    begin
        //IF Qty = 0 THEN EXIT;

        "Table No." := Table;
        QuerySource := Field;
        Name := TableName;
        Quantity := Qty * Sign;
        "Line No." := LineNo;
        INSERT;
        LineNo += 1;
    end;

    procedure SetItemColor(ItemNo: Code[20]; ColorCode: Code[10]);
    begin
        if not (Item.GET(ItemNo)) then
            CLEAR(Item);

        if not (ItemColor.GET(ItemNo, ColorCode)) then
            CLEAR(ItemColor);

        // CurrForm.SizeMatrix.MatrixRec.SETRANGE("Item No.",ItemNo);
        // CurrForm.SizeMatrix.MatrixRec.SETCURRENTKEY("Size Sort Order");
        // CurrForm.CAPTION := Item."No." + ' ' + Item.Description + ' - ' + ItemColor."Color Code" + ' - Avail. by Size';
    end;

    procedure RefreshForm();
    begin
        CurrPage.UPDATE(false);
    end;
}

