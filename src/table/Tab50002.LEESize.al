table 50002 "LEE_Size"
{
    // version OPS01

    DrillDownPageID = Sizes;
    LookupPageID = Sizes;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Variant Assignment Code"; Code[3])
        {
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate();
            var
                Size: Record LEE_Size;
                TXT_ERROR_VARIANT_UNIQUE: Label '%1 must be unique and it already exists on %2 %3!';
            begin
                Size.SETCURRENTKEY("Variant Assignment Code");
                Size.SETFILTER(Code, '<>%1', Code);
                Size.SETFILTER("Variant Assignment Code", '<>''''&=%1', "Variant Assignment Code");
                if (Size.FIND('-')) then
                    ERROR(TXT_ERROR_VARIANT_UNIQUE,
                          FIELDCAPTION("Variant Assignment Code"),
                          Size.TABLECAPTION,
                          FORMAT(Size.Code));
            end;
        }
        field(4; "Size Sort Order"; Integer)
        {
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(50006; "Std. Pack Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure".Code;
        }
        field(50007; "Std. Packs per Package"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Variant Assignment Code")
        {
        }
        key(Key3; "Size Sort Order")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        SetVarAssignmentCode;
    end;

    procedure SetVarAssignmentCode();
    var
        Size: Record LEE_Size;
        TXT_ERROR_MAX_VARIANT: Label '%1 cannot be set to %2 because it cannot be greater than %3 characters in length!';
    begin
        if ("Variant Assignment Code" = '') then begin
            Size.SETCURRENTKEY("Variant Assignment Code");
            if (Size.FIND('+')) then
                if (STRLEN(INCSTR(Size."Variant Assignment Code")) > MAXSTRLEN("Variant Assignment Code")) then
                    ERROR(TXT_ERROR_MAX_VARIANT,
                          FIELDCAPTION("Variant Assignment Code"),
                          FORMAT(INCSTR(Size."Variant Assignment Code")),
                          MAXSTRLEN("Variant Assignment Code"))
                else
                    "Variant Assignment Code" := INCSTR(Size."Variant Assignment Code");
        end;
    end;
}

