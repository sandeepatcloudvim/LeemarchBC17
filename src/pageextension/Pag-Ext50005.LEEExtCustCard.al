pageextension 50005 "LEE_Ext_CustCard" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Blocked)
        {
            field("Customer Category"; "Customer Category")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Shipping)
        {
            group(EDI)
            {
                field("SPS Vendor No."; "SPS Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("SPS Vendor File Ext"; "SPS Vendor File Ext")
                {
                    ApplicationArea = All;
                }
                field("SPS Trading Partner ID"; "SPS Trading Partner ID")
                {
                    ApplicationArea = All;
                }
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