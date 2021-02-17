table 50008 "Custom Pattern"
{
    // version OPS31

    DrillDownPageID = "Custom Patterns";
    LookupPageID = "Custom Patterns";

    fields
    {
        field(1; "Pattern Code"; Code[10])
        {
        }
        field(2; "Custom Item Group No."; Code[30])
        {
            TableRelation = "Custom Item Group".Code;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Image File Location"; Code[250])
        {
        }
    }

    keys
    {
        key(Key1; "Pattern Code")
        {
        }
    }

    fieldgroups
    {
    }
}

