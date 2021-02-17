pageextension 50016 "Sales Order List" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        modify("Email Confirmation")
        {
            Visible = false;
        }
        addafter("Email Confirmation")
        {

            action("Leemar Email Confirmation")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Email Confirmation';
                PromotedCategory = Category11;
                Image = Email;
                trigger OnAction()
                begin
                    MultiSenderID();
                end;
            }
        }
    }

    var
        myInt: Integer;
}