report 50030 "Item Availability by Color"
{

    DefaultLayout = RDLC;
    Caption = 'Item Availability by Color';
    RDLCLayout = './ItemAvailabilitybyColor.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Description", "Item Category Code", "Date Filter", "Location Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(FILTERS______Item_GETFILTERS; 'FILTERS: ' + Item.GetFilters)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(SizeLabel_5_; SizeLabel[5])
            {
            }
            column(SizeLabel_4_; SizeLabel[4])
            {
            }
            column(SizeLabel_3_; SizeLabel[3])
            {
            }
            column(SizeLabel_2_; SizeLabel[2])
            {
            }
            column(SizeLabel_1_; SizeLabel[1])
            {
            }
            column(Item_Availability_by_ColorCaption; Item_Availability_by_ColorCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_No___Caption; Item_No___CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Item_Color__Color_Code_Caption; "Item Color".FieldCaption("Color Code"))
            {
            }
            column(SizesCaption; SizesCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem("Item Color"; "Item Color")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Color Sort Order") ORDER(Ascending);
                column(SizeLabel_5__Control1000000092; SizeLabel[5])
                {
                }
                column(SizeLabel_4__Control1000000094; SizeLabel[4])
                {
                }
                column(SizeLabel_3__Control1000000095; SizeLabel[3])
                {
                }
                column(SizeLabel_2__Control1000000096; SizeLabel[2])
                {
                }
                column(Item_Description_Control1000000097; Item.Description)
                {
                }
                column(SizeLabel_1__Control1000000098; SizeLabel[1])
                {
                }
                column(Item__No___Control1000000099; Item."No.")
                {
                }
                column(Item_Color__Color_Code_; "Color Code")
                {
                }
                column(Item_Color__Color_Description_; "Color Description")
                {
                }
                column(QtyOnHand_1_; QtyOnHand[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnHandTotal; QtyOnHandTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnHand_7_; QtyOnHand[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnHand_6_; QtyOnHand[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnHand_5_; QtyOnHand[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnHand_4_; QtyOnHand[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnHand_3_; QtyOnHand[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnHand_2_; QtyOnHand[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrder_1_; QtyOnPurchOrder[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrder_1_; QtyOnWorkOrder[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrder_1_; QtyOnSalesOrder[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLines_1_; QtyOnKitSalesLines[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLines_1_; QtyOnWorkOrderKitLines[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrder_2_; QtyOnPurchOrder[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrder_2_; QtyOnWorkOrder[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrder_2_; QtyOnSalesOrder[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLines_2_; QtyOnKitSalesLines[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLines_2_; QtyOnWorkOrderKitLines[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrder_3_; QtyOnPurchOrder[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrder_3_; QtyOnWorkOrder[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrder_3_; QtyOnSalesOrder[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLines_3_; QtyOnKitSalesLines[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLines_3_; QtyOnWorkOrderKitLines[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrder_4_; QtyOnPurchOrder[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrder_4_; QtyOnWorkOrder[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrder_4_; QtyOnSalesOrder[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLines_4_; QtyOnKitSalesLines[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLines_4_; QtyOnWorkOrderKitLines[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrder_5_; QtyOnPurchOrder[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrder_5_; QtyOnWorkOrder[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrder_5_; QtyOnSalesOrder[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLines_5_; QtyOnKitSalesLines[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLines_5_; QtyOnWorkOrderKitLines[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrder_6_; QtyOnPurchOrder[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrder_6_; QtyOnWorkOrder[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrder_6_; QtyOnSalesOrder[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLines_6_; QtyOnKitSalesLines[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLines_6_; QtyOnWorkOrderKitLines[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrder_7_; QtyOnPurchOrder[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrder_7_; QtyOnWorkOrder[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrder_7_; QtyOnSalesOrder[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLines_7_; QtyOnKitSalesLines[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLines_7_; QtyOnWorkOrderKitLines[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnPurchOrderTotal; QtyOnPurchOrderTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderTotal; QtyOnWorkOrderTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnSalesOrderTotal; QtyOnSalesOrderTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnKitSalesLinesTotal; QtyOnKitSalesLinesTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyOnWorkOrderKitLinesTotal; QtyOnWorkOrderKitLinesTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackages_1_; QtyInPackages[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackages_2_; QtyInPackages[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackages_3_; QtyInPackages[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackages_4_; QtyInPackages[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackages_5_; QtyInPackages[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackages_6_; QtyInPackages[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackages_7_; QtyInPackages[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(QtyInPackagesTotal; QtyInPackagesTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSellTotal; OpenToSellTotal)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSell_7_; OpenToSell[7])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSell_6_; OpenToSell[6])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSell_5_; OpenToSell[5])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSell_4_; OpenToSell[4])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSell_3_; OpenToSell[3])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSell_2_; OpenToSell[2])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(OpenToSell_1_; OpenToSell[1])
                {
                    DecimalPlaces = 0 : 2;
                }
                column(CONT_D_Caption; CONT_D_CaptionLbl)
                {
                }
                column(TotalCaption_Control1000000017; TotalCaption_Control1000000017Lbl)
                {
                }
                column(SupplyCaption; SupplyCaptionLbl)
                {
                }
                column(Quantity_on_HandCaption; Quantity_on_HandCaptionLbl)
                {
                }
                column(Qty__on_Purch__OrderCaption; Qty__on_Purch__OrderCaptionLbl)
                {
                }
                column(DemandCaption; DemandCaptionLbl)
                {
                }
                column(Qty__on_Work_OrderCaption; Qty__on_Work_OrderCaptionLbl)
                {
                }
                column(Qty__on_Sales_OrderCaption; Qty__on_Sales_OrderCaptionLbl)
                {
                }
                column(Qty__on_Kit_Sales_LinesCaption; Qty__on_Kit_Sales_LinesCaptionLbl)
                {
                }
                column(Qty__on_WO_Kit_LinesCaption; Qty__on_WO_Kit_LinesCaptionLbl)
                {
                }
                column(Qty__in_PackagesCaption; Qty__in_PackagesCaptionLbl)
                {
                }
                column(Open_to_SellCaption; Open_to_SellCaptionLbl)
                {
                }
                column(Item_Color_Item_No_; "Item No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CLEAR(QtyOnHand);
                    CLEAR(QtyOnHandTotal);
                    CLEAR(QtyOnPurchOrder);
                    CLEAR(QtyOnPurchOrderTotal);
                    CLEAR(QtyOnWorkOrder);
                    CLEAR(QtyOnWorkOrderTotal);
                    CLEAR(QtyInPackages);


                    CLEAR(QtyOnSalesOrder);
                    CLEAR(QtyOnSalesOrderTotal);
                    CLEAR(OpenToSell);
                    CLEAR(OpenToSellTotal);

                    ItemSize.SETCURRENTKEY("Item No.", "Size Sort Order");
                    ItemSize.SETRANGE("Item No.", "Item No.");
                    IF (ItemSize.FINDSET(FALSE, FALSE)) THEN BEGIN

                        CALCFIELDS("Variant Assignment Code");
                        SizeIdx := 1;

                        CLEAR(Item2);
                        Item2.COPYFILTERS(Item);
                        Item2.SETRANGE("No.", Item."No.");
                        REPEAT
                            ItemSize.CALCFIELDS("Variant Assignment Code");

                            VariantCode := "Variant Assignment Code" +
                                           ItemVarSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code";

                            Item2.SETFILTER("Variant Filter", VariantCode);
                            Item2.FINDFIRST;

                            Item2.CALCFIELDS(Inventory,
                                             "Qty. on Purch. Order",
                                             "Qty. on Sales Order");


                            Item3.GET(Item2."No.");
                            Item3.SETFILTER(Item3."Variant Filter", VariantCode);

                            // Supply
                            Sign := 1;
                            QtyOnHand[SizeIdx] := Item2.Inventory * Sign;
                            QtyOnPurchOrder[SizeIdx] := Item2."Qty. on Purch. Order" * Sign;

                            // Demand
                            Sign := -1;
                            QtyOnSalesOrder[SizeIdx] := Item2."Qty. on Sales Order" * Sign;

                            // Open to Sell
                            OpenToSell[SizeIdx] := QtyOnHand[SizeIdx] +
                                                   QtyOnPurchOrder[SizeIdx] +
                                                   QtyOnWorkOrder[SizeIdx] +
                                                   QtyOnSalesOrder[SizeIdx];
                            //QtyInPackages not included because it is included in Sales Lines
                            SizeIdx += 1;

                        UNTIL (ItemSize.NEXT = 0)
                         OR (SizeIdx > ARRAYLEN(SizeLabel));

                        QtyOnHandTotal := GetArrayTotal(QtyOnHand);
                        QtyOnPurchOrderTotal := GetArrayTotal(QtyOnPurchOrder);
                        QtyOnWorkOrderTotal := GetArrayTotal(QtyOnWorkOrder);
                        QtyOnSalesOrderTotal := GetArrayTotal(QtyOnSalesOrder);
                        OpenToSellTotal := GetArrayTotal(OpenToSell);

                        IF (ExportToExcel) THEN BEGIN
                            IF (ShowDetail) THEN BEGIN
                                FOR Idx := 1 TO 5 DO BEGIN
                                    RowNo += 1;
                                    ColNo := 1;

                                    EnterCell(RowNo, ColNo, "Item No.", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                    ColNo += 1;

                                    EnterCell(RowNo, ColNo, Item.Description, FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                    ColNo += 1;

                                    EnterCell(RowNo, ColNo, "Color Code", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                    ColNo += 1;

                                    EnterCell(RowNo, ColNo, "Color Description", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                    ColNo += 1;

                                    CASE (Idx) OF
                                        1:
                                            BEGIN
                                                EnterCell(RowNo, ColNo, Item2.FIELDCAPTION(Inventory), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;

                                                FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) DO BEGIN
                                                    IF (SizeLabel[SizeIdx] <> '') THEN BEGIN
                                                        EnterCell(RowNo, ColNo, FORMAT(QtyOnHand[SizeIdx]), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                    END;
                                                    ColNo += 1;
                                                END;

                                                EnterCell(RowNo, ColNo, FORMAT(QtyOnHandTotal), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;
                                            END;
                                        2:
                                            BEGIN
                                                EnterCell(RowNo, ColNo, Item2.FIELDCAPTION("Qty. on Purch. Order"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;

                                                FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) DO BEGIN
                                                    IF (SizeLabel[SizeIdx] <> '') THEN BEGIN
                                                        EnterCell(RowNo, ColNo, FORMAT(QtyOnPurchOrder[SizeIdx]), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                    END;
                                                    ColNo += 1;
                                                END;

                                                EnterCell(RowNo, ColNo, FORMAT(QtyOnPurchOrderTotal), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;
                                            END;
                                        3:
                                            BEGIN
                                                EnterCell(RowNo, ColNo, 'Qty. on Work Order', FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;

                                                FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) DO BEGIN
                                                    IF (SizeLabel[SizeIdx] <> '') THEN BEGIN
                                                        EnterCell(RowNo, ColNo, FORMAT(QtyOnWorkOrder[SizeIdx]), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                    END;
                                                    ColNo += 1;
                                                END;

                                                EnterCell(RowNo, ColNo, FORMAT(QtyOnWorkOrderTotal), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;
                                            END;
                                        4:
                                            BEGIN
                                                EnterCell(RowNo, ColNo, Item2.FIELDCAPTION("Qty. on Sales Order"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;

                                                FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) DO BEGIN
                                                    IF (SizeLabel[SizeIdx] <> '') THEN BEGIN
                                                        EnterCell(RowNo, ColNo, FORMAT(QtyOnSalesOrder[SizeIdx]), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                    END;
                                                    ColNo += 1;
                                                END;

                                                EnterCell(RowNo, ColNo, FORMAT(QtyOnSalesOrderTotal), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;
                                            END;

                                        5:
                                            BEGIN
                                                EnterCell(RowNo, ColNo, 'Open to Sell', FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;

                                                FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) DO BEGIN
                                                    IF (SizeLabel[SizeIdx] <> '') THEN BEGIN
                                                        EnterCell(RowNo, ColNo, FORMAT(OpenToSell[SizeIdx]), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                    END;
                                                    ColNo += 1;
                                                END;

                                                EnterCell(RowNo, ColNo, FORMAT(OpenToSellTotal), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                                ColNo += 1;
                                            END;

                                    END;
                                END;
                            END ELSE BEGIN
                                RowNo += 1;
                                ColNo := 1;

                                EnterCell(RowNo, ColNo, "Item No.", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                ColNo += 1;

                                EnterCell(RowNo, ColNo, Item.Description, FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                ColNo += 1;

                                EnterCell(RowNo, ColNo, "Color Code", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                ColNo += 1;

                                EnterCell(RowNo, ColNo, "Color Description", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                ColNo += 1;

                                EnterCell(RowNo, ColNo, 'Open to Sell', FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                ColNo += 1;

                                FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) DO BEGIN
                                    IF (SizeLabel[SizeIdx] <> '') THEN BEGIN
                                        EnterCell(RowNo, ColNo, FORMAT(OpenToSell[SizeIdx]), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                    END;
                                    ColNo += 1;
                                END;

                                EnterCell(RowNo, ColNo, FORMAT(OpenToSellTotal), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                                ColNo += 1;
                            END;
                        END;

                    END;

                end;
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(SizeLabel);
                ItemSize.SETCURRENTKEY("Item No.", "Size Sort Order");
                ItemSize.SETRANGE("Item No.", "No.");
                IF (ItemSize.FINDSET(FALSE, FALSE)) THEN BEGIN
                    SizeIdx := 1;
                    REPEAT
                        SizeLabel[SizeIdx] := ItemSize."Size Code";
                        SizeIdx += 1;
                    UNTIL (ItemSize.NEXT = 0)
                     OR (SizeIdx > 6);

                    IF (ExportToExcel) THEN BEGIN
                        RowNo += 1;
                        ColNo := 1;

                        EnterCell(RowNo, ColNo, "No.", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                        ColNo += 1;

                        EnterCell(RowNo, ColNo, Description, FALSE, FALSE, FALSE, '', 0, '', FALSE);
                        ColNo += 1;

                        EnterCell(RowNo, ColNo, '', FALSE, FALSE, FALSE, '', 15, '', FALSE);
                        ColNo += 1;

                        EnterCell(RowNo, ColNo, '', FALSE, FALSE, FALSE, '', 15, '', FALSE);
                        ColNo += 1;

                        EnterCell(RowNo, ColNo, '', FALSE, FALSE, FALSE, '', 15, '', FALSE);
                        ColNo += 1;

                        FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) DO BEGIN
                            EnterCell(RowNo, ColNo, SizeLabel[SizeIdx], FALSE, FALSE, FALSE, '', 0, '', FALSE);
                            ColNo += 1;
                        END;

                        EnterCell(RowNo, ColNo, 'Total', FALSE, FALSE, FALSE, '', 0, '', FALSE);
                        ColNo += 1;
                    END;

                END;

            end;

            trigger OnPreDataItem()
            begin

                IF (Item.GETFILTER("Location Filter") = '') THEN BEGIN
                    SRSetup.GET;
                    IF (SRSetup."Default Availability Location" <> '') THEN
                        Item.SETFILTER("Location Filter", SRSetup."Default Availability Location");
                END;

                IF (Item.GETFILTER("Location Filter") = '') THEN BEGIN
                    InvSetup.GET;
                    IF (InvSetup."Default Location Code" <> '') THEN
                        Item.SETFILTER("Location Filter", InvSetup."Default Location Code");
                END;

                IF Item.GETFILTER("Date Filter") <> '' THEN BEGIN
                    Calendar.SETFILTER("Period Start", Item.GETFILTER("Date Filter"));
                    IF NOT PeriodFormMgt.FindDate('+', Calendar, ItemPeriodLength) THEN
                        PeriodFormMgt.FindDate('+', Calendar, ItemPeriodLength::Day);
                    Calendar.SETRANGE("Period Start");
                END;
                PeriodFormMgt.FindDate('', Calendar, ItemPeriodLength);
                Item.SETRANGE("Date Filter", 0D, Calendar."Period End");

                // Excel Output
                IF (ExportToExcel) THEN BEGIN
                    RowNo := 1;

                    EnterCell(RowNo, 1, REPORT_NAME, TRUE, FALSE, FALSE, '', 0, '', TRUE);
                    TempExcelBuffer.FINDLAST();
                    TempExcelBuffer.MergeRange := 'A' + FORMAT(RowNo) + ':M' + FORMAT(RowNo);
                    TempExcelBuffer.MODIFY;
                    RowNo += 1;

                    EnterCell(RowNo, 1, UtilFunctions.GetDateTimeStamp, FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    TempExcelBuffer.FINDLAST();
                    TempExcelBuffer.MergeRange := 'A' + FORMAT(RowNo) + ':M' + FORMAT(RowNo);
                    TempExcelBuffer.MODIFY;
                    RowNo += 1;

                    EnterCell(RowNo, 1, USERID, FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    TempExcelBuffer.FINDLAST();
                    TempExcelBuffer.MergeRange := 'A' + FORMAT(RowNo) + ':M' + FORMAT(RowNo);
                    TempExcelBuffer.MODIFY;
                    RowNo += 1;

                    IF (Item.GETFILTERS <> '') THEN BEGIN
                        EnterCell(RowNo, 1, 'FILTERS:', FALSE, TRUE, FALSE, '', 0, '', FALSE);
                        EnterCell(RowNo, 2, COPYSTR(Item.GETFILTERS, 1, 250), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                        TempExcelBuffer.FINDLAST();
                        TempExcelBuffer.MergeRange := 'B' + FORMAT(RowNo) + ':M' + FORMAT(RowNo);
                        TempExcelBuffer.MODIFY;
                        RowNo += 1;
                    END;

                    RowNo += 1;
                    ColNo := 1;

                    EnterCell(RowNo, ColNo, "Item Color".FIELDCAPTION("Item No."), TRUE, FALSE, TRUE, '', 0, '', FALSE);
                    ColNo += 1;

                    EnterCell(RowNo, ColNo, Item.FIELDCAPTION(Description), TRUE, FALSE, TRUE, '', 0, '', FALSE);
                    ColNo += 1;

                    EnterCell(RowNo, ColNo, "Item Color".FIELDCAPTION("Color Code"), TRUE, FALSE, TRUE, '', 0, '', FALSE);
                    ColNo += 1;

                    EnterCell(RowNo, ColNo, "Item Color".FIELDCAPTION("Color Description"), TRUE, FALSE, TRUE, '', 0, '', FALSE);
                    ColNo += 1;

                    EnterCell(RowNo, ColNo, 'Quantity Type', TRUE, FALSE, TRUE, '', 0, '', FALSE);
                    ColNo += 1;

                    EnterCell(RowNo, ColNo, 'Sizes', TRUE, FALSE, TRUE, '', 0, '', FALSE);

                    //   TempExcelBuffer.FINDLAST;
                    //     TempExcelBuffer.MergeRange := 'F' + FORMAT(RowNo) + ':L' + FORMAT(RowNo);
                    //     TempExcelBuffer.MODIFY;
                    //     ColNo += ARRAYLEN(SizeLabel);

                    ColNo += 1;

                    FOR SizeIdx := 1 TO ARRAYLEN(SizeLabel) - 1 DO BEGIN
                        EnterCell(RowNo, ColNo, '', TRUE, FALSE, TRUE, '', 0, '', FALSE);
                        ColNo += 1;
                    END;

                    EnterCell(RowNo, ColNo, 'Total', TRUE, FALSE, TRUE, '', 0, '', FALSE);
                    ColNo += 1;

                END;


            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowDetail; ShowDetail)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Show Detail';

                    }
                    field(ExportToExcel; ExportToExcel)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Export to Excel';
                        ToolTip = 'Specifies if you want to export the data to an Excel spreadsheet for additional analysis or formatting before printing.';
                    }
                }
            }
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
        ShowDetail := TRUE;
    end;

    trigger OnPostReport()
    begin
        if ExportToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        ItemVarSetup.GET;
    end;

    var
        SRSetup: Record "Sales & Receivables Setup";
        InvSetup: Record "Inventory Setup";
        Calendar: Record Date;
        ItemVarSetup: Record "Item Variant Mgmt. Setup";
        Item2: Record Item;
        Item3: Record Item;
        ItemSize: Record "Item Size";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        PeriodFormMgt: Codeunit PeriodFormManagement;
        UtilFunctions: Codeunit "Utility Functions";
        SizeLabel: array[6] of Text[30];
        ShowDetail: Boolean;
        ExportToExcel: Boolean;
        SizeIdx: Integer;
        VariantCode: Code[20];
        Sign: Integer;
        ItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;
        NewPage: Boolean;
        RowNo: Integer;
        ColNo: Integer;
        Idx: Integer;
        QtyOnHand: array[8] of Decimal;
        QtyOnHandTotal: Decimal;
        QtyOnPurchOrder: array[8] of Decimal;
        QtyOnPurchOrderTotal: Decimal;
        QtyOnWorkOrder: array[8] of Decimal;
        QtyOnWorkOrderTotal: Decimal;
        QtyOnSalesOrder: array[8] of Decimal;
        QtyOnSalesOrderTotal: Decimal;
        QtyOnKitSalesLines: array[8] of Decimal;
        QtyOnKitSalesLinesTotal: Decimal;
        QtyOnWorkOrderKitLines: array[8] of Decimal;
        QtyOnWorkOrderKitLinesTotal: Decimal;
        OpenToSell: array[8] of Decimal;
        OpenToSellTotal: Decimal;
        REPORT_NAME: Label 'Item Availability by Color';
        SHEET_NAME: Label 'Item Avail. by Color';
        QtyInPackages: array[8] of Decimal;
        QtyInPackagesTotal: Decimal;
        Item_Availability_by_ColorCaptionLbl: Label 'Item Availability by Color';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Item_No___CaptionLbl: Label 'Item No. /';
        SizesCaptionLbl: Label 'Sizes';
        TotalCaptionLbl: Label 'Total';
        CONT_D_CaptionLbl: Label '(CONT''D)';
        TotalCaption_Control1000000017Lbl: Label 'Total';
        SupplyCaptionLbl: Label 'Supply';
        Quantity_on_HandCaptionLbl: Label 'Quantity on Hand';
        Qty__on_Purch__OrderCaptionLbl: Label 'Qty. on Purch. Order';
        DemandCaptionLbl: Label 'Demand';
        Qty__on_Work_OrderCaptionLbl: Label 'Qty. on Work Order';
        Qty__on_Sales_OrderCaptionLbl: Label 'Qty. on Sales Order';
        Qty__on_Kit_Sales_LinesCaptionLbl: Label 'Qty. on Kit Sales Lines';
        Qty__on_WO_Kit_LinesCaptionLbl: Label 'Qty. on WO Kit Lines';
        Qty__in_PackagesCaptionLbl: Label 'Qty. in Packages';
        Open_to_SellCaptionLbl: Label 'Open to Sell';
        TXT_SHEET: Label 'Color Details';

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; InFont: Text[50]; InBGColor: Integer; InNumberFormat: Text[30]; AddPicture: Boolean)
    begin

        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Font := InFont;
        TempExcelBuffer.InteriorColorIndex := InBGColor;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := InNumberFormat;
        TempExcelBuffer."Add Picture" := AddPicture;
        TempExcelBuffer.INSERT;


    end;

    local procedure EnterFormula(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; InFont: Text[50]; InBGColor: Integer; InNumberFormat: Text[30])
    begin

        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := '';
        TempExcelBuffer.Font := InFont;
        TempExcelBuffer.InteriorColorIndex := InBGColor;
        TempExcelBuffer.Formula := CellValue; // is converted to formula later.
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := InNumberFormat;
        TempExcelBuffer.INSERT;
    end;

    procedure CreateExcelbook()

    begin
        TempExcelBuffer.CreateNewBook('Open Orders to Excel');
        TempExcelBuffer.WriteSheet(TXT_SHEET, COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    procedure GetArrayTotal(Array: ARRAY[8] OF Decimal) Total: Decimal
    var
    begin
        Total := 0;
        FOR Idx := 1 TO ARRAYLEN("Array") DO BEGIN
            Total += "Array"[Idx];
        END;
        EXIT(Total);
    end;
}

