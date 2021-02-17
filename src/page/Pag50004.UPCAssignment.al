page 50004 "UPC Assignment"
{
    PageType = ListPart;
    SourceTable = "UPC Assignment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cross-Ref. UPC No."; "Cross-Ref. UPC No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Cross-Ref. Item No."; "Cross-Ref. Item No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Ref. Item Variant Code"; "Cross-Ref. Item Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Cross-Ref. Unit of Measure"; "Cross-Ref. Unit of Measure")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    procedure AssignUPCToItemVariant();
    var
        UPCAssignment: Record "UPC Assignment";
    begin

        UPCAssignment.COPY(Rec);
        UPCAssignment.SETRECFILTER;
        REPORT.RUNMODAL(REPORT::"Assign UPC to Items", true, false, UPCAssignment);
    end;

    procedure AssignUPCToItemVariant_Cat();
    var
        UPCAssignment: Record "UPC Assignment";
    begin

        UPCAssignment.COPY(Rec);
        UPCAssignment.SETRECFILTER;
        REPORT.RUNMODAL(REPORT::"Assign UPC to Items by Catalog", true, false, UPCAssignment);
    end;

    procedure ShowCrossRefEntries();
    var
        ItemXRef: Record "Item Cross Reference";
    begin

        ItemXRef.SETRANGE("Item No.", "Cross-Ref. Item No.");
        if ("Cross-Ref. Item Variant Code" <> '') then
            ItemXRef.SETRANGE("Variant Code", "Cross-Ref. Item Variant Code");
        if ("Cross-Ref. Unit of Measure" <> '') then
            ItemXRef.SETRANGE("Unit of Measure", "Cross-Ref. Unit of Measure");
        PAGE.RUNMODAL(PAGE::"Item Cross Reference Entries", ItemXRef);
    end;
}

