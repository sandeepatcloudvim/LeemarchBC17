pageextension 50013 "LEE_Ext_POInvSubform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("LEE_Color Code"; "LEE_Color Code")
            {
                Caption = 'Color Code';
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