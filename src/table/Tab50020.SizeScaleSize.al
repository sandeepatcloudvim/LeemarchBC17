table 50020 "Size Scale Size"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Size Scale Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Size Scale".Code;
        }
        field(2; "Size Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = LEE_Size.Code;

            trigger OnValidate()
            begin
                rSize.GET("Size Code");
                CALCFIELDS(Description);
                "Size Sort Order" := rSize."Size Sort Order";
            end;
        }
        field(3; Description; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup (LEE_Size.Description WHERE(Code = FIELD("Size Code")));
            Editable = false;
        }
        field(4; "Size Sort Order"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Size Scale Code", "Size Code")
        {
            Clustered = true;
        }
        key(SK; "Size Scale Code", "Size Sort Order")
        {

        }
    }

    var
        rSize: Record LEE_Size;

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