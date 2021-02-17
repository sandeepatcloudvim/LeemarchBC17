report 50020 "Create SMTP"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;

        SMTPSetuo: Record "SMTP Mail Setup";

    trigger OnPreReport()
    var
    begin
        SMTPSetuo.Init();
        SMTPSetuo.Validate("Primary Key", 'SMTP LEE');
        SMTPSetuo.Insert(true);
    end;
}