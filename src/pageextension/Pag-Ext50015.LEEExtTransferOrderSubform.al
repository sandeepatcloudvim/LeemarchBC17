pageextension 50015 "LEE_Ext_TransferOrderSubform" extends "Transfer Order Subform"
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