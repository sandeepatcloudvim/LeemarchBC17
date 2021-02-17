pageextension 50006 "LEE_Ext_CustList" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Customer Category"; "Customer Category")
            {
                ApplicationArea = All;
            }
        }
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
        addafter("Blanket Orders")
        {
            action("Update Dimension")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Dimension';
                Image = UpdateDescription;
                RunObject = report "UpdateDimensionCode";
            }
            action("Update Shipping Address")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Shipping Address';
                Image = UpdateDescription;
                RunObject = report "Update Shipping Address";
            }
            action("Create SMTP")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create SMTP';
                Image = UpdateDescription;
                RunObject = report "Create SMTP";
            }
        }
    }

    var
        myInt: Integer;
}