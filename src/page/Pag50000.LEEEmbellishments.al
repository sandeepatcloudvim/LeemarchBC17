page 50000 "LEE_Embellishments"
{
    Caption = 'Embellishments';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LEE_Embellishment;

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
                field(Descripton; Descripton)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}