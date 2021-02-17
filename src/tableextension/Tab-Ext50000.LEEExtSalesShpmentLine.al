tableextension 50000 "LEE_ExtSalesShpmentLine" extends "Sales Shipment Line"
{
    fields
    {
        // Add changes to table fields here
        field(50035; LEE_Embellishment; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = LEE_Embellishment;
            Caption = 'Embellishment';
        }
        field(50001; "LEE_Color Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Item)) "Item Color"."Color Code" WHERE("Item No." = FIELD("No."));
        }
        field(50002; "Size Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Item)) "Item Size"."Size Code" WHERE("Item No." = FIELD("No."));
            trigger OnValidate()
            var
                recItemVariant: Record "Item Variant";
            begin
                recItemVariant.Reset();
                recItemVariant.SetRange("Item No.", "No.");
                recItemVariant.SetRange("Color Code", "LEE_Color Code");
                recItemVariant.SetRange("Size Code", "Size Code");

                if recItemVariant.FindFirst() then
                    "Variant Code" := recItemVariant.Code;
            end;
        }
        modify("Requested Delivery Date")
        {
            Caption = 'Cancel Date';
        }
    }

    var
        myInt: Integer;
}