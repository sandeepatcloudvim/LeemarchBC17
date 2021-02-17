report 50002 "UPC Labels"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UPC Labels.rdlc';

    dataset
    {
        dataitem("Item Variant"; "Item Variant")
        {
            RequestFilterFields = "Item No.", "Code";
            column(LabelData1_1; LabelData[1] [1])
            {
            }
            column(LabelData1_2; LabelData[1] [2])
            {
            }
            column(LabelData1_3; LabelData[1] [3])
            {
            }
            column(LabelData1_4; LabelData[1] [4])
            {
            }
            column(LabelData1_5; LabelData[1] [5])
            {
            }
            column(LabelData1_6; LabelData[1] [6])
            {
            }
            column(LabelData1_7; LabelData[1] [7])
            {
            }
            column(LabelData2_1; LabelData[2] [1])
            {
            }
            column(LabelData2_2; LabelData[2] [2])
            {
            }
            column(LabelData2_3; LabelData[2] [3])
            {
            }
            column(LabelData2_4; LabelData[2] [4])
            {
            }
            column(LabelData2_5; LabelData[2] [5])
            {
            }
            column(LabelData2_6; LabelData[2] [6])
            {
            }
            column(LabelData2_7; LabelData[2] [7])
            {
            }
            column(LabelData3_1; LabelData[3] [1])
            {
            }
            column(LabelData3_2; LabelData[3] [2])
            {
            }
            column(LabelData3_3; LabelData[3] [3])
            {
            }
            column(LabelData3_4; LabelData[3] [4])
            {
            }
            column(LabelData3_5; LabelData[3] [5])
            {
            }
            column(LabelData3_6; LabelData[3] [6])
            {
            }
            column(LabelData3_7; LabelData[3] [7])
            {
            }
            column(LabelData4_1; LabelData[4] [1])
            {
            }
            column(LabelData4_2; LabelData[4] [2])
            {
            }
            column(LabelData4_3; LabelData[4] [3])
            {
            }
            column(LabelData4_4; LabelData[4] [4])
            {
            }
            column(LabelData4_5; LabelData[4] [5])
            {
            }
            column(LabelData4_6; LabelData[4] [6])
            {
            }
            column(LabelData4_7; LabelData[4] [7])
            {
            }
            column(LabelData5_1; LabelData[5] [1])
            {
            }
            column(LabelData5_2; LabelData[5] [2])
            {
            }
            column(LabelData5_3; LabelData[5] [3])
            {
            }
            column(LabelData5_4; LabelData[5] [4])
            {
            }
            column(LabelData5_5; LabelData[5] [5])
            {
            }
            column(LabelData5_6; LabelData[5] [6])
            {
            }
            column(LabelData5_7; LabelData[5] [7])
            {
            }

            trigger OnPreDataItem();
            begin
                CurrReport.BREAK;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);

            trigger OnAfterGetRecord();
            begin

                // Put this up here at top of (iteration after last). BREAKing on last doesn't product output.
                if CompleteReport then
                    CurrReport.BREAK;

                for CopyCount := StartingCopyCount to NumberOfCopies do begin
                    ColumnNo := ColumnNo + 1;
                    LabelData[ColumnNo] [1] := FORMAT(ItemVariant."Item No.");
                    LabelData[ColumnNo] [2] := FORMAT(ItemVariant.Code);
                    LabelData[ColumnNo] [3] := FORMAT(ItemVariant."Color Code");
                    LabelData[ColumnNo] [4] := FORMAT(ItemVariant."Size Code");
                    LabelData[ColumnNo] [5] := FORMAT(ItemVariant.Description);
                    LabelData[ColumnNo] [6] := FORMAT(ItemVariant."Description 2");

                    LabelData[ColumnNo] [7] := '';
                    ItemXRef.SETRANGE("Item No.", ItemVariant."Item No.");
                    ItemXRef.SETRANGE("Variant Code", ItemVariant.Code);
                    ItemXRef.SETRANGE("UPC No.", true);
                    if not ItemXRef.FINDFIRST then begin
                        ItemXRef.SETRANGE("Variant Code", '');
                        if ItemXRef.FINDFIRST then
                            LabelData[ColumnNo] [7] := Barcode.GenerateUPCa(ItemXRef."Cross-Reference No.")
                    end else begin
                        LabelData[ColumnNo] [7] := Barcode.GenerateUPCa(ItemXRef."Cross-Reference No.")
                    end;

                    Item.SETRANGE("No.", ItemVariant."Item No.");
                    if Item.FINDFIRST then
                        LabelData[ColumnNo] [8] := FORMAT(Item."Unit Price", 0, '$<decimal><integer,3>')
                    else
                        LabelData[ColumnNo] [8] := '';

                    LastColumnNo := ColumnNo;

                    if CopyCount = NumberOfCopies then begin
                        // DONE WITH CURRENT RECORD?
                        if RecordNo = NoOfRecords then begin
                            // END OF REPORT
                            if ColumnNo <> 0 then
                                for i := ColumnNo + 1 to NoOfColumns do
                                    CLEAR(LabelData[i]);
                            ColumnNo := 0;
                            // ALLOW THIS LAST SECTION TO EJECT, THEN BREAK AT TOP OF NEXT TO COMPLETE REPORT
                            CompleteReport := true;
                        end;
                        // MOVE ON TO NEXT RECORD
                        RecordNo += ItemVariant.NEXT;
                        StartingCopyCount := 1;
                    end;

                    if ColumnNo = NoOfColumns then begin
                        // END OF ROW?
                        if CopyCount <> NumberOfCopies then begin
                            // STILL MORE COPIES? PASS ON INFO TO NEXT ITERATION
                            StartingCopyCount := CopyCount + 1;
                        end;
                        CopyCount := NumberOfCopies;
                        ColumnNo := 0;
                    end;

                end;
            end;

            trigger OnPreDataItem();
            begin

                ItemVariant.COPYFILTERS("Item Variant");
                if not ItemVariant.FINDFIRST then
                    exit;
                NoOfRecords := ItemVariant.COUNT;
                NoOfColumns := 5;
                CopyCount := 0;
                LastColumnNo := 0;
                StartingCopyCount := 1;
                RecordNo := 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        NumberOfCopies := 2;
    end;

    var
        LabelData: array[5, 8] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        LastColumnNo: Integer;
        i: Integer;
        ItemVariant: Record "Item Variant";
        ItemXRef: Record "Item Cross Reference";
        Item: Record Item;
        Barcode: Codeunit "Barcode Functions";
        StartingCopyCount: Integer;
        CopyCount: Integer;
        NumberOfCopies: Integer;
        CompleteReport: Boolean;
}

