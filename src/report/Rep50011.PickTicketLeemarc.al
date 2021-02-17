report 50011 "Pick Instruction Leemarc"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PickInstructionLeemarc.rdl';
    Caption = 'Pick Instruction Leemarc';

    dataset
    {
        dataitem(CopyLoop; "Integer")
        {
            DataItemTableView = SORTING(Number);
            column(Number; Number)
            {
            }
            column(CompanyNameText; CompNameText)
            {
            }
            column(DateText; DateTxt)
            {
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
                RequestFilterFields = "No.";
                column(No_SalesHeader; "No.")
                {
                    IncludeCaption = true;
                }
                column(CommentText; CommentText)
                {

                }
                column(CustomerNo_SalesHeader; "Sell-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(CustomerName_SalesHeader; "Sell-to Customer Name")
                {
                    IncludeCaption = true;
                }
                column(Due_Date; Format("Due Date", 0, 4))
                {

                }
                column(Requested_Delivery_Date; Format("Requested Delivery Date", 0, 4))
                {

                }
                column(Shipment_Date; Format("Shipment Date", 0, 4))
                {

                }

                column(Your_Reference; "Sales Header"."External Document No.")
                {

                }

                column(TotalQty; TotalQty)
                {

                }

                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE(Type = CONST(Item));
                    column(LineNo_SalesLine; "Line No.")
                    {
                    }

                    column(Color_Code; ItemColor.Description)
                    {

                    }
                    column(Size_Code; "Size Code")
                    {

                    }
                    column(Embellishment; LEE_Embellishment)
                    {

                    }
                    column(LEE_Description; "LEE_Color Code" + '' + "Size Code" + '' + LEE_Embellishment)
                    {

                    }
                    column(Ship_Code; "Sales Line"."Ship-to Code")
                    {

                    }
                    column(ShipToAddress1; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddr[7])
                    {
                    }
                    column(ShipToName; recShipToAdd.Name)
                    {

                    }
                    column(ShipToName2; recShipToAdd."Name 2")
                    {

                    }
                    column(ShipToContact; recShipToAdd.Contact)
                    {

                    }
                    column(ShipToAddress; recShipToAdd.Address)
                    {

                    }
                    column(ShipAddress2; recShipToAdd."Address 2")
                    {

                    }
                    column(ShipToCity; recShipToAdd.City)
                    {

                    }
                    column(ShipToZipcode; recShipToAdd."Post Code")
                    {

                    }
                    column(ShipToRegionCode; recShipToAdd."Country/Region Code")
                    {

                    }

                    column(ShipToCounty; recShipToAdd.County)
                    {

                    }

                    column(ItemNo_SalesLine; "No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_SalesLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(Description_2; "Description 2")
                    {

                    }
                    column(VariantCode_SalesLine; "Variant Code")
                    {
                        IncludeCaption = true;
                    }
                    column(LocationCode_SalesLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(BinCode_SalesLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(ShipmentDate_SalesLine; Format("Shipment Date"))
                    {
                    }
                    column(Quantity_SalesLine; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(UnitOfMeasure_SalesLine; "Unit of Measure")
                    {
                        IncludeCaption = true;
                    }
                    column(QuantityToShip_SalesLine; "Qty. to Ship")
                    {
                        IncludeCaption = true;
                    }
                    column(QuantityShipped_SalesLine; "Quantity Shipped")
                    {
                        IncludeCaption = true;
                    }
                    column(QtyToAsm; QtyToAsm)
                    {
                    }


                    dataitem("Assembly Line"; "Assembly Line")
                    {
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(No_AssemblyLine; "No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Description_AssemblyLine; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(VariantCode_AssemblyLine; "Variant Code")
                        {
                            IncludeCaption = true;
                        }
                        column(Quantity_AssemblyLine; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityPer_AssemblyLine; "Quantity per")
                        {
                            IncludeCaption = true;
                        }
                        column(UnitOfMeasure_AssemblyLine; GetUOM("Unit of Measure Code"))
                        {
                        }
                        column(LocationCode_AssemblyLine; "Location Code")
                        {
                            IncludeCaption = true;
                        }
                        column(BinCode_AssemblyLine; "Bin Code")
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityToConsume_AssemblyLine; "Quantity to Consume")
                        {
                            IncludeCaption = true;
                        }

                        trigger OnPreDataItem()
                        begin
                            if not AsmExists then
                                CurrReport.Break();
                            SetRange("Document Type", AsmHeader."Document Type");
                            SetRange("Document No.", AsmHeader."No.");
                        end;
                    }


                    trigger OnAfterGetRecord()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin

                        if ItemColor.Get("LEE_Color Code") then;
                        Clear(ShipToAddr);
                        if "Sales Line"."Ship-to Code" <> '' then begin
                            Clear(recShipToAdd);
                            if recShipToAdd.Get("Sales Line"."Sell-to Customer No.", "Sales Line"."Ship-to Code") then;
                            //  FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                            ShipToAddr[1] := recShipToAdd.Name;
                            ShipToAddr[2] := recShipToAdd."Name 2";
                            ShipToAddr[3] := recShipToAdd.Address;
                            ShipToAddr[4] := recShipToAdd."Address 2";
                            ShipToAddr[5] := recShipToAdd.City;
                            ShipToAddr[6] := recShipToAdd."Post Code";
                            ShipToAddr[7] := recShipToAdd.County;

                        end else begin
                            Clear(recShipToAdd);
                            if recShipToAdd.Get("Sales Header"."Sell-to Customer No.", "Sales Header"."Ship-to Code") then;

                            if "Sales Header"."Ship-to Name" <> '' then begin
                                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");

                            end Else begin
                                FormatAddr.SalesHeaderSellTo(ShipToAddr, "Sales Header");

                            end;

                        end;


                        //ShipToAddr[1] := 'OK';
                        AssembleToOrderLink.Reset();
                        AssembleToOrderLink.SetCurrentKey(Type, "Document Type", "Document No.", "Document Line No.");
                        AssembleToOrderLink.SetRange(Type, AssembleToOrderLink.Type::Sale);
                        AssembleToOrderLink.SetRange("Document Type", "Document Type");
                        AssembleToOrderLink.SetRange("Document No.", "Document No.");
                        AssembleToOrderLink.SetRange("Document Line No.", "Line No.");
                        AsmExists := AssembleToOrderLink.FindFirst;
                        QtyToAsm := 0;
                        if AsmExists then
                            if AsmHeader.Get(AssembleToOrderLink."Assembly Document Type", AssembleToOrderLink."Assembly Document No.") then
                                QtyToAsm := AsmHeader."Quantity to Assemble"
                            else
                                AsmExists := false;
                    end;

                    trigger OnPreDataItem()
                    begin
                        TotalQty := 0;
                    end;

                }

                trigger OnAfterGetRecord()
                var

                begin
                    CommentText := '';
                    SalesComment.Reset();
                    SalesComment.SetRange("Document Type", SalesComment."Document Type"::Order);
                    SalesComment.SetRange("No.", "No.");
                    SalesComment.SetFilter("Document Line No.", '%1', 0);
                    if SalesComment.FindFirst() then
                        repeat
                            if CommentText = '' then
                                CommentText := SalesComment.Comment
                            else
                                CommentText := CommentText + ' ' + SalesComment.Comment;
                        until SalesComment.Next() = 0;

                end;


            }


            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, NoOfCopies + 1);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("No of Copies"; NoOfCopies)
                    {
                        ApplicationArea = Planning;
                        Caption = 'No of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
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
        OrderPickingListCaption = 'Pick Instruction';
        PageCaption = 'Page';
        ItemNoCaption = 'Item  No.';
        OrderNoCaption = 'Order No.';
        CustomerNoCaption = 'Customer No.';
        CustomerNameCaption = 'Customer Name';
        QtyToAssembleCaption = 'Quantity to Assemble';
        QtyAssembledCaption = 'Quantity Assembled';
        ShipmentDateCaption = 'Shipment Date';
        QtyPickedCaption = 'Quantity Picked';
        UOMCaption = 'Unit of Measure';
        QtyConsumedCaption = 'Quantity Consumed';
        CopyCaption = 'Copy';
    }

    trigger OnPreReport()
    begin
        DateTxt := Format(Today);
        CompNameText := CompanyName;
    end;

    var
        AsmHeader: Record "Assembly Header";
        CountryRegion: Record "Country/Region";
        NoOfCopies: Integer;
        DateTxt: Text;
        CompNameText: Text;
        QtyToAsm: Decimal;
        AsmExists: Boolean;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        WorkDescriptionInstream: InStream;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        ItemColor: Record LEE_Color;
        TotalQty: Decimal;
        recShipToAdd: Record "Ship-to Address";
        rTShipTo: Record "Ship-to Address" temporary;
        rSLine: Record "Sales Line";
        rShipTo: Record "Ship-to Address";
        CommentText: Text;
        SalesComment: Record "Sales Comment Line";



    local procedure GetUOM(UOMCode: Code[10]): Text
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if UnitOfMeasure.Get(UOMCode) then
            exit(UnitOfMeasure.Description);
        exit(UOMCode);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer)
    begin
        NoOfCopies := NewNoOfCopies;
    end;
}

