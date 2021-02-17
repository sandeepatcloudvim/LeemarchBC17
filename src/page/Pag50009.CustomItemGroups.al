page 50009 "Custom Item Groups"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Custom Item Group";
    SourceTableView = SORTING("Sort Order");

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Sort Order"; "Sort Order")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
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