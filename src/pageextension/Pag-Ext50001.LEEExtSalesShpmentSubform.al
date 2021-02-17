pageextension 50001 "LEE_Ext_SalesShpmentSubform" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter(Description)
        {
            field(LEE_Embellishment; LEE_Embellishment)
            {
                Caption = 'Embellishment';
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