tableextension 50006 "LEE_Extends_ItemCrossRef" extends "Item Cross Reference"
{
    fields
    {
        field(50000; "UPC No."; Boolean)
        {
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50001; "Cross-Reference Description"; Text[50])
        {
            CalcFormula = Lookup("Item Variant".Description WHERE("Item No." = FIELD("Item No."),
                                                                   Code = FIELD("Variant Code")));
            //Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Cross-Reference Description 2"; Text[50])
        {
            CalcFormula = Lookup("Item Variant"."Description 2" WHERE("Item No." = FIELD("Item No."),
                                                                       Code = FIELD("Variant Code")));
            //Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Attached-to UPC No."; Code[20])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(50004; "UCC14 No."; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    var
        UPCAssignment: Record "UPC Assignment";
        TXT_ERROR_MODIFY_UPC: Label 'You cannot manually modify this %1 record because it refers to a UPC!\To change the UPC cross reference, delete the record and reassign another UPC.';
        TXT_ERROR_RESERVED_UPC: Label 'You cannot use %1 %2 because this number refers to a UPC\and a %1 record already exists referencing this %3, %4, and %5.';
        TXT_ERROR_CANCELLED: Label 'The process has been cancelled.';
        TXT_CONFIRM_USEUPC: Label '%1 %2 is a reserved UPC!\\If you create this record, the UPC %2 will be removed from\the pool of available UPCs and will be assigned to %3 %4, %5 %6, %7 %8.\\Continue?';
        TXT_CONFIRM_UPCDEL: Label '%1 %2 is a reserved UPC!\\If you delete this record, the UPC %2 will be returned\to the pool of available UPCs and will be available to be reassigned\to another Item/Variant/Unit of Measure combination.\\Continue?';
        TXT_ERROR_MODIFY_UCC14: Label 'You cannot manually modify this %1 record because it refers to %2 %3!\To change this %1 record , delete the record with %2 %3 and reassign the UPC for that Item/Variant combination.';
        ItemXRef: Record "Item Cross Reference";



    // trigger OnInsert()
    // begin

    // OPS65: Begin
    //     IF ("Cross-Reference Type" = "Cross-Reference Type"::"Bar Code") THEN BEGIN
    //         UPCAssignment.SETCURRENTKEY("Cross-Ref. UPC No.");
    //         UPCAssignment.SETRANGE("Cross-Ref. UPC No.", COPYSTR("Cross-Reference No.", 1, MAXSTRLEN(UPCAssignment."Cross-Ref. UPC No.")));
    //         IF (UPCAssignment.FINDFIRST) THEN BEGIN
    //             IF (UPCAssignment.Status = UPCAssignment.Status::Available)
    //              AND NOT (UPCAssignment.CheckUPCXRefExists(Rec)) THEN BEGIN

    //                 IF NOT (CONFIRM(TXT_CONFIRM_USEUPC,
    //                                 TRUE,
    //                                 FIELDCAPTION("Cross-Reference No."),
    //                                 "Cross-Reference No.",
    //                                 FIELDCAPTION("Item No."),
    //                                 "Item No.",
    //                                 FIELDCAPTION("Variant Code"),
    //                                 "Variant Code",
    //                                 FIELDCAPTION("Unit of Measure"),
    //                                 "Unit of Measure")) THEN
    //                     ERROR(TXT_ERROR_CANCELLED)
    //                 ELSE BEGIN
    //                     UPCAssignment.SetAssignUCC14();
    //                     UPCAssignment.ManualAssignXRef(Rec, UPCAssignment, FALSE);
    //                 END;
    //             END ELSE
    //                 ERROR(TXT_ERROR_RESERVED_UPC,
    //                       FIELDCAPTION("Cross-Reference No."),
    //                       "Cross-Reference No.",
    //                       FIELDCAPTION("Item No."),
    //                       FIELDCAPTION("Variant Code"),
    //                       FIELDCAPTION("Unit of Measure"));

    //         END;

    //     END;
    //     // OPS65: End

    // end;

    // // trigger OnModify()
    // // begin

    // //     // // // OPS65: Begin
    // //     // IF ("UPC No.") THEN
    // //     //     ERROR(TXT_ERROR_MODIFY_UPC, TABLECAPTION);
    // //     // // // OPS65: End

    // //     // // // OPS83: Begin
    // //     // IF ("Attached-to UPC No." <> '') THEN
    // //     //     ERROR(TXT_ERROR_MODIFY_UCC14, TABLECAPTION, FIELDCAPTION("UPC No."), "Attached-to UPC No.");
    // //     // // // OPS83: End

    // // end;

    // // trigger OnDelete()
    // // begin

    // //     // OPS83: Begin
    // //     IF ("Attached-to UPC No." <> '') THEN
    // //         ERROR(TXT_ERROR_MODIFY_UCC14, TABLECAPTION, FIELDCAPTION("UPC No."), "Cross-Reference No.");
    // //     // OPS83: End

    // //     /// OPS65: Begin
    // //     IF ("UPC No.") THEN
    // //         IF NOT (CONFIRM(TXT_CONFIRM_UPCDEL, FALSE, TABLECAPTION, "Cross-Reference No.")) THEN
    // //             ERROR(TXT_ERROR_CANCELLED)
    // //         ELSE
    // //             UPCAssignment.UnAssignXRef(Rec);
    // //     /// OPS65: End

    // //     // OPS83: Begin
    // //     IF ("UPC No.") THEN BEGIN
    // //         ItemXRef.SETCURRENTKEY("Attached-to UPC No.");
    // //         ItemXRef.SETRANGE("Attached-to UPC No.", "Cross-Reference No.");
    // //         ItemXRef.DELETEALL;
    // //     END;
    // //     // OPS83: End
    // // end;

    // // trigger OnRename()
    // // begin
    // //     /// OPS65: Begin
    // //     IF ("UPC No.") THEN
    // //         ERROR(TXT_ERROR_MODIFY_UPC, TABLECAPTION);
    // //     /// OPS65: End
    // // end;
}