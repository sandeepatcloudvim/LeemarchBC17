report 50027 "LEE Cust/Item Stat by Salesper"
{
    DefaultLayout = RDLC;
    Caption = 'Cust./Item Stat. by Salespers.';
    RDLCLayout = './LEECustItemStatbySalespers.rdl';

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", Name;
            RequestFilterHeading = 'Salesperson';
            column(FORMAT_TODAY_0_4; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(USERID; UserId)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(FilterString2; FilterString2)
            {
            }
            column(FilterString3; FilterString3)
            {
            }
            column(OnlyOnePerPage; OnlyOnePerPage)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(Salesperson_Purchaser__TABLECAPTION___________FilterString; "Salesperson/Purchaser".TableCaption + ':  ' + FilterString)
            {
            }
            column(Customer_TABLECAPTION___________FilterString2; Customer.TableCaption + ':  ' + FilterString2)
            {
            }
            column(Value_Entry__TABLECAPTION___________FilterString3; "Value Entry".TableCaption + ':  ' + FilterString3)
            {
            }
            column(SalespersonString; SalespersonString)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            column(Salesperson_Purchaser_Name; Name)
            {
            }
            column(Value_Entry___Sales_Amount__Actual__; "Value Entry"."Sales Amount (Actual)")
            {
            }
            column(Profit; Profit)
            {
            }
            column(Value_Entry___Discount_Amount_; "Value Entry"."Discount Amount")
            {
            }
            column(Profit__; "Profit%")
            {
                DecimalPlaces = 1 : 1;
            }
            column(Customer_Item_Statistics_by_SalespersonCaption; Customer_Item_Statistics_by_SalespersonCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Salesperson_Purchaser_CodeCaption; Salesperson_Purchaser_CodeCaptionLbl)
            {
            }
            column(Salesperson_Purchaser_NameCaption; Salesperson_Purchaser_NameCaptionLbl)
            {
            }
            column(Customer__No__Caption; Customer__No__CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(Profit_Control51Caption; Profit_Control51CaptionLbl)
            {
            }
            column(Profit___Control53Caption; Profit___Control53CaptionLbl)
            {
            }
            column(Value_Entry__Item_No__Caption; Value_Entry__Item_No__CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Invoiced_Quantity_Caption; Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Value_Entry__Sales_Amount__Actual__Caption; Value_Entry__Sales_Amount__Actual__CaptionLbl)
            {
            }
            column(Value_Entry__Discount_Amount_Caption; Value_Entry__Discount_Amount_CaptionLbl)
            {
            }
            column(Report_TotalsCaption; Report_TotalsCaptionLbl)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemTableView = SORTING("Salesperson Code", "No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Search Name";
                column(Customer__No__; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }
                column(Customer__Phone_No__; "Phone No.")
                {
                }
                column(Customer_Contact; Contact)
                {
                }
                column(Salesperson_Purchaser__Code; "Salesperson/Purchaser".Code)
                {
                }
                column(Value_Entry___Sales_Amount__Actual___Control41; "Value Entry"."Sales Amount (Actual)")
                {
                }
                column(Profit_Control42; Profit)
                {
                }
                column(Value_Entry___Discount_Amount__Control43; "Value Entry"."Discount Amount")
                {
                }
                column(Profit___Control44; "Profit%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                {
                }
                column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
                {
                }
                column(Phone_Caption; Phone_CaptionLbl)
                {
                }
                column(Contact_Caption; Contact_CaptionLbl)
                {
                }
                column(Salesperson_TotalsCaption; Salesperson_TotalsCaptionLbl)
                {
                }
                column(Customer_Category; "Customer Category")
                {

                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Source No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                    DataItemTableView = SORTING("Source Type", "Source No.", "Item Ledger Entry Type", "Item No.", "Posting Date") WHERE("Source Type" = CONST(Customer), "Item Ledger Entry Type" = CONST(Sale), "Expected Cost" = CONST(false));
                    RequestFilterFields = "Item No.", "Inventory Posting Group", "Posting Date";
                    column(Value_Entry__Item_No__; "Item No.")
                    {
                    }
                    column(Item_Description; Item.Description)
                    {
                    }
                    column(Invoiced_Quantity_; -"Invoiced Quantity")
                    {
                    }
                    column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                    {
                    }
                    column(Value_Entry__Sales_Amount__Actual__; "Sales Amount (Actual)")
                    {
                    }
                    column(Profit_Control51; Profit)
                    {
                    }
                    column(Value_Entry__Discount_Amount_; "Discount Amount")
                    {
                    }
                    column(Profit___Control53; "Profit%")
                    {
                        DecimalPlaces = 1 : 1;
                    }
                    column(Customer__No___Control54; Customer."No.")
                    {
                    }
                    column(Value_Entry__Sales_Amount__Actual___Control55; "Sales Amount (Actual)" + 0)
                    {
                    }
                    column(Profit_Control56; Profit + 0)
                    {
                    }
                    column(Value_Entry__Discount_Amount__Control57; "Discount Amount" + 0)
                    {
                    }
                    column(Profit___Control58; "Profit%" + 0)
                    {
                        DecimalPlaces = 1 : 1;
                    }
                    column(Value_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Value_Entry_Source_No_; "Source No.")
                    {
                    }
                    column(Value_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(Value_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(Customer_TotalsCaption; Customer_TotalsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        recSalesHeader.Reset();
                        recSalesHeader.SetRange("No.", "Document No.");
                        if recSalesHeader.FindFirst() then;

                        // if ValueEntryTotalForItem."Item No." <> "Item No." then begin

                        "CalculateProfit%";
                        if PrintToExcel and (ValueEntryTotalForItem."Item No." <> '') and (ValueEntryTotalForItem."Invoiced Quantity" <> 0) then
                            MakeExcelDataBody;
                        Clear(ValueEntryTotalForItem);
                        ProfitTotalForItem := 0;
                        if not Item.Get("Item No.") then begin
                            Item.Description := 'Others';
                            Item."Base Unit of Measure" := '';
                        end;


                        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);

                        Profit := "Sales Amount (Actual)" + "Cost Amount (Actual)";
                        "Discount Amount" := -"Discount Amount";

                        ValueEntryTotalForItem."Item No." := "Item No.";
                        ValueEntryTotalForItem."Document No." := "Document No.";
                        ValueEntryTotalForItem."Document Line No." := "Document Line No.";
                        ValueEntryTotalForItem."Document Type" := "Document Type";
                        ValueEntryTotalForItem."Posting Date" := "Posting Date";
                        ValueEntryTotalForItem.Description := Description;
                        ValueEntryTotalForItem."Invoiced Quantity" += "Invoiced Quantity";
                        ValueEntryTotalForItem."Sales Amount (Actual)" += "Sales Amount (Actual)";
                        ValueEntryTotalForItem."Discount Amount" += "Discount Amount";
                        ProfitTotalForItem += Profit;
                    end;

                    trigger OnPostDataItem()
                    begin
                        if PrintToExcel and (ValueEntryTotalForItem."Item No." <> '') then begin
                            "CalculateProfit%";
                            MakeExcelDataBody;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        case SalespersonToUse of
                            SalespersonToUse::"Assigned To Customer":
                                SetRange("Salespers./Purch. Code");
                            SalespersonToUse::"Assigned To Sales Order":
                                SetRange("Salespers./Purch. Code", "Salesperson/Purchaser".Code);
                        end;

                        Clear(ValueEntryTotalForItem);
                        ProfitTotalForItem := 0;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    case SalespersonToUse of
                        SalespersonToUse::"Assigned To Customer":
                            begin
                                SetCurrentKey("Salesperson Code", "No.");
                                SetRange("Salesperson Code", "Salesperson/Purchaser".Code);
                            end;
                        SalespersonToUse::"Assigned To Sales Order":
                            begin
                                SetCurrentKey("No.");
                                SetRange("Salesperson Code");
                            end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if OnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1
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
                    field(SalespersonToUse; SalespersonToUse)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson To Use';
                        OptionCaption = 'Assigned To Customer,Assigned To Sales Order';
                        ToolTip = 'Specifies if the report must be based on the salesperson that is assigned to the customer or to the sales order.';
                    }
                    field(OnlyOnePerPage; OnlyOnePerPage)
                    {
                        ApplicationArea = Suite;
                        Caption = 'New Page per Salesperson';
                        ToolTip = 'Specifies if each salesperson''s statistics begins on a new page.';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Print to Excel';
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

    trigger OnPostReport()
    begin
        if PrintToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        FilterString := "Salesperson/Purchaser".GetFilters;
        FilterString2 := Customer.GetFilters;
        FilterString3 := "Value Entry".GetFilters;
        case SalespersonToUse of
            SalespersonToUse::"Assigned To Customer":
                SalespersonString := Text002;
            SalespersonToUse::"Assigned To Sales Order":
                SalespersonString := Text003;
            else
                Error(Text001);
        end;

        if PrintToExcel then
            MakeExcelInfo;
    end;

    var
        rTExcelBuffer: Record "Excel Buffer" temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        FilterString: Text;
        FilterString2: Text;
        FilterString3: Text;
        Profit: Decimal;
        "Profit%": Decimal;
        InvoiceTotal: Decimal;
        InvoiceTotalIncludingTax: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PromoCode: Text[35];
        OrderNo: Code[20];
        OrderDate: Date;
        OnlyOnePerPage: Boolean;
        Item: Record Item;
        rItemColor: Record "Item Color";
        rItemSize: Record "Item Size";
        rItem: Record Item;
        CompanyInformation: Record "Company Information";
        SalespersonToUse: Option "Assigned To Customer","Assigned To Sales Order";
        DimMgt: Codeunit DimensionManagement;
        recSalesHeader: Record "Sales Header";
        recSalesInvLine: Record "Sales Invoice Line";
        ShortcutDimCode: ARRAY[8] OF Code[20];
        SalespersonString: Text[250];
        Text001: Label 'Invalid option chosen for Salesperson To Use.';
        Text002: Label 'Individual sale shows under the Salesperson assigned to that Customer.';
        Text003: Label 'Individual sale shows under the Salesperson assigned to that individual Sales Order.';
        PrintToExcel: Boolean;
        Text101: Label 'Data';
        Text102: Label 'Customer/Item Statistics by Salesperson';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Salesperson Filters';
        Text109: Label 'Customer Filters';
        Text110: Label 'Value Entry Filters';
        Text111: Label 'Salesperson to Use';
        Text112: Label 'Contribution Margin';
        Text113: Label 'Contribution Ratio';
        Text114: Label 'Salesperson';
        PageGroupNo: Integer;
        ValueEntryTotalForItem: Record "Value Entry";
        GLSetup: Record "General Ledger Setup";
        ProfitTotalForItem: Decimal;
        Customer_Item_Statistics_by_SalespersonCaptionLbl: Label 'Customer/Item Statistics by Salesperson';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Salesperson_Purchaser_CodeCaptionLbl: Label 'Salesperson';
        Salesperson_Purchaser_NameCaptionLbl: Label 'Salesperson Name';
        Customer__No__CaptionLbl: Label 'Customer No.';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit of Measure';
        Profit_Control51CaptionLbl: Label 'Contribution Margin';
        Profit___Control53CaptionLbl: Label 'Contrib Ratio';
        Value_Entry__Item_No__CaptionLbl: Label 'Item Number';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Invoiced_Quantity_CaptionLbl: Label 'Quantity';
        Value_Entry__Sales_Amount__Actual__CaptionLbl: Label 'Amount';
        Value_Entry__Discount_Amount_CaptionLbl: Label 'Discount';
        Report_TotalsCaptionLbl: Label 'Report Totals';
        Phone_CaptionLbl: Label 'Phone:';
        Contact_CaptionLbl: Label 'Contact:';
        Salesperson_TotalsCaptionLbl: Label 'Salesperson Totals';
        Customer_TotalsCaptionLbl: Label 'Customer Totals';
        TXT_SHEET: Label 'INVOICE_DETAILS';
        ItemVariant: Record "Item Variant";
        PostSalesLine: Record "Sales Invoice Line";
        PostSalesHeader: Record "Sales Invoice Header";
        PostSalesCreditLine: Record "Sales Cr.Memo Line";
        PostSalesCreditHeader: Record "Sales Cr.Memo Header";

    procedure "CalculateProfit%"()
    begin
        if ValueEntryTotalForItem."Sales Amount (Actual)" <> 0 then
            "Profit%" := Round(100 * ProfitTotalForItem / ValueEntryTotalForItem."Sales Amount (Actual)", 0.1)
        else
            "Profit%" := 0;
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text103), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text105), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text102), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text104), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Cust./Item Stat. by Salespers.", false, false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text106), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text107), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(Time, false, false, false, false, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text111), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(SalespersonString, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text108), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text109), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString2, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text110), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString3, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        GLSetup.Get();
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(
          Text114 + ' ' + "Salesperson/Purchaser".FieldCaption(Code), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Text114 + ' ' + "Salesperson/Purchaser".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Customer.TableCaption + ' ' + Customer.FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption("Customer Category"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Total', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Total Including Tax', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Order No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Contact), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption("Phone No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Address), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption("Address 2"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(City), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(County), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption("Post Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Reference No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Item No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption(Description), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption("Description 2"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption(LEE_Color), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption(LEE_Size), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Invoiced Quantity"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption("Base Unit of Measure"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Sales Amount (Actual)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(Text112), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(Text113), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Discount Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        //LEE_SS>>
        ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 1 Code", false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 3 Code", false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 4 Code", false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 5 Code", false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 6 Code", false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 7 Code", false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLSetup."Shortcut Dimension 8 Code", false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);

        //LEE_SS<<

    end;

    local procedure MakeExcelDataBody()
    var
        ItemColor: Record "Item Color";
        ItemSize: Record "Item Size";
        recItem: Record Item;

    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Salesperson/Purchaser".Code, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Salesperson/Purchaser".Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        //LEE_SS>>

        InvoiceTotal := 0;
        InvoiceTotalIncludingTax := 0;
        IF "Value Entry"."Sales Amount (Actual)" < 0 THEN BEGIN
            IF SalesCrMemoHeader.GET(ValueEntryTotalForItem."Document No.") THEN BEGIN
                SalesCrMemoHeader.CALCFIELDS(Amount, "Amount Including VAT");
                InvoiceTotal := SalesCrMemoHeader.Amount;
                InvoiceTotalIncludingTax := SalesCrMemoHeader."Amount Including VAT";
                PromoCode := SalesCrMemoHeader."Your Reference"
            END;
        END ELSE BEGIN
            IF SalesInvoiceHeader.GET(ValueEntryTotalForItem."Document No.") THEN BEGIN
                SalesInvoiceHeader.CALCFIELDS(Amount, "Amount Including VAT");
                InvoiceTotal := SalesInvoiceHeader.Amount;
                InvoiceTotalIncludingTax := SalesInvoiceHeader."Amount Including VAT";
                PromoCode := SalesInvoiceHeader."Your Reference";
            END;
        END;

        if PostSalesLine.Get(ValueEntryTotalForItem."Document No.", ValueEntryTotalForItem."Document Line No.") then;

        if ValueEntryTotalForItem."Document Type" = ValueEntryTotalForItem."Document Type"::"Sales Credit Memo" then begin
            Clear(PostSalesCreditHeader);
            if PostSalesCreditHeader.GET(ValueEntryTotalForItem."Document No.") then begin
                OrderNo := '';
                OrderDate := PostSalesCreditHeader."Posting Date";
            end
        end;

        if ValueEntryTotalForItem."Document Type" = ValueEntryTotalForItem."Document Type"::"Sales Invoice" then begin
            clear(PostSalesHeader);
            if PostSalesHeader.GET(ValueEntryTotalForItem."Document No.") then begin
                OrderDate := PostSalesHeader."Order Date";
                OrderNo := PostSalesHeader."Order No.";
            end;
        end;

        ExcelBuf.AddColumn(Customer."Customer Category", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(InvoiceTotal, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(InvoiceTotalIncludingTax, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Document No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Posting Date", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(OrderNo, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(OrderDate, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Contact, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Phone No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Address, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Address 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.City, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.County, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Post Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Promocode, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        //LEE_SS<<

        ExcelBuf.AddColumn(ValueEntryTotalForItem."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        //LEE_SS>>
        if ValueEntryTotalForItem."Document Type" = ValueEntryTotalForItem."Document Type"::"Sales Credit Memo" then begin
            Clear(PostSalesCreditLine);
            if PostSalesCreditLine.GET(ValueEntryTotalForItem."Document No.", ValueEntryTotalForItem."Document Line No.") then begin
                IF NOT (ItemColor.GET(PostSalesCreditLine."No.", PostSalesCreditLine."LEE_Color Code")) THEN
                    CLEAR(ItemColor)
                ELSE
                    ItemColor.CALCFIELDS("Color Description");
                IF NOT (ItemSize.GET(PostSalesCreditLine."No.", PostSalesCreditLine."Size Code")) THEN
                    CLEAR(ItemSize)
                ELSE
                    ItemSize.CALCFIELDS("Size Description");
            end
        end;

        if ValueEntryTotalForItem."Document Type" = ValueEntryTotalForItem."Document Type"::"Sales Invoice" then begin
            clear(PostSalesLine);
            if PostSalesLine.GET(ValueEntryTotalForItem."Document No.", ValueEntryTotalForItem."Document Line No.") then begin
                IF NOT (ItemColor.GET(PostSalesLine."No.", PostSalesLine."LEE_Color Code")) THEN
                    CLEAR(ItemColor)
                ELSE
                    ItemColor.CALCFIELDS("Color Description");
                IF NOT (ItemSize.GET(PostSalesLine."No.", PostSalesLine."Size Code")) THEN
                    CLEAR(ItemSize)
                ELSE
                    ItemSize.CALCFIELDS("Size Description");
            end;
        end;


        ExcelBuf.AddColumn(Item."Description 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ItemColor."Color Description", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ItemSize."Size Description", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        //LEE_SS<<
        ExcelBuf.AddColumn(-ValueEntryTotalForItem."Invoiced Quantity", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(Item."Base Unit of Measure", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          ValueEntryTotalForItem."Sales Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ProfitTotalForItem, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Profit%" / 100, false, '', false, false, false, '0.0%', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Discount Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);

        //LEE_SS>>
        ExcelBuf.AddColumn(ShortcutDimCode[1], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddColumn(ShortcutDimCode[2], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ShortcutDimCode[3], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ShortcutDimCode[4], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ShortcutDimCode[5], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ShortcutDimCode[6], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ShortcutDimCode[7], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ShortcutDimCode[8], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        //LEE_SS<<

    end;

    local procedure CreateExcelbook()

    begin
        ExcelBuf.CreateNewBook('Open Orders to Excel');
        ExcelBuf.WriteSheet(TXT_SHEET, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;




}

