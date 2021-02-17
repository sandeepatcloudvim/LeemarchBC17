table 50022 SMTPMultiSetup
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "SMTP Server"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Authentication; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Default;
            OptionCaption = 'Anonymous,NTLM,Basic';

        }
        field(4; "User ID"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "SMTP Server Port"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Secure Connection"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Password Key"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Send As"; Text[250])
        {

        }
        field(9; "Allow Sender Substitution"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "System ID"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }




    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}