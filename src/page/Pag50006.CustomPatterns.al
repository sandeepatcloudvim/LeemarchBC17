page 50006 "Custom Patterns"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Custom Pattern";

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
                field("Custom Item Group No."; "Custom Item Group No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Image File Location"; "Image File Location")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Items)
            {
                ApplicationArea = All;
                RunObject = Page "Pattern Items";
                Image = Item;
                trigger OnAction();
                begin

                end;
            }
        }
    }
}