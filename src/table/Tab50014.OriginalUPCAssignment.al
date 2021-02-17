table 50014 "Original UPC Assignment"
{

    fields
    {
        field(1; UPC; Code[20])
        {
        }
        field(2; "Item No."; Code[20])
        {
        }
        field(3; "Variant Code"; Code[10])
        {
        }
        field(4; Description; Text[50])
        {
        }
        field(5; "Description 2"; Text[50])
        {
        }
        field(6; "Reassigned to Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(7; "Reassigned to Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Reassigned to Item No."));
        }
        field(8; "Reassigned to Description"; Text[50])
        {
        }
        field(9; "Reassigned to Description 2"; Text[50])
        {
        }
        field(10; "Reassigned XRef Exists"; Boolean)
        {
            CalcFormula = Exist ("Item Cross Reference" WHERE("Cross-Reference No." = FIELD(UPC),
                                                              "Item No." = FIELD("Reassigned to Item No."),
                                                              "Variant Code" = FIELD("Reassigned to Variant Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; UPC)
        {
        }
    }

    fieldgroups
    {
    }
}

