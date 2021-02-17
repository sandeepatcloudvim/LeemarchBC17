report 50006 "Open Orders to Excel"
{
    // DefaultLayout = RDLC;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            CalcFields = Amount, "Amount Including VAT";
            DataItemTableView = SORTING("Bill-to Contact No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "Salesperson Code", "Ship-to Code", "Shipment Date", "LEE_Start Ship Date";
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE(Type = CONST(Item));
                RequestFilterFields = "Item Category Code", "No.", "LEE_Color Code", "Size Code";

                trigger OnAfterGetRecord();
                var
                    Cust: Record Customer;
                    RecEmbellishment: Record LEE_Embellishment;
                    EmbellishmentDesc: Text[250];
                begin


                    Window.UPDATE(2);

                    iRowNo += 1;
                    iColNo := 1;

                    if not (rItemColor.GET("No.", "LEE_Color Code")) then
                        CLEAR(rItemColor)
                    else
                        rItemColor.CALCFIELDS("Color Description");

                    IF NOT (rItemSize.GET("No.", "Size Code")) THEN
                        CLEAR(rItemSize)
                    ELSE
                        rItemSize.CALCFIELDS("Size Description");

                    if rItem.GET("No.") then begin
                        rItem.SETFILTER(rItem."Location Filter", "Location Code");
                        if ("Variant Code" <> '') then
                            rItem.SETFILTER(rItem."Variant Filter", "Variant Code");
                        // rItem.CALCFIELDS(rItem."LEE_Qty. in Packages");CV_PS

                    end;
                    DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);

                    if rItem2.GET("No.") then;

                    EnterCell(iRowNo, iColNo, "Sales Line"."Sell-to Customer No.", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "Sales Header"."Sell-to Customer Name", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "Sales Header"."Salesperson Code", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "Sales Line"."Document No.", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Sales Header"."LEE_Start Ship Date"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Sales Header"."Shipment Date"), false, false, false, '', 0, '', false);
                    iColNo += 1;


                    EnterCell(iRowNo, iColNo, FORMAT("Sales Header"."Requested Delivery Date"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "No.", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, Description, false, false, false, '', 0, '', false);
                    iColNo += 1;

                    //CAN_PS Added Item Dscription 2 from item card 29012020 Start
                    EnterCell(iRowNo, iColNo, rItem2."Description 2", false, false, false, '', 0, '', false);
                    iColNo += 1;
                    //CAN_PS Added Item Dscription 2 from item card 29012020 Stop

                    EnterCell(iRowNo, iColNo, rItemColor."Color Description", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, rItemSize."Size Description", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Outstanding Quantity"), false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Outstanding Amount"), false, false, false, '', 0, '$#,##0.00_}', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Production Status"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Status Due Date"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT(rItem."LEE_Qty. in Packages"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;

                    //J011215 - Start
                    Cust.GET("Sales Header"."Sell-to Customer No.");
                    EnterCell(iRowNo, iColNo, FORMAT(Cust."Customer Category"), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;
                    //J011215 - End

                    // SBC 2018-07-29 >>
                    EnterCell(iRowNo, iColNo, "Sales Header"."Bill-to Address", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "Sales Header"."Bill-to City", false, false, false, '', 0, '', false);
                    iColNo += 1;
                    // SBC 2018-07-29 <<

                    //J9.8.14 - Start
                    EnterCell(iRowNo, iColNo, "Sales Header"."Bill-to County", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "Sales Header"."Bill-to Post Code", false, false, false, '', 0, '', false);
                    iColNo += 1;
                    //J9.8.14 - End

                    // SBC 2018-08-07 >>
                    EnterCell(iRowNo, iColNo, "Sales Header"."Your Reference", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "Sales Header"."Designer Code", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;
                    // SBC 2018-08-07 <<

                    // SBC 2018-07-29 >>
                    EnterCell(iRowNo, iColNo, Cust."Phone No.", FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, "Sales Header"."Bill-to Contact", false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Sales Header".Amount), false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Sales Header"."Amount Including VAT"), false, false, false, '', 0, '', false);
                    iColNo += 1;
                    // SBC 2018-07-29 <<

                    //CAN_PS 10092019 >>
                    CLEAR(EmbellishmentDesc);
                    IF RecEmbellishment.GET(LEE_Embellishment) THEN BEGIN
                        EmbellishmentDesc := RecEmbellishment.Descripton;
                    END;
                    EnterCell(iRowNo, iColNo, FORMAT(EmbellishmentDesc), FALSE, FALSE, FALSE, '', 0, '', FALSE);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("LEE_Color Code"), false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, FORMAT("Sales Header"."External Document No."), false, false, false, '', 0, '', false);
                    iColNo += 1;

                    //CAN_PS 10092019 <<

                    //CAN_PS 01072020>>
                    EnterCell(iRowNo, iColNo, FORMAT("Sales Header"."Order Date"), false, false, false, '', 0, '', false);
                    iColNo += 1;
                    //CAN_PS 01072020<<
                    //LEE_SS>>
                    EnterCell(iRowNo, iColNo, ShortcutDimCode[1], false, false, false, '', 0, '', false);
                    iColNo += 1;

                    //EnterCell(iRowNo, iColNo, ShortcutDimCode[2], false, false, false, '', 0, '', false);
                    //iColNo += 1;

                    EnterCell(iRowNo, iColNo, ShortcutDimCode[3], false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, ShortcutDimCode[4], false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, ShortcutDimCode[5], false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, ShortcutDimCode[6], false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, ShortcutDimCode[7], false, false, false, '', 0, '', false);
                    iColNo += 1;

                    EnterCell(iRowNo, iColNo, ShortcutDimCode[8], false, false, false, '', 0, '', false);
                    iColNo += 1;

                    //LEE_SS<<


                    iSLineProgress += 1;
                    iSLineIndicator := ROUND((iSLineProgress / iSLineCount) * 10000, 1);
                    Window.UPDATE(3);
                end;

                trigger OnPostDataItem();
                begin

                    iSOProgress += 1;
                    iSOIndicator := ROUND((iSOProgress / iSOCount) * 10000, 1);
                    Window.UPDATE(4);
                end;

                trigger OnPreDataItem();
                begin
                    GLSetup.Get();
                    // SBC 2018-07-29 >>
                    if ApplyFilter then
                        "Sales Line".SETFILTER("No.", '%1..%2|%3..%4', '6000', '6999Z', '8000', '9999Z');
                    // SBC 2018-07-29 <<

                    if not (HeaderWritten) then begin

                        if ("Sales Line".GETFILTERS <> '') then begin
                            EnterCell(iRowNo, 1, TXT_SL_FILTERS, false, true, false, '', 0, '', false);
                            EnterCell(iRowNo, 2, COPYSTR("Sales Line".GETFILTERS, 1, 250), false, false, false, '', 0, '', false);
                            rTExcelBuffer.FINDLAST();
                            rTExcelBuffer.MergeRange := 'B' + FORMAT(iRowNo) + ':L' + FORMAT(iRowNo);
                            rTExcelBuffer.MODIFY;
                            iRowNo += 1;
                        end;

                        iRowNo += 1;
                        iColNo := 1;

                        EnterCell(iRowNo, iColNo, TXT_CUSTOMER_NO, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_CUSTOMER_NAME, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_SALESPERSON, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_ORDER_NO, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_START_SHIP, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_SHIPMENT_DATE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_CANCEL, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_ITEM_NO, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_ITEMDESC, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        //CAN_PS Added Item Dscription 2 from item card 29012020 Start
                        EnterCell(iRowNo, iColNo, TXT_ITEMDESC2, true, false, true, '', 0, '', false);
                        iColNo += 1;
                        //CAN_PS Added Item Dscription 2 from item card 29012020 Stop

                        EnterCell(iRowNo, iColNo, TXT_COLOR_CODE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_SIZE_CODE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_OS_QTY, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_OS_AMOUNT, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_PRODN_STATUS, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_PRODN_DUE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_QTY_PACKED, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        //J011215 - Start
                        EnterCell(iRowNo, iColNo, TXT_CUSTOMER_CATEGORY, true, false, true, '', 0, '', false);
                        iColNo += 1;
                        //J011215 - End

                        // SBC 2018-07-29 >>
                        EnterCell(iRowNo, iColNo, TXT_ADDRESS, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_CITY, true, false, true, '', 0, '', false);
                        iColNo += 1;
                        // SBC 2018-07-29 <<

                        //J9.8.14 - Start
                        EnterCell(iRowNo, iColNo, TXT_CUSTOMER_STATE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_CUSTOMER_ZIP, true, false, true, '', 0, '', false);
                        iColNo += 1;
                        //J9.8.14 - End

                        // SBC 2018-08-07 >>
                        EnterCell(iRowNo, iColNo, TXT_PROMO_CODE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_DESIGNER_CODE, true, false, true, '', 0, '', false);
                        iColNo += 1;
                        // SBC 2018-08-07 <<


                        // SBC 2018-07-29 >>
                        EnterCell(iRowNo, iColNo, TXT_PHONE_NO, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_CONTACT, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_ORDER_TOTAL, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_ORDER_TOTAL_TAX, true, false, true, '', 0, '', false);
                        iColNo += 1;
                        // SBC 2018-07-29 <<

                        //CAN_PS 10092019>>
                        EnterCell(iRowNo, iColNo, TXT_EMBELLISHMENT, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_COLORCODE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        EnterCell(iRowNo, iColNo, TXT_CUSTPO, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        //CAN_PS 10092019<<

                        //CAN_PS 01072020>>
                        EnterCell(iRowNo, iColNo, TXT_ORDERDATE, true, false, true, '', 0, '', false);
                        iColNo += 1;

                        //CAN_PS 01072020<<
                        //LEE_SS>>
                        EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 1 Code", true, false, true, '', 0, '', false);
                        iColNo += 1;
                        //EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 2 Code", true, false, true, '', 0, '', false);
                        //iColNo += 1;
                        EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 3 Code", true, false, true, '', 0, '', false);
                        iColNo += 1;
                        EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 4 Code", true, false, true, '', 0, '', false);
                        iColNo += 1;
                        EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 5 Code", true, false, true, '', 0, '', false);
                        iColNo += 1;
                        EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 6 Code", true, false, true, '', 0, '', false);
                        iColNo += 1;
                        EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 7 Code", true, false, true, '', 0, '', false);
                        iColNo += 1;
                        EnterCell(iRowNo, iColNo, GLSetup."Shortcut Dimension 8 Code", true, false, true, '', 0, '', false);
                        iColNo += 1;
                        //LEE_SS<<






                        HeaderWritten := true;

                    end;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Window.UPDATE(1);
            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem();
            begin

                // SBC 2018-07-29 >>
                if ApplyCancelDateFilter then
                    IF GETFILTER("LEE_Cancel Date") = '' THEN
                        "Sales Header".SETRANGE("LEE_Cancel Date", ReportAsOfDate + 5);
                // SBC 2018-07-29 <<

                iSOProgress := 0;
                iSOIndicator := 0;
                iSOCount := "Sales Header".COUNT;

                Window.OPEN('Surveying Sales Order(s)...                 \' +
                            'Document No.:           #1##################\' +
                            'Item No.:               #2##################\' +
                            'Document Progress:      @3@@@@@@@@@@@@@@@@@@\' +
                            'Total Progress:         @4@@@@@@@@@@@@@@@@@@',
                            "Sales Header"."No.",
                            "Sales Line"."No.",
                            iSLineIndicator,
                            iSOIndicator);

                iSLineProgress := 0;
                iSLineIndicator := 0;
                iSLineCount := "Sales Line".COUNT;

                iRowNo := 1;

                EnterCell(iRowNo, 1, TXT_TITLE, true, false, false, '', 0, '', true);
                rTExcelBuffer.FINDLAST();
                rTExcelBuffer.MergeRange := 'A' + FORMAT(iRowNo) + ':L' + FORMAT(iRowNo);
                rTExcelBuffer.MODIFY;
                iRowNo += 1;

                /*
                Report Run By: Azmanyan
                Report Run On: 8/6/18
                Report Run As Of:  8/2/18
                Report ID;
                */

                EnterCell(iRowNo, 1, 'Report Run By:  ' + USERID, false, false, false, '', 0, '', false);
                rTExcelBuffer.FINDLAST();
                rTExcelBuffer.MergeRange := 'A' + FORMAT(iRowNo) + ':L' + FORMAT(iRowNo);
                rTExcelBuffer.MODIFY;
                iRowNo += 1;

                EnterCell(iRowNo, 1, 'Report Run On:  ' + FORMAT(TODAY), false, false, false, '', 0, '', false);
                rTExcelBuffer.FINDLAST();
                rTExcelBuffer.MergeRange := 'A' + FORMAT(iRowNo) + ':L' + FORMAT(iRowNo);
                rTExcelBuffer.MODIFY;
                iRowNo += 1;

                EnterCell(iRowNo, 1, 'Report Run As Of:  ' + FORMAT(ReportAsOfDate), false, false, false, '', 0, '', false);
                rTExcelBuffer.FINDLAST();
                rTExcelBuffer.MergeRange := 'A' + FORMAT(iRowNo) + ':L' + FORMAT(iRowNo);
                rTExcelBuffer.MODIFY;
                iRowNo += 1;

                EnterCell(iRowNo, 1, TXT_REPORT_ID + '50001', false, false, false, '', 0, '', false);
                rTExcelBuffer.FINDLAST();
                rTExcelBuffer.MergeRange := 'A' + FORMAT(iRowNo) + ':L' + FORMAT(iRowNo);
                rTExcelBuffer.MODIFY;
                iRowNo += 1;


                if ("Sales Header".GETFILTERS <> '') then begin
                    EnterCell(iRowNo, 1, TXT_SH_FILTERS, false, true, false, '', 0, '', false);
                    EnterCell(iRowNo, 2, COPYSTR("Sales Header".GETFILTERS, 1, 250), false, false, false, '', 0, '', false);
                    rTExcelBuffer.FINDLAST();
                    rTExcelBuffer.MergeRange := 'B' + FORMAT(iRowNo) + ':L' + FORMAT(iRowNo);
                    rTExcelBuffer.MODIFY;
                    iRowNo += 1;
                end;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Report As Of Date"; ReportAsOfDate)
                {
                    ApplicationArea = All;
                }
                field(ApplyFilter; ApplyFilter)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Apply Filter: Item No. = 6000..6999Z|8000..9999Z';
                }
                field("Apply Cancel Date Filter"; ApplyCancelDateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Apply Cancel Date Filter';
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

    trigger OnPostReport();
    begin

        // rTExcelBuffer.CreateBook;
        rTExcelBuffer.CreateNewBook('Open Orders to Excel');
        rTExcelBuffer.WriteSheet(TXT_SHEET, COMPANYNAME, USERID);
        rTExcelBuffer.CloseBook();
        rTExcelBuffer.OpenExcel();
        // rTExcelBuffer.CreateSheet(TXT_SHEET, TXT_SHEET, COMPANYNAME, USERID);
        // if ReportRunFromJobQueue then begin
        //     rTExcelBuffer.SaveBook(ExportFileLocation);
        // end else
        //     rTExcelBuffer.GiveUserControl;
    end;

    trigger OnPreReport();
    begin
        rCompanyInformation.GET;
    end;

    var
        rCompanyInformation: Record "Company Information";
        rTExcelBuffer: Record "Excel Buffer" temporary;
        rItemColor: Record "Item Color";
        rItemSize: Record "Item Size";
        rItem: Record Item;
        // cuUtilFunctions: Codeunit "Utility Functions";
        DimMgt: Codeunit DimensionManagement;
        recSalesHeader: Record "Sales Header";
        ShortcutDimCode: ARRAY[8] OF Code[20];
        GLSetup: Record "General Ledger Setup";
        Window: Dialog;
        iSOProgress: Integer;
        iSOCount: Integer;
        iSOIndicator: Integer;
        iSLineProgress: Integer;
        iSLineCount: Integer;
        iSLineIndicator: Integer;
        iRowNo: Integer;
        iColNo: Integer;
        HeaderWritten: Boolean;
        ReportAsOfDate: Date;
        ApplyFilter: Boolean;
        ApplyCancelDateFilter: Boolean;
        ReportRunFromJobQueue: Boolean;
        ExportFileLocation: Text[250];
        rItem2: Record Item;
        TXT_TITLE: Label 'OPEN SALES ORDER DETAILS';
        TXT_SHEET: Label 'SALES_DETAILS';
        TXT_SH_FILTERS: Label 'Sales Header Filters:';
        TXT_SL_FILTERS: Label 'Sales Line Filters:';
        TXT_CUSTOMER_NO: Label 'Customer No.';
        TXT_CUSTOMER_NAME: Label 'Customer Name';
        TXT_SALESPERSON: Label 'Salesperson Code';
        TXT_ORDER_NO: Label 'Order No.';
        TXT_START_SHIP: Label 'Start Ship';
        TXT_SHIPMENT_DATE: Label 'Shipment Date';
        TXT_CANCEL: Label 'Cancel Date';
        TXT_ITEM_NO: Label 'Item No.';
        TXT_ITEMDESC: Label 'Description';
        TXT_COLOR_CODE: Label 'Color';
        TXT_SIZE_CODE: Label 'Size';
        TXT_OS_QTY: Label 'Outstanding Quantity';
        TXT_OS_AMOUNT: Label 'Outstanding Amount';
        TXT_PRODN_STATUS: Label 'Production Status';
        TXT_PRODN_DUE: Label 'Status Due Date';
        TXT_QTY_PACKED: Label 'Qty. in Packages';
        TXT_CUSTOMER_STATE: Label 'State';
        TXT_CUSTOMER_ZIP: Label 'Zip Code';
        TXT_CUSTOMER_CATEGORY: Label 'Customer Category';
        TXT_PHONE_NO: Label 'Phone No.';
        TXT_ADDRESS: Label 'Address';
        TXT_CITY: Label 'City';
        TXT_ORDER_TOTAL: Label 'Order Total Value';
        TXT_ORDER_TOTAL_TAX: Label 'Order Total Value Including Tax';
        TXT_CONTACT: Label 'Contact';
        TXT_PROMO_CODE: Label 'Promo Code';
        TXT_DESIGNER_CODE: Label 'Designer Code';
        TXT_REPORT_ID: Label '"Report ID:  "';
        TXT_EMBELLISHMENT: Label 'Embellishment';
        TXT_COLORCODE: Label 'Color Code';
        TXT_CUSTPO: Label '"Customer PO "';
        TXT_ORDERDATE: Label 'Order Date';
        TXT_ITEMDESC2: Label 'Description 2';

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; InFont: Text[50]; InBGColor: Integer; InNumberFormat: Text[30]; AddPicture: Boolean);
    begin
        rTExcelBuffer.INIT;
        rTExcelBuffer.VALIDATE("Row No.", RowNo);
        rTExcelBuffer.VALIDATE("Column No.", ColumnNo);
        rTExcelBuffer."Cell Value as Text" := CellValue;
        rTExcelBuffer.Font := InFont;
        rTExcelBuffer.InteriorColorIndex := InBGColor;
        rTExcelBuffer.Formula := '';
        rTExcelBuffer.Bold := Bold;
        rTExcelBuffer.Italic := Italic;
        rTExcelBuffer.Underline := UnderLine;
        rTExcelBuffer.NumberFormat := InNumberFormat;
        rTExcelBuffer."Add Picture" := AddPicture;
        rTExcelBuffer.INSERT;
    end;

    local procedure EnterFormula(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; InFont: Text[50]; InBGColor: Integer; InNumberFormat: Text[30]);
    begin
        rTExcelBuffer.INIT;
        rTExcelBuffer.VALIDATE("Row No.", RowNo);
        rTExcelBuffer.VALIDATE("Column No.", ColumnNo);
        rTExcelBuffer."Cell Value as Text" := '';
        rTExcelBuffer.Font := InFont;
        rTExcelBuffer.InteriorColorIndex := InBGColor;
        rTExcelBuffer.Formula := CellValue; // is converted to formula later.
        rTExcelBuffer.Bold := Bold;
        rTExcelBuffer.Italic := Italic;
        rTExcelBuffer.Underline := UnderLine;
        rTExcelBuffer.NumberFormat := InNumberFormat;
        rTExcelBuffer.INSERT;
    end;

    procedure SetReportOptions(ReportDate: Date; ApplyItemFilter: Boolean; JobQueue: Boolean; FileLoc: Text[250]);
    begin
        ReportAsOfDate := ReportDate;
        ApplyFilter := ApplyItemFilter;
        ReportRunFromJobQueue := JobQueue;
        ExportFileLocation := FileLoc;
    end;
}

