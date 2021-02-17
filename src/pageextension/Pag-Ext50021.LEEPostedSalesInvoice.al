pageextension 50021 LEEExtPostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Email)
        {
            Visible = false;
        }
        addafter(Email)
        {
            action("Leemar Email Confirmation")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to email the document. The Send Email window opens prefilled with the customer''s email address so you can add or edit information.';

                trigger OnAction()
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.EmailRecords(true);
                    MultiSenderID();
                end;
            }
        }
    }

    var
        myInt: Integer;
        SalesInvHeader: Record "Sales Invoice Header";
}