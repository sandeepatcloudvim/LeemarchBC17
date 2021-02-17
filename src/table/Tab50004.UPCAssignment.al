table 50004 "UPC Assignment"
{
    // version OPS02


    fields
    {
        field(1; "UCC Manufacturer ID"; Code[6])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Numeric = true;
            SQLDataType = Variant;

            trigger OnValidate();
            begin
                if ("UCC Manufacturer ID" <> '')
                 and (STRLEN("UCC Manufacturer ID") < MAXSTRLEN("UCC Manufacturer ID")) then
                    ERROR(TXT_ERROR_LEN, FIELDCAPTION("UCC Manufacturer ID"), MAXSTRLEN("UCC Manufacturer ID"));
            end;
        }
        field(2; "Base UPC No."; Code[5])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Numeric = true;

            trigger OnValidate();
            begin
                if ("Base UPC No." <> xRec."Base UPC No.") then begin
                    if ("Base UPC No." = '') then
                        "Base UPC No." := TXT_00000;
                    "Cross-Ref. UPC No." := "UCC Manufacturer ID" +
                                             "Base UPC No." +
                                             FORMAT(STRCHECKSUM("UCC Manufacturer ID" + "Base UPC No.", TXT_CHECKSUM));
                end;
            end;
        }
        field(4; "Cross-Ref. Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Item."No.";
        }
        field(5; "Cross-Ref. Item Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Cross-Ref. Item No."));
        }
        field(6; "Cross-Ref. Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Cross-Ref. Item No."));
        }
        field(10; "Cross-Ref. UPC No."; Code[12])
        {
            DataClassification = CustomerContent;
            Description = 'Includes check digit';
            Editable = false;
        }
        field(11; Status; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = Available,Assigned;
        }
    }

    keys
    {
        key(Key1; "UCC Manufacturer ID", "Base UPC No.")
        {
        }
        key(Key2; Status)
        {
        }
        key(Key3; "Cross-Ref. UPC No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        //ERROR(TXT_ERROR_DELETE, TABLECAPTION);
    end;

    trigger OnInsert();
    begin
        // ERROR(TXT_ERROR_INSERT, TABLECAPTION);
    end;

    trigger OnModify();
    begin
        //  ERROR(TXT_ERROR_MODIFY, TABLECAPTION);
    end;

    trigger OnRename();
    begin
        //  ERROR(TXT_ERROR_RENAME, TABLECAPTION);
    end;

    var
        TXT_ERROR_INSERT: Label 'You cannot manually insert a %1 record!';
        TXT_ERROR_MODIFY: Label 'You cannot manually modify a %1 record!';
        TXT_ERROR_DELETE: Label 'You cannot manually delete a %1 record!';
        TXT_ERROR_RENAME: Label 'You cannot manually rename a %1 record!';
        TXT_00000: Label '00000';
        TXT_CHECKSUM: Label '31313131313';
        TXT_ERROR_LEN: Label '%1 must contain %2 digits!';
        TXT_UPC_CODE: Label 'UPC No. - %1';
        UPCRange: Integer;
        AssignUCC14: Boolean;
        TXT_UCC14_CODE: Label 'UCC14 No. - %1';

    procedure GetCrossRefDescription(var InUPCAssignment: Record "UPC Assignment") Desc: Text[50];
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
    begin
        if (ItemVariant.GET(InUPCAssignment."Cross-Ref. Item No.", InUPCAssignment."Cross-Ref. Item Variant Code")) then
            exit(ItemVariant.Description);
        if (Item.GET(InUPCAssignment."Cross-Ref. Item No.")) then
            exit(Item.Description);
    end;

    procedure GetCrossRefDescription2(var InUPCAssignment: Record "UPC Assignment") Desc2: Text[50];
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
    begin
        if (ItemVariant.GET(InUPCAssignment."Cross-Ref. Item No.", InUPCAssignment."Cross-Ref. Item Variant Code")) then
            exit(ItemVariant."Description 2");
        if (Item.GET(InUPCAssignment."Cross-Ref. Item No.")) then
            exit(Item."Description 2");
    end;

    procedure CreateUPCRange(CompanyInfo: Record "Company Information");
    var
        UPCAssignment: Record "UPC Assignment";
        Window: Dialog;
        UPCProgress: Integer;
        UPCIndicator: Integer;
        TXT_CONFIRM_CREATE: Label 'Create UPC range for %1 %2?';
        TXT_ERROR_LEN: Label '%1 must contain %2 digits!';
        BaseUPCCode: Code[5];
        TXT_ERROR_RANGEEXISTS: Label 'Complete UPC range already exists for %1 %2!';
    begin
        BaseUPCCode := TXT_00000;
        UPCRange := 100000;
        UPCProgress := 0;

        if (CompanyInfo."UCC Manufacturer ID" = '')
         or (STRLEN(CompanyInfo."UCC Manufacturer ID") < MAXSTRLEN(CompanyInfo."UCC Manufacturer ID")) then
            ERROR(TXT_ERROR_LEN, CompanyInfo.FIELDCAPTION("UCC Manufacturer ID"), MAXSTRLEN(CompanyInfo."UCC Manufacturer ID"));

        UPCAssignment.SETRANGE("UCC Manufacturer ID", CompanyInfo."UCC Manufacturer ID");
        if (UPCAssignment.COUNT = UPCRange) then
            ERROR(TXT_ERROR_RANGEEXISTS, CompanyInfo.FIELDCAPTION("UCC Manufacturer ID"), CompanyInfo."UCC Manufacturer ID");
        UPCAssignment.RESET;

        if (CONFIRM(TXT_CONFIRM_CREATE,
                    false,
                    CompanyInfo.FIELDCAPTION("UCC Manufacturer ID"),
                    CompanyInfo."UCC Manufacturer ID")) then begin

            Window.OPEN('Assigning UPC No. range...        \' +
                        'Manufacturer ID:        #1########\' +
                        'UPC No.:                #2########\' +
                        'Progress:     @3@@@@@@@@@@@@@@@@@@',
                        CompanyInfo."UCC Manufacturer ID",
                        UPCAssignment."Base UPC No.",
                        UPCIndicator);

            repeat

                CLEAR(UPCAssignment);

                UPCAssignment."UCC Manufacturer ID" := CompanyInfo."UCC Manufacturer ID";
                UPCAssignment.VALIDATE("Base UPC No.", BaseUPCCode);
                Window.UPDATE(2);
                if not (UPCAssignment.INSERT) then;

                UPCProgress += 1;
                UPCIndicator := ROUND((UPCProgress / UPCRange) * 10000, 1);
                Window.UPDATE(3);

                if (UPCProgress < UPCRange) then
                    BaseUPCCode := INCSTR(BaseUPCCode);

            until (UPCProgress >= UPCRange);

            Window.CLOSE;

        end;
    end;

    procedure GetAllocationInd(CompanyInfo: Record "Company Information") AllocIndicator: Decimal;
    var
        UPCAssignmentAlloc: Record "UPC Assignment";
        UPCCountAlloc: Integer;
    begin
        UPCRange := 100000;
        UPCAssignmentAlloc.SETCURRENTKEY(Status);
        UPCAssignmentAlloc.SETRANGE(Status, UPCAssignmentAlloc.Status::Assigned);
        UPCCountAlloc := UPCAssignmentAlloc.COUNT;

        if (UPCRange <> 0) then
            AllocIndicator := ROUND((UPCCountAlloc / UPCRange) * 10000, 1)
        else
            AllocIndicator := 0;

        exit(AllocIndicator);
    end;

    procedure ManualAssignXRef(var InXRef: Record "Item Cross Reference"; var InUPCAssignment: Record "UPC Assignment"; bNewRecord: Boolean);
    begin
        InUPCAssignment."Cross-Ref. Item No." := InXRef."Item No.";
        InUPCAssignment."Cross-Ref. Item Variant Code" := InXRef."Variant Code";
        InUPCAssignment."Cross-Ref. Unit of Measure" := InXRef."Unit of Measure";
        InUPCAssignment.Status := InUPCAssignment.Status::Assigned;
        InUPCAssignment.MODIFY;

        InXRef."Item No." := InUPCAssignment."Cross-Ref. Item No.";
        InXRef."Variant Code" := InUPCAssignment."Cross-Ref. Item Variant Code";
        InXRef."Unit of Measure" := InUPCAssignment."Cross-Ref. Unit of Measure";
        InXRef."Cross-Reference Type" := InXRef."Cross-Reference Type"::"Bar Code";
        InXRef."Cross-Reference No." := InUPCAssignment."Cross-Ref. UPC No.";
        InXRef.Description := STRSUBSTNO(TXT_UPC_CODE, InUPCAssignment."Cross-Ref. UPC No.");
        InXRef."UPC No." := true;
        InXRef."UCC14 No." := false;
        if (bNewRecord) then begin
            if not (InXRef.INSERT) then
                InXRef.MODIFY;
        end;
    end;

    procedure AssignXRef(var InUPCAssignment: Record "UPC Assignment");
    var
        ItemXRef: Record "Item Cross Reference";
    begin
        ItemXRef.SETRANGE("Item No.", InUPCAssignment."Cross-Ref. Item No.");
        ItemXRef.SETRANGE("Variant Code", InUPCAssignment."Cross-Ref. Item Variant Code");
        ItemXRef.SETRANGE("Unit of Measure", InUPCAssignment."Cross-Ref. Unit of Measure");
        ItemXRef.SETRANGE("Cross-Reference Type", ItemXRef."Cross-Reference Type"::"Bar Code");
        ItemXRef.SETRANGE("UPC No.", true);

        if not (ItemXRef.FINDFIRST) then begin

            ItemXRef."Item No." := InUPCAssignment."Cross-Ref. Item No.";
            ItemXRef."Variant Code" := InUPCAssignment."Cross-Ref. Item Variant Code";
            ItemXRef."Unit of Measure" := InUPCAssignment."Cross-Ref. Unit of Measure";
            ItemXRef."Cross-Reference Type" := ItemXRef."Cross-Reference Type"::"Bar Code";
            ItemXRef."Cross-Reference No." := InUPCAssignment."Cross-Ref. UPC No.";
            ItemXRef.Description := STRSUBSTNO(TXT_UPC_CODE, InUPCAssignment."Cross-Ref. UPC No.");
            ItemXRef."UPC No." := true;
            ItemXRef."UCC14 No." := false;
            ItemXRef.INSERT;

            InUPCAssignment.Status := InUPCAssignment.Status::Assigned;
            InUPCAssignment.MODIFY;

        end;

        // OPS83: Begin
        if (AssignUCC14) then
            AssignUCC14XRefs(ItemXRef);
        // OPS83: End
    end;

    procedure UnAssignXRef(var InXRef: Record "Item Cross Reference");
    var
        UPCAssignment: Record "UPC Assignment";
        XRef: Record "Item Cross Reference";
    begin
        UPCAssignment.SETCURRENTKEY("Cross-Ref. UPC No.");
        UPCAssignment.SETRANGE("Cross-Ref. UPC No.", InXRef."Cross-Reference No.");
        if (UPCAssignment.FINDFIRST) then begin
            UPCAssignment."Cross-Ref. Item No." := '';
            UPCAssignment."Cross-Ref. Item Variant Code" := '';
            UPCAssignment."Cross-Ref. Unit of Measure" := '';
            UPCAssignment.Status := UPCAssignment.Status::Available;
            UPCAssignment.MODIFY;
        end;

        XRef.SETCURRENTKEY("Cross-Reference No.");
        XRef.SETFILTER("Cross-Reference No.", '*%1*', COPYSTR(InXRef."Cross-Reference No.", 1, 11));
        XRef.DELETEALL;
    end;

    procedure CheckUPCXRefExists(var InXRef: Record "Item Cross Reference") UPCXRefExists: Boolean;
    var
        ItemXRef: Record "Item Cross Reference";
    begin
        ItemXRef.SETRANGE("Item No.", InXRef."Item No.");
        ItemXRef.SETRANGE("Variant Code", InXRef."Variant Code");
        ItemXRef.SETRANGE("Unit of Measure", InXRef."Unit of Measure");
        ItemXRef.SETRANGE("Cross-Reference Type", InXRef."Cross-Reference Type");
        ItemXRef.SETRANGE("UPC No.", true);
        exit(ItemXRef.FINDFIRST);
    end;

    procedure SetAssignUCC14();
    begin
        AssignUCC14 := true;
    end;

    procedure AssignUCC14XRefs(var rInXRef: Record "Item Cross Reference");
    var
        rItemUOM: Record "Item Unit of Measure";
        rUCC14XRef: Record "Item Cross Reference";
        iPkgIndicator: Integer;
        TXT_CHECKSUM: Label '3131313131313';
    begin
        rItemUOM.SETCURRENTKEY("Item No.", "Qty. per Unit of Measure");
        rItemUOM.SETRANGE("Item No.", rInXRef."Item No.");
        rItemUOM.SETFILTER("Qty. per Unit of Measure", '>1');
        if (rItemUOM.FINDSET(false, false)) then begin

            rUCC14XRef.SETCURRENTKEY("Attached-to UPC No.");
            rUCC14XRef.SETRANGE("Attached-to UPC No.", rInXRef."Cross-Reference No.");
            rUCC14XRef.DELETEALL;
            rUCC14XRef.RESET;

            iPkgIndicator := 1;
            repeat
                rUCC14XRef.TRANSFERFIELDS(rInXRef);
                rUCC14XRef."Cross-Reference No." := FORMAT(iPkgIndicator) + '0' + COPYSTR(rInXRef."Cross-Reference No.", 1, 11);
                rUCC14XRef."Cross-Reference No." := rUCC14XRef."Cross-Reference No." +
                                                    FORMAT(STRCHECKSUM(rUCC14XRef."Cross-Reference No.", TXT_CHECKSUM));
                rUCC14XRef.Description := STRSUBSTNO(TXT_UCC14_CODE, rUCC14XRef."Cross-Reference No.");
                rUCC14XRef."Unit of Measure" := rItemUOM.Code;
                rUCC14XRef."Attached-to UPC No." := rInXRef."Cross-Reference No.";
                rUCC14XRef."UPC No." := false;
                rUCC14XRef."UCC14 No." := true;
                rUCC14XRef.INSERT;
                iPkgIndicator += 1;
            until (rItemUOM.NEXT = 0)
             or (iPkgIndicator = 9);

        end;
    end;
}

