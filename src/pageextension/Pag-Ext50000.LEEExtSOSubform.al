pageextension 50000 "LEE_Ext_SOSubform" extends "Sales Order Subform"
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
            field("Ship-to Code"; "Ship-to Code")
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
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Calculation Type"; "VAT Calculation Type")
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