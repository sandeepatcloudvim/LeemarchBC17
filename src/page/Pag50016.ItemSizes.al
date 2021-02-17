page 50016 "Item Sizes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Size";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = ALl;
                }
                field("Size Code"; "Size Code")
                {
                    ApplicationArea = All;
                }
                field("Size Description"; "Size Description")
                {
                    ApplicationArea = All;
                }
                field("Size Sort Order"; "Size Sort Order")
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
            action("Create Item Sizes")
            {
                ApplicationArea = All;
                Image = Create;

                trigger OnAction();
                var
                    rItemSize: Record "Item Size";
                begin

                    rItemSize := Rec;
                    rItemSize.SETRECFILTER;
                    REPORT.RUNMODAL(REPORT::"Create Item Sizes", TRUE, FALSE, rItemSize);
                end;
            }
        }
    }
}