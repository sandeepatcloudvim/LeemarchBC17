pageextension 50019 LEEEtendVendorList extends "Vendor List"
{
    layout
    {
        addafter("Balance Due (LCY)")
        {
            field("Global Dimension 1 Code"; "Global Dimension 1 Code")
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