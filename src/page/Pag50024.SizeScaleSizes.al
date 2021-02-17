page 50024 "Size Scale Sizes"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Size Scale Size";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Size Code"; "Size Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        myInt: Integer;
}