report 50009 "Create Item Sizes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Size"; "Item Size")
        {
            DataItemTableView = SORTING("Item No.", "Size Code") ORDER(Ascending);
        }
        dataitem("Size Scale"; "Size Scale")
        {
            DataItemTableView = SORTING(Code) ORDER(Ascending);

            dataitem("Size Scale Size"; "Size Scale Size")
            {
                DataItemTableView = SORTING("Size Scale Code", "Size Code") ORDER(Ascending);
                DataItemLink = "Size Scale Code" = FIELD(Code);

                trigger OnPreDataItem()
                begin
                    iSizeScaleCount := "Size Scale Size".COUNT;
                end;

                trigger OnAfterGetRecord()
                begin

                    "Item Size"."Item No." := "Item Size".GETFILTER("Item No.");
                    "Item Size"."Size Code" := "Size Scale Size"."Size Code";
                    "Item Size"."Size Sort Order" := "Size Scale Size"."Size Sort Order";
                    IF NOT ("Item Size".INSERT(TRUE)) THEN;
                    iSizeScaleProg += 1;

                    iSizeScaleInd := ROUND((iSizeScaleProg / iSizeScaleCount) * 10000, 1);
                    diaWindow.UPDATE(2);
                end;
            }

            trigger OnPreDataItem()
            begin
                diaWindow.OPEN('Adding Item Size(s)...                \' +
                               'Size Scale Code:            #1########\' +
                               'Progress:         @2@@@@@@@@@@@@@@@@@@',
                               "Size Scale".Code,
                               iSizeScaleInd);
            end;

            trigger OnAfterGetRecord()
            begin

                iSizeScaleProg := 0;
                iSizeScaleInd := 0;
                diaWindow.UPDATE(1);
                diaWindow.UPDATE(2);
            end;

            trigger OnPostDataItem()
            begin
                diaWindow.CLOSE;
            end;
        }
    }

    var
        diaWindow: Dialog;
        iSizeScaleProg: integer;
        iSizeScaleInd: integer;
        iSizeScaleCount: integer;
}