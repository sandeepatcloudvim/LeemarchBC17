table 50021 TemplBlob
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Code[1])
        {
            DataClassification = ToBeClassified;

        }
        field(2; MyBlob; Blob)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; PrimaryKey)
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