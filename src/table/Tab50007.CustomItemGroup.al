table 50007 "Custom Item Group"
{
    // version OPS31

    DrillDownPageID = "Custom Item Groups";
    LookupPageID = "Custom Item Groups";

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; "Sort Order"; Integer)
        {
        }
        field(4; "Fit Option Active"; Boolean)
        {
        }
        field(5; "Zip Option Active"; Boolean)
        {
        }
        field(6; "Pad Option Active"; Boolean)
        {
        }
        field(7; "Lycra Color Option Active"; Boolean)
        {
        }
        field(8; "Flat Lock Option Active"; Boolean)
        {
        }
        field(9; "Fabric Option Active"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Sort Order")
        {
        }
    }

    fieldgroups
    {
    }
}

