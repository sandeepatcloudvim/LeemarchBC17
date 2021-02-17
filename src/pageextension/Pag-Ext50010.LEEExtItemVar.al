pageextension 50010 "LEE_ExtItemVar" extends "Item Variants"
{
    layout
    {
        // Add changes to page layout here
        addafter(Code)
        {
            field("Size Code"; "Size Code")
            {
                ApplicationArea = All;
            }
            field("Color Code"; "Color Code")
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