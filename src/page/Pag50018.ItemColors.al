page 50018 "Item Colors"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Color";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Color Code"; "Color Code")
                {
                    ApplicationArea = All;
                }
                field("Color Description"; "Color Description")
                {
                    ApplicationArea = All;
                }
                field("Color Sort Order"; "Color Sort Order")
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