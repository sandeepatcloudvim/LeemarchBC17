page 50019 "Item Variant Mgmt. Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Variant Mgmt. Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Size/Color Variant Type"; "Size/Color Variant Type")
                {
                    ApplicationArea = All;
                }
                field("Sample Code"; "Sample Code")
                {
                    ApplicationArea = All;
                }
                field("Sample Description"; "Sample Description")
                {
                    ApplicationArea = All;
                }
                field("Variant Separator"; "Variant Separator")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        myInt: Integer;
}