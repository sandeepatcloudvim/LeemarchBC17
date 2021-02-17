page 50003 "Production Status"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production Status";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Step No."; "Step No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date Formula"; "Due Date Formula")
                {
                    ApplicationArea = All;
                }
                field("Notification Event Code"; "Notification Event Code")
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