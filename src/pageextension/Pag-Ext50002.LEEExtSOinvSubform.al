pageextension 50002 "LEE_Ext_SOinvSubform" extends "Posted Sales Invoice Subform"
{
    layout
    {

        addfirst(Control1)
        {
            field("Custom Item Group"; "Custom Item Group")
            {
                ApplicationArea = All;
            }
            field("Pattern Code"; "Pattern Code")
            {
                ApplicationArea = ALl;
            }
            field("Custom Item No."; "Custom Item No.")
            {
                ApplicationArea = All;
            }
            field(Fit; Fit)
            {
                ApplicationArea = All;
            }
            field(Zip; Zip)
            {
                ApplicationArea = All;
            }
            field(Pad; Pad)
            {
                ApplicationArea = All;
            }
            field("Lycra Color"; "Lycra Color")
            {
                ApplicationArea = All;
            }
            field("Flat Lock"; "Flat Lock")
            {
                ApplicationArea = All;
            }
            field(Fabric; Fabric)
            {
                ApplicationArea = All;
            }
        }
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