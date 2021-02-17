tableextension 50016 "LEE_Extends_TransferLine" extends "Transfer Line"
{
    fields
    {
        field(50001; "LEE_Color Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Color"."Color Code" WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate();
            begin

                GetItemVariant();
            end;
        }
        field(50002; "Size Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Size"."Size Code" WHERE("Item No." = FIELD("Item No."));
            trigger OnValidate()
            var
                recItemVariant: Record "Item Variant";
            begin
                recItemVariant.Reset();
                recItemVariant.SetRange("Item No.", "Item No.");
                recItemVariant.SetRange("Color Code", "LEE_Color Code");
                recItemVariant.SetRange("Size Code", "Size Code");

                if recItemVariant.FindFirst() then
                    "Variant Code" := recItemVariant.Code;
            end;
        }
    }

    var
        myInt: Integer;

    local procedure GetItemVariant()
    var
        rItemVariant: Record "Item Variant";
    begin

        rItemVariant.SETRANGE("Item No.", "Item No.");
        rItemVariant.SETRANGE("Color Code", "LEE_Color Code");
        rItemVariant.SETRANGE("Size Code", "Size Code");
        IF NOT (rItemVariant.FINDFIRST) THEN
            CLEAR(rItemVariant);

        VALIDATE("Variant Code", rItemVariant.Code);
    end;
}