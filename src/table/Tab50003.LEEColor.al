table 50003 "LEE_Color"
{
    // version OPS01

    DrillDownPageID = Colors;
    LookupPageID = Colors;


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
        field(3; "Variant Assignment Code"; Code[5])
        {
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate();
            var
                Color: Record LEE_Color;
                TXT_ERROR_VARIANT_UNIQUE: Label '%1 must be unique and it already exists on %2 %3!';
            begin
                Color.SETCURRENTKEY("Variant Assignment Code");
                Color.SETFILTER(Code, '<>%1', Code);
                Color.SETFILTER("Variant Assignment Code", '<>''''&=%1', "Variant Assignment Code");
                if (Color.FIND('-')) then
                    ERROR(TXT_ERROR_VARIANT_UNIQUE,
                          FIELDCAPTION("Variant Assignment Code"),
                          Color.TABLECAPTION,
                          FORMAT(Color.Code));
            end;
        }
        field(4; "Color Sort Order"; Integer)
        {
            DataClassification = CustomerContent;
            MinValue = 0;
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
        key(Key3; "Color Sort Order")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Field1; Code, Description)
        {

        }

    }

    trigger OnInsert();
    begin
        SetVarAssignmentCode;
    end;

    trigger OnModify();
    begin
        SetVarAssignmentCode;
    end;

    trigger OnRename();
    begin
        SetVarAssignmentCode;
    end;

    procedure SetVarAssignmentCode();
    var
        Color: Record LEE_Color;
        TXT_ERROR_MAX_VARIANT: Label '%1 cannot be set to %2 because it cannot be greater than %3 characters in length!';
    begin
        if ("Variant Assignment Code" = '') then begin
            Color.SETCURRENTKEY("Variant Assignment Code");
            if (Color.FIND('+')) then
                if (STRLEN(INCSTR(Color."Variant Assignment Code")) > MAXSTRLEN("Variant Assignment Code")) then
                    ERROR(TXT_ERROR_MAX_VARIANT,
                          FIELDCAPTION("Variant Assignment Code"),
                          FORMAT(INCSTR(Color."Variant Assignment Code")),
                          MAXSTRLEN("Variant Assignment Code"))
                else
                    "Variant Assignment Code" := INCSTR(Color."Variant Assignment Code");
        end;
    end;
}

