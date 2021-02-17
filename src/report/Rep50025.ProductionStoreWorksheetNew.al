report 50025 "Production Store Worksheet New"
{
    DefaultLayout = RDLC;
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './ProcuctionStoreWorksheetNew.rdl';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No; "No.")
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(LEE_Cancel_Date; "LEE_Cancel Date")
            {

            }
            column(Your_Reference; "Your Reference")
            {

            }
            column(CompInfo_Pic; CompInfo.Picture)
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(LEE_Start_Ship_Date; "LEE_Start Ship Date")
            {

            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = where(Type = filter(Item));


                column(Pattern_Code; "Pattern Code")
                {

                }
                column(ItemNo; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Pad; Pad)
                {

                }
                column(Fabric; Fabric)
                {

                }
                column(Lycra_Color; "Lycra Color")
                {

                }
                column(Quantity; Quantity)
                {

                }
                dataitem("Item Size"; "Item Size")
                {
                    DataItemLinkReference = "Sales Line";
                    DataItemTableView = sorting("Size Sort Order") order(Ascending);
                    DataItemLink = "Item No." = field("No.");
                    column(Size_Code; "Size Code")
                    {

                    }
                    column(Size_Description; "Size Description")
                    {

                    }
                    column(SizeQty; SizeQty)
                    {

                    }
                    column(Size_Sort_Order; "Size Sort Order")
                    {

                    }
                    trigger OnAfterGetRecord()
                    begin
                        "Item Size".SetCurrentKey("Size Sort Order");
                        SizeQty := 0;
                        if "Size Code" = "Sales Line"."Size Code" then
                            SizeQty := "Sales Line".Quantity;
                    end;

                }



            }



            trigger OnPreDataItem()

            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
            end;
        }

    }


    var
        CompInfo: Record "Company Information";
        SizeQty: Decimal;
}