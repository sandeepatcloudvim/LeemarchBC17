table 50010 "Custom Option"
{
    // version OPS31

    DrillDownPageID = "Custom Options";
    LookupPageID = "Custom Options";

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Fit,Zip,Pad,"Lycra Color","Flat Lock",Fabric;
        }
        field(2; "Code"; Code[10])
        {
        }
        field(3; Description; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

