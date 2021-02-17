page 50028 "Item Availability by Colors"
{
    Caption = 'Item Availability by Color';
    Editable = true;
    PageType = ListPlus;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Item Color";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Item.Description)
                {
                    ApplicationArea = All;
                }
                field("Color Description"; "Color Description")
                {
                    ApplicationArea = All;
                }
            }
            part(AvailByColorSubform; "Item Avail. Size Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("Item No.");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin

        CurrPage.AvailByColorSubform.PAGE.SetItemColor("Item No.", "Color Code");
        CurrPage.AvailByColorSubform.PAGE.RefreshForm;


    end;

    trigger OnAfterGetRecord();
    begin
        Item.GET("Item No.");
    end;

    var
        Item: Record Item;
}

