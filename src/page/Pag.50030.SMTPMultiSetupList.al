page 50030 "SMTP Multi Setup List"
{
    Caption = 'SMTP Multi Setup List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = SMTPMultiSetup;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Primary Key"; "Primary Key")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("SMTP Server"; "SMTP Server")
                {
                    ApplicationArea = All;
                }
                field(Authentication; Authentication)
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("SMTP Server Port"; "SMTP Server Port")
                {
                    ApplicationArea = All;
                }
                field("Secure Connection"; "Secure Connection")
                {
                    ApplicationArea = All;
                }
                field("Password Key"; "Password Key")
                {
                    ApplicationArea = All;
                }
                field("System ID"; "System ID")
                {
                    ApplicationArea = All;
                }
                field("Send As"; "Send As")
                {
                    ApplicationArea = All;
                }
                field("Allow Sender Substitution"; "Allow Sender Substitution")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}