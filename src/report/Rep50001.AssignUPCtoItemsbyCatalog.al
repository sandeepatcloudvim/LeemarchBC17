report 50001 "Assign UPC to Items by Catalog"
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
        dataitem("Customer CC Info"; "Customer CC Info")
        {
            DataItemTableView = SORTING("Bill-to Address") ORDER(Ascending);
            RequestFilterFields = "Bill-to Address";
            dataitem("Aged A/R Worksheet Buffer"; "Aged A/R Worksheet Buffer")
            {
                // DataItemLink = Field10 = FIELD("Bill-to Address");
                // DataItemTableView = SORTING(Field10, Field20, Field30) ORDER(Ascending);

                trigger OnAfterGetRecord();
                begin

                    // Item.GET("Aged A/R Worksheet Buffer"."Item No.");
                    // Window.UPDATE(3);

                    // IF (ItemVar.GET("Item No.", "Variant Code")) THEN BEGIN

                    //     IF (AssignUCC14) THEN
                    //         UPCAssignment.SetAssignUCC14;

                    //     IF (UPCAssignment.FINDSET(TRUE, FALSE)) THEN BEGIN

                    //         Window.UPDATE(2);

                    //         UPCAssignment."Cross-Ref. Item No." := Item."No.";
                    //         UPCAssignment."Cross-Ref. Item Variant Code" := ItemVar.Code;

                    //         IF (Item."Sales Unit of Measure" <> '') THEN
                    //             UPCAssignment."Cross-Ref. Unit of Measure" := Item."Sales Unit of Measure"
                    //         ELSE
                    //             UPCAssignment."Cross-Ref. Unit of Measure" := Item."Base Unit of Measure";

                    //         UPCAssignment.AssignXRef(UPCAssignment);

                    //     END ELSE
                    //         ERROR(TXT_ERROR_NOAVAILABLE, UPCAssignment.TABLECAPTION);
                    // END ELSE BEGIN

                    //     IF (AssignUCC14) THEN
                    //         UPCAssignment.SetAssignUCC14;

                    //     IF (UPCAssignment.FINDSET(TRUE, FALSE)) THEN BEGIN

                    //         Window.UPDATE(2);

                    //         UPCAssignment."Cross-Ref. Item No." := Item."No.";
                    //         UPCAssignment."Cross-Ref. Item Variant Code" := '';

                    //         IF (Item."Sales Unit of Measure" <> '') THEN
                    //             UPCAssignment."Cross-Ref. Unit of Measure" := Item."Sales Unit of Measure"
                    //         ELSE
                    //             UPCAssignment."Cross-Ref. Unit of Measure" := Item."Base Unit of Measure";

                    //         UPCAssignment.AssignXRef(UPCAssignment);

                    //     END ELSE
                    //         ERROR(TXT_ERROR_NOAVAILABLE, UPCAssignment.TABLECAPTION);
                    // END;

                    ItemProgress += 1;
                    ItemIndicator := ROUND((ItemProgress / ItemCount) * 10000, 1);
                    Window.UPDATE(4);
                end;

                trigger OnPreDataItem();
                begin

                    ItemProgress := 0;
                    ItemCount := "Aged A/R Worksheet Buffer".COUNT;
                    ItemIndicator := 0;
                    Window.UPDATE(4);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Window.UPDATE(1);
            end;

            trigger OnPostDataItem();
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem();
            begin

                Window.OPEN('Assigning UPC to Items...         \' +
                            'Catalog Code: #1##################\' +
                            'UPC No.:      #2##################\' +
                            'Item No.:     #3##################\' +
                            'Progress:     @4@@@@@@@@@@@@@@@@@@',
                            "Customer CC Info"."Bill-to Address",
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
        Item: Record Item;
        ItemNoFilter: Code[20];
        Window: Dialog;
        ItemProgress: Integer;
        ItemIndicator: Integer;
        ItemCount: Integer;
        AssignUCC14: Boolean;
        TXT_ERROR_NOAVAILABLE: Label 'No Available %1 records!';

    procedure SetAssignUCC14();
    begin
        AssignUCC14 := TRUE;
    end;
}

