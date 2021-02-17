report 50024 "Production Lable New"
{
    DefaultLayout = RDLC;
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './ProcuctionLableNew.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No; "No.")
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
                column(Description; recItem.Description)
                {

                }
                column(Size_Code; "Size Code")
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
                column(Fit; Fit)
                {

                }
                column(Zip; Zip)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Line_No_; "Line No.")
                {


                }
                column(C; C)
                {

                }
                column(R; R)
                {

                }
                trigger OnAfterGetRecord()
                begin

                    if recItem.Get("No.") then;


                    if c = 0 then
                        c := 1
                    else
                        if c = 1 then
                            c := 2
                        else
                            if c = 2 then
                                c := 1;

                    if c = 1 then
                        r += 1;


                end;

            }

            trigger OnPreDataItem()

            begin
                R := 0;
                C := 0;
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
            end;
        }

    }


    var
        CompInfo: Record "Company Information";
        SizeQty: Decimal;
        recItem: Record Item;
        R: Integer;
        C: Integer;
}