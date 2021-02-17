table 50011 "Item Size"
{
    // version OPS01

    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item."No.";
        }
        field(2; "Size Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = LEE_Size.Code;

            trigger OnValidate();
            var
                Size: Record LEE_Size;
            begin
                IF ("Size Sort Order" = 0) THEN BEGIN
                    Size.GET("Size Code");
                    "Size Sort Order" := Size."Size Sort Order";
                END;
                CALCFIELDS("Size Description");
            end;
        }
        field(3; "Size Description"; Text[30])
        {
            CalcFormula = Lookup (LEE_Size.Description WHERE(Code = FIELD("Size Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Size Sort Order"; Integer)
        {
            MinValue = 0;
        }
        field(5; "Variant Assignment Code"; Code[3])
        {
            CalcFormula = Lookup (LEE_Size."Variant Assignment Code" WHERE(Code = FIELD("Size Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Size Code")
        {
        }
        key(Key2; "Size Sort Order")
        {
        }
        key(Key3; "Item No.", "Size Sort Order")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ItemColor: Record "Item Color";
        Variant: Record "Item Variant";
        VarCodeFilter: Text[10];
    begin
        CALCFIELDS("Variant Assignment Code");
        VarCodeFilter := PADSTR(VarCodeFilter, MAXSTRLEN(ItemColor."Variant Assignment Code"), '?') +
                         "Variant Assignment Code" + '*';

        Variant.SETRANGE("Item No.", "Item No.");
        Variant.SETFILTER(Code, VarCodeFilter);
        Variant.DELETEALL(TRUE);
    end;

    trigger OnInsert();
    var
        ItemVarMgmt: Codeunit "Item Variant Management";
    begin
        ItemVarMgmt.SetSizeVariantSetup(Rec);
    end;

    trigger OnRename();
    var
        TXT_ERROR_RENAME: Label 'You cannot rename a %1 record.';
    begin
        ERROR(TXT_ERROR_RENAME, TABLECAPTION);
    end;
}

