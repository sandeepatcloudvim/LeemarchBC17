pageextension 50017 "Sales Order" extends "Sales Order"
{
    layout
    {
        modify("Promised Delivery Date")
        {
            ApplicationArea = All;
            Visible = false;
        }

        addbefore("Promised Delivery Date")
        {
            field("LEE Shipment Date"; "Shipment Date")
            {
                ApplicationArea = All;
                Caption = 'Shipment Date';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(SendEmailConfirmation)
        {
            Visible = false;
        }
        addafter(AttachAsPDF)
        {

            action("Leemar Email Confirmation")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Email Confirmation';
                PromotedCategory = Category8;
                Image = Email;
                trigger OnAction()
                begin
                    MultiSenderID();
                end;
            }
        }
        addafter(ProformaInvoice)
        {
            action("Production Ticket Label")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Production Ticket Label';
                Ellipsis = true;
                trigger OnAction()
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", "Document Type");
                    SalesHeader.SetRange("No.", "No.");
                    if SalesHeader.FindFirst() then
                        Report.Run(50024, true, true, SalesHeader);
                end;

            }
            action("Production Worksheet")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Production Worksheet';
                Ellipsis = true;

                trigger OnAction()
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", "Document Type");
                    SalesHeader.SetRange("No.", "No.");
                    if SalesHeader.FindFirst() then
                        Report.Run(50023, true, true, SalesHeader);

                end;

            }
            action("Store Prod. Ticket Label")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Store Prod. Ticket Label';
                Ellipsis = true;
                trigger OnAction()
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", "Document Type");
                    SalesHeader.SetRange("Your Reference", "Your Reference");
                    if SalesHeader.FindFirst() then
                        Report.Run(50026, true, true, SalesHeader);

                end;
            }
            action("Store Prod. Worksheet")
            {
                ApplicationArea = All;
                Promoted = true;
                Caption = 'Store Prod. Worksheet';
                Ellipsis = true;
                trigger OnAction()
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", "Document Type");
                    SalesHeader.SetRange("Your Reference", "Your Reference");
                    if SalesHeader.FindFirst() then
                        Report.Run(50025, true, true, SalesHeader);

                end;
            }
        }

    }

    var
        SalesHeader: Record "Sales Header";
}