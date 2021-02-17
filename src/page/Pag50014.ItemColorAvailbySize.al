page 50014 "Item Color Avail by Size"
{
    Caption = '';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Availability Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Name)
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}