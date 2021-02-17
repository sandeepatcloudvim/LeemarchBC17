report 50000 "Assign UPC to Items"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("UPC Assignment"; "UPC Assignment")
        {
            DataItemTableView = SORTING("UCC Manufacturer ID", "Base UPC No.") ORDER(Ascending);

            trigger OnPreDataItem();
            begin

                UPCAssignment.COPYFILTER("UCC Manufacturer ID", "UPC Assignment"."UCC Manufacturer ID");
                UPCAssignment.SETRANGE(Status, Status::Available);
                CurrReport.BREAK;
            end;
        }
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Item Category Code";

            trigger OnAfterGetRecord();
            begin

                Window.UPDATE(2);

                ItemVar.SETRANGE("Item No.", Item."No.");
                if (ItemVar.FINDSET(false, false)) then begin

                    if (AssignUCC14) then
                        UPCAssignment.SetAssignUCC14;

                    repeat
                        if (UPCAssignment.FINDSET(true, false)) then begin

                            Window.UPDATE(1);

                            UPCAssignment."Cross-Ref. Item No." := Item."No.";
                            UPCAssignment."Cross-Ref. Item Variant Code" := ItemVar.Code;
                            if (Item."Sales Unit of Measure" <> '') then
                                UPCAssignment."Cross-Ref. Unit of Measure" := Item."Sales Unit of Measure"
                            else
                                UPCAssignment."Cross-Ref. Unit of Measure" := Item."Base Unit of Measure";

                            UPCAssignment.AssignXRef(UPCAssignment);

                        end else
                            ERROR(TXT_ERROR_NOAVAILABLE, UPCAssignment.TABLECAPTION);
                    until (ItemVar.NEXT = 0);
                end else begin

                    if (AssignUCC14) then
                        UPCAssignment.SetAssignUCC14;

                    if (UPCAssignment.FINDSET(true, false)) then begin

                        Window.UPDATE(1);

                        UPCAssignment."Cross-Ref. Item No." := Item."No.";
                        UPCAssignment."Cross-Ref. Item Variant Code" := '';
                        if (Item."Sales Unit of Measure" <> '') then
                            UPCAssignment."Cross-Ref. Unit of Measure" := Item."Sales Unit of Measure"
                        else
                            UPCAssignment."Cross-Ref. Unit of Measure" := Item."Base Unit of Measure";

                        UPCAssignment.AssignXRef(UPCAssignment);

                    end else
                        ERROR(TXT_ERROR_NOAVAILABLE, UPCAssignment.TABLECAPTION);
                end;

                ItemProgress += 1;
                ItemIndicator := ROUND((ItemProgress / ItemCount) * 10000, 1);
                Window.UPDATE(3);
            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem();
            begin

                if (ItemNoFilter <> '') then
                    Item.SETRANGE("No.", ItemNoFilter);

                ItemProgress := 0;
                ItemCount := Item.COUNT;
                ItemIndicator := 0;

                Window.OPEN('Assigning UPC to Items...         \' +
                            'UPC No.:      #1##################\' +
                            'Item No.:     #2##################\' +
                            'Progress:     @3@@@@@@@@@@@@@@@@@@',
                            UPCAssignment."Cross-Ref. UPC No.",
                            Item."No.",
                            ItemIndicator);
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

    var
        ItemVar: Record "Item Variant";
        UPCAssignment: Record "UPC Assignment";
        ItemCrossRef: Record "Item Cross Reference";
        ItemNoFilter: Code[20];
        Window: Dialog;
        ItemProgress: Integer;
        ItemIndicator: Integer;
        ItemCount: Integer;
        AssignUCC14: Boolean;
        TXT_ERROR_NOAVAILABLE: Label 'No Available %1 records!';

    procedure SetItemFilter("InItemNo.": Code[20]);
    begin
        ItemNoFilter := "InItemNo.";
    end;

    procedure SetAssignUCC14();
    begin
        AssignUCC14 := true;
    end;
}

