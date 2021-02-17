page 50005 "Customer CC List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Customer CC Info";
    Editable = false;
    CardPageId = "Customer CC Info";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Card ID"; "Card ID")
                {
                    ApplicationArea = All;

                }
                field("Card Description"; "Card Description")
                {
                    ApplicationArea = All;
                }
                field("Card Type"; "Card Type")
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