pageextension 50011 "LEE_ExtItemJournalLine" extends "Item Journal"
{
    layout
    {
        addafter("Item No.")
        {
            field("Color Code"; "Color Code")
            {
                ApplicationArea = All;
            }
            field("Size Code"; "Size Code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}