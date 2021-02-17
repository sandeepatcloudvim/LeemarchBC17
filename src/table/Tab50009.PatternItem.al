table 50009 "Pattern Item"
{
    // version OPS31

    DrillDownPageID = "Pattern Items";
    LookupPageID = "Pattern Items";

    fields
    {
        field(1; "Pattern Code"; Code[20])
        {
            TableRelation = "Custom Pattern"."Pattern Code";
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(3; "Item Description"; Text[50])
        {
            CalcFormula = Lookup (Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Pattern Code", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        TESTFIELD("Pattern Code");
        TESTFIELD("Item No.");
    end;
}

