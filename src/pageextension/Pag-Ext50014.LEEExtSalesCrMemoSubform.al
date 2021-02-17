pageextension 50014 "LEE_Ext_SalesCrMemoSub" extends "Sales Cr. Memo Subform"
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