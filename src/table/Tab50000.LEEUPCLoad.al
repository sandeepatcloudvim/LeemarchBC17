table 50000 "LEE_UPC_Load"
{
    // version JGTEMP


    fields
    {
        field(1; "ItemNo."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; ColorCode; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(3; ColorDesc; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; SizeCode; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; UPCCode; Code[12])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Item Variant Exists"; Boolean)
        {
            CalcFormula = Exist ("Item Variant" WHERE("Item No." = FIELD("ItemNo."),
                                                      "Color Code" = FIELD(ColorCode),
                                                      "Size Code" = FIELD(SizeCode)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "ItemNo.", ColorCode, SizeCode)
        {
        }
    }

    fieldgroups
    {
    }

}

