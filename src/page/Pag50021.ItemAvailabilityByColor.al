page 50021 "Item Availability By Color"
{
    Caption = 'Item Availability By Color';
    PageType = Card;
    SourceTable = "Item Color";
    UsageCategory = History;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Item.Description)
                {
                    ApplicationArea = All;
                }
                field("Color Description"; "Color Description")
                {
                    ApplicationArea = All;
                }
            }
            part(MatrixForm; "Items by Size Matrix")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.MatrixForm.PAGE.SetItemColor("Item No.", "Color Code");
        CurrPage.MatrixForm.PAGE.RefreshForm;
    end;

    trigger OnAfterGetRecord();
    begin
        Item.GET("Item No.");
    end;

    trigger OnInit();
    begin
        GetLocationsIncludingUnspecifiedLocation;
    end;

    trigger OnOpenPage();
    begin
        SetColumns(MATRIX_SetWanted::Initial);
    end;

    var
        Item: Record Item;
        TempMatrixItemSize: Record "Item Size" temporary;
        MatrixRecords: array[32] of Record "Item Size";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        ShowColumnName: Boolean;
        MATRIX_CaptionSet: array[32] of Text[80];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[80];
        MATRIX_CurrSetLength: Integer;
        ItemSize: Record "Item Size";


    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next);
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        // TempMatrixItemSize.SETFILTER("Item No.",Rec."Item No.");
        ItemSize.SETFILTER("Item No.", "Item No.");

        TempMatrixItemSize.COPY(ItemSize);

        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GETTABLE(TempMatrixItemSize);
        MatrixRecordRef.SETTABLE(TempMatrixItemSize);

        if ShowColumnName then
            CaptionFieldNo := TempMatrixItemSize.FIELDNO("Size Code")
        else
            CaptionFieldNo := TempMatrixItemSize.FIELDNO("Size Code");

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ARRAYLEN(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CaptionSet[1] = '' then begin
            //  MATRIX_CaptionSet[1] := UnspecifiedLocationCodeTxt;
            MATRIX_CaptionRange := STRSUBSTNO('%1%2', MATRIX_CaptionSet[1], MATRIX_CaptionRange);
        end;

        if MATRIX_CurrSetLength > 0 then begin
            TempMatrixItemSize.SETPOSITION(MATRIX_PKFirstRecInCurrSet);
            TempMatrixItemSize.FIND;
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].COPY(TempMatrixItemSize);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (TempMatrixItemSize.NEXT <> 1);
        end;

        UpdateMatrixSubform;
    end;

    local procedure UpdateMatrixSubform();
    begin
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet, MatrixRecords, TempMatrixItemSize, MATRIX_CurrSetLength);
        CurrPage.MatrixForm.PAGE.SETRECORD(Rec);
        CurrPage.UPDATE;
    end;

    local procedure GetLocationsIncludingUnspecifiedLocation();
    begin
        ItemSize.SETFILTER("Item No.", "Item No.");
        if ItemSize.FINDSET then begin
            repeat
                TempMatrixItemSize.COPY(ItemSize);
                TempMatrixItemSize.INSERT;
            until ItemSize.NEXT = 0;
        end;
    end;
}

