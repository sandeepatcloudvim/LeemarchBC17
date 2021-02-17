table 50016 "Production Status"
{
    // version OPS21

    LookupPageID = "Production Status";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Step No."; Integer)
        {
        }
        field(4; "Due Date Formula"; DateFormula)
        {
        }
        field(5; "Notification Event Code"; Code[10])
        {
            // TableRelation = "Notification Event".Code WHERE("Table No." = CONST(36),
            //                                                  "Document Type" = CONST(1));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Step No.")
        {
        }
    }

    fieldgroups
    {
    }
}

