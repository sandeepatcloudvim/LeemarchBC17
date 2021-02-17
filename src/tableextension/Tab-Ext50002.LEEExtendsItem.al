tableextension 50002 "LEE_Extends_Item" extends Item
{

    fields
    {

        // Add changes to table fields here
        field(50000; "LEE_Qty. on Work Order"; Decimal)
        {
            Caption = 'Qty. on Work Order';
            //fieldClass = FlowField;
            //CalcFormula = Sum("BOM Journal Line"."Quantity (Base)" WHERE("Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter"), "Production Status" = FIELD("Production Status Filter"), "Expected Completion Date" = FIELD("Date Filter")));
        }
        field(50001; "LEE_Production Status Filter"; Code[10])
        {
            Caption = 'Production Status Filter';
            FieldClass = FlowFilter;
        }
        field(50005; "LEE_Qty. in Packages"; Decimal)
        {
            Caption = 'Qty. in Packages';
            //FieldClass = FlowField;
            //CalcFormula = Sum ("Package Line"."Quantity (Base)" WHERE(Type = FILTER(Item), "No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter")));
        }
        field(50010; LEE_Size; Code[10])
        {
            Caption = 'Size';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = LEE_Size;
        }
        field(50011; LEE_Color; Code[10])
        {
            Caption = 'Color';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = LEE_Color;
        }
        field(50013; LEE_Pattern; Code[10])
        {
            Caption = 'Pattern';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = "Custom Pattern"."Pattern Code";
        }
        field(50014; LEE_Zip; Code[10])
        {
            Caption = 'Zip';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = "Custom Option".Code WHERE(Type = FILTER(Zip));
        }
        field(50015; LEE_Fit; Code[10])
        {
            Caption = 'Fit';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = "Custom Option".Code WHERE(Type = FILTER(Fit));
        }
        field(50016; LEE_Pad; Code[10])
        {
            Caption = 'Pad';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = "Custom Option".Code WHERE(Type = FILTER(Pad));
        }
        field(50017; "LEE_Flat Lock"; Code[10])
        {
            Caption = 'Flat Lock';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = "Custom Option".Code WHERE(Type = FILTER("Flat Lock"));
        }
        field(50018; LEE_Fabric; Code[10])
        {
            Caption = 'Fabric';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = "Custom Option".Code WHERE(Type = FILTER(Fabric));
        }
        field(50020; "LEE_Lycra Color"; Code[10])
        {
            Caption = 'Lycra Color';
            DataClassification = CustomerContent;
            Description = 'J141011';
            TableRelation = "Custom Option".Code WHERE(Type = FILTER("Lycra Color"));
        }
        field(50021; "LEE_Custom Item Group"; Code[30])
        {
            Caption = 'Custom Item Group';
            DataClassification = CustomerContent;
            Description = 'J11515';
            TableRelation = "Custom Item Group".Code;
        }
        field(50022; "LEE_Custom Item No."; Code[20])
        {
            Caption = 'Custom Item No.';
            DataClassification = CustomerContent;
            Description = 'J11515';
            TableRelation = "Pattern Item"."Item No." WHERE("Pattern Code" = FIELD(LEE_Pattern));

            trigger OnValidate();
            var
                SLinePreValidate: Record "Sales Line";
            begin
            end;
        }
        field(50023; "LEE_Export Brand Group"; Code[20])
        {
            Caption = 'Export Brand Group';
            DataClassification = CustomerContent;
            TableRelation = "Export Brand Group";
        }



    }

    var
        myInt: Integer;
}