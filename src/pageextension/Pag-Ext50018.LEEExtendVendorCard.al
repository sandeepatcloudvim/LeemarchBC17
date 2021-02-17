pageextension 50018 ExtendLeeVendorCard extends "Vendor Card"
{
    layout
    {
        addafter(Blocked)
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