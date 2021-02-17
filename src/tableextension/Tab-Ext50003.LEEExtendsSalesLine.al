tableextension 50003 "LEE_Extends_SalesLine" extends "Sales Line"
{
    fields
    {
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

            trigger OnValidate();
            begin
                GetItemVariant();
            end;
        }
        field(50003; "PKG_CUSTOM3"; Integer)
        {
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'Field Id mismatch';
        }
        field(50004; "Custom_PKG_CUSTOM3"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PKG_CUSTOM3';
        }
        field(50012; "Production Status"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Production Status".Code;

            trigger OnValidate()
            var
                ProdStatus: Record "Production Status";
                SalesLineStatusTest: Record "Sales Line";
                // EventMgmt: Codeunit "Event Management";
                // NotifyEvent: Record "Notification Event";
                SalesHeader: Record "Sales Header";
            begin

                IF (ProdStatus.GET("Production Status")) THEN BEGIN
                    IF (FORMAT(ProdStatus."Due Date Formula") <> '') THEN
                        "Status Due Date" := CALCDATE(ProdStatus."Due Date Formula", TODAY);
                END ELSE
                    "Status Due Date" := 0D;

                // OPS21: Begin
                // IF ("Production Status" <> xRec."Production Status") THEN BEGIN
                //     IF (ProdStatus.GET("Production Status")) THEN BEGIN
                //         // IF (NotifyEvent.GET(ProdStatus."Notification Event Code")) THEN BEGIN
                //         //     SalesLineStatusTest.SETRANGE("Document Type", "Document Type");
                //         //     SalesLineStatusTest.SETRANGE("Document No.", "Document No.");
                //         //     SalesLineStatusTest.SETRANGE(Type, Type::Item);
                //         //     SalesLineStatusTest.SETFILTER("Production Status", '<>%1', "Production Status");
                //         //     SalesLineStatusTest.SETFILTER("Line No.", '<>%1', "Line No.");
                //         //     IF NOT (SalesLineStatusTest.FINDFIRST) THEN BEGIN
                //         //         IF (SalesHeader.GET("Document Type", "Document No.")) THEN
                //         //             EventMgmt.AddSalesDocEvent(SalesHeader, NotifyEvent.Code, '');
                //         //     END;
                //         END;
                //     END;
                // END;
                // OPS21: End
            end;
        }
        field(50013; "Status Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50014; "Matrix Group No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50020; "Custom Item Group"; Code[30])
        {
            TableRelation = "Custom Item Group".Code;
        }

        field(50021; "Pattern Code"; Code[10])
        {
            TableRelation = "Custom Pattern"."Pattern Code" WHERE("Custom Item Group No." = FIELD("Custom Item Group"));
        }
        field(50022; "Custom Item No."; Code[20])
        {
            TableRelation = "Pattern Item"."Item No." WHERE("Pattern Code" = FIELD("Pattern Code"));
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
        field(50023; "No Order History"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50024; Fit; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Custom Option".Code WHERE(Type = CONST(Fit));
        }
        field(50025; Zip; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Custom Option".Code WHERE(Type = CONST(Zip));
        }
        field(50026; Pad; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Custom Option".Code WHERE(Type = CONST(Pad));
        }
        field(50027; "Lycra Color"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Custom Option".Code WHERE(Type = CONST("Lycra Color"));
        }
        field(50028; "Flat Lock"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Custom Option".Code WHERE(Type = CONST("Flat Lock"));
        }
        field(50029; Fabric; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Custom Option".Code WHERE(Type = CONST(Fabric));
        }
        field(50031; "Proof Path"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Ship-to Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                recItem: Record Item;
            begin
                if recItem.get("No.") then begin
                    "Custom Item Group" := recItem."LEE_Custom Item Group";
                    Fit := recItem.LEE_Fit;
                    Pad := recItem.LEE_Pad;
                    "Pattern Code" := recItem.LEE_Pattern;
                    "Custom Item No." := recItem."LEE_Custom Item No.";
                    Zip := recItem.LEE_Zip;
                    "Lycra Color" := recItem."LEE_Lycra Color";
                    "Flat Lock" := recItem."LEE_Flat Lock";
                    Fabric := recItem.LEE_Fabric;
                end;
            end;
        }
        modify("Requested Delivery Date")
        {
            Caption = 'Cancel Date';
        }
    }

    var
        myInt: Integer;

    local procedure GetItemVariant()
    var
        rItemVariant: Record "Item Variant";
    begin

        rItemVariant.SETRANGE("Item No.", Rec."No.");
        rItemVariant.SETRANGE("Color Code", Rec."LEE_Color Code");
        rItemVariant.SETRANGE("Size Code", Rec."Size Code");
        if rItemVariant.FindFirst() then
            "Variant Code" := rItemVariant.Code;
    end;
}