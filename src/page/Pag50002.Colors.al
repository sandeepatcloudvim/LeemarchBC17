page 50002 "Colors"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LEE_Color;


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
                field("Variant Assignment Code"; "Variant Assignment Code")
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