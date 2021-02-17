tableextension 50004 "LEE_Extends_CompInfo" extends "Company Information"
{
    fields
    {
        field(50000; "UCC Manufacturer ID"; Code[6])
        {
            DataClassification = CustomerContent;
            Numeric = true;
            SQLDataType = Integer;

            trigger OnValidate();
            var
                TXT_ERROR_LEN: Label '%1 must contain %2 digits!';
                TXT_ERROR_XREF: Label '%1 record(s) exist with %2 %3!\\Before you can change %2, you must remove all %1 records referencing %2 %3.';
                ItemXRef: Record "Item Cross Reference";
                UPCAssignment: Record "UPC Assignment";
            begin
                if ("UCC Manufacturer ID" <> xRec."UCC Manufacturer ID") then begin

                    ItemXRef.SETRANGE("Cross-Reference Type", ItemXRef."Cross-Reference Type"::"Bar Code");
                    ItemXRef.SETFILTER("Cross-Reference No.", xRec."UCC Manufacturer ID" + '???????');
                    if (ItemXRef.FINDFIRST) then
                        ERROR(TXT_ERROR_XREF,
                              ItemXRef.TABLECAPTION,
                              FIELDCAPTION("UCC Manufacturer ID"),
                              xRec."UCC Manufacturer ID");

                    UPCAssignment.SETRANGE("UCC Manufacturer ID", xRec."UCC Manufacturer ID");
                    if (UPCAssignment.FINDFIRST) then
                        ERROR(TXT_ERROR_XREF,
                              UPCAssignment.TABLECAPTION,
                              FIELDCAPTION("UCC Manufacturer ID"),
                              xRec."UCC Manufacturer ID");

                    if ("UCC Manufacturer ID" <> '')
                     and (STRLEN("UCC Manufacturer ID") < MAXSTRLEN("UCC Manufacturer ID")) then
                        ERROR(TXT_ERROR_LEN, FIELDCAPTION("UCC Manufacturer ID"), MAXSTRLEN("UCC Manufacturer ID"));

                end;
            end;
        }
        field(50001; "Comment Freeze Date Calc."; DateFormula)
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}