table 50012 "Item Color"
{
    // version OPS01

    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item."No.";
        }
        field(2; "Color Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = LEE_Color.Code;

            trigger OnValidate();
            var
                Color: Record LEE_Color;
            begin
                IF ("Color Sort Order" = 0) THEN BEGIN
                    Color.GET("Color Code");
                    "Color Sort Order" := Color."Color Sort Order";
                END;

                CALCFIELDS("Color Description");
            end;
        }
        field(3; "Color Description"; Text[30])
        {
            CalcFormula = Lookup(LEE_Color.Description WHERE(Code = FIELD("Color Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Color Sort Order"; Integer)
        {
            MinValue = 0;
        }
        field(5; "Variant Assignment Code"; Code[4])
        {
            CalcFormula = Lookup(LEE_Color."Variant Assignment Code" WHERE(Code = FIELD("Color Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Color Code")
        {
        }
        key(Key2; "Color Sort Order")
        {
        }
        key(Key3; "Item No.", "Color Sort Order")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Item No.", "Color Code", "Color Description")
        {

        }
    }

    trigger OnDelete();
    var
        ItemSize: Record "Item Size";
        Variant: Record "Item Variant";
        VarCodeFilter: Text[10];
    begin
        CALCFIELDS("Variant Assignment Code");
        VarCodeFilter := "Variant Assignment Code" +
                         PADSTR(VarCodeFilter, MAXSTRLEN(ItemSize."Variant Assignment Code"), '?') + '*';

        Variant.SETRANGE("Item No.", "Item No.");
        Variant.SETFILTER(Code, VarCodeFilter);
        Variant.DELETEALL(TRUE);
    end;

    trigger OnInsert();
    var
        ItemVarMgmt: Codeunit "Item Variant Management";
    begin
        ItemVarMgmt.SetColorVariantSetup(Rec);
    end;

    trigger OnRename();
    var
        TXT_ERROR_RENAME: Label 'You cannot rename a %1 record.';
    begin
        ERROR(TXT_ERROR_RENAME, TABLECAPTION);
    end;
}

