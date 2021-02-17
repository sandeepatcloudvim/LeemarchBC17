page 50007 "Pattern Items"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Pattern Item";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Pattern Code"; "Pattern Code")
                {
                    ApplicationArea = All;

                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; "Item Description")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }
}