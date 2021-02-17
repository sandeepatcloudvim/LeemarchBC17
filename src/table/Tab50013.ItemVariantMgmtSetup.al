table 50013 "Item Variant Mgmt. Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Size/Color Variant Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "00","01","02","10","11","12","20","21","22";
            OptionCaption = 'No Saleable Variant / No Sample Variant,No Saleable Variant / Sample Variant,No Saleable Variant / Blocked Sample Variant,Saleable Variant / No Sample Variant,Saleable Variant / Sample Variant,Saleable Variant / Blocked Sample Variant,Blocked Saleable Variant / No Sample Variant,Blocked Saleable Variant / Sample Variant,Blocked Saleable Variant / Blocked Sample Variant';
        }
        field(3; "Sample Code"; Code[2])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(4; "Sample Description"; Text[30])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(5; "Variant Separator"; Code[10])
        {
            DataClassification = CustomerContent;
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