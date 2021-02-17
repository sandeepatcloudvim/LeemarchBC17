report 50013 "EDI Import Purchase Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; "Integer")
        {

            trigger OnAfterGetRecord();
            begin
                CurrReport.BREAK;
            end;

            trigger OnPreDataItem();
            begin
                ImportPO.SetDoNotDedupe(DoNotDedupe);
                ImportPO.ImportPurchaseOrder(Filename);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("File name"; Filename)
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit();
                    var
                        TempBlob: Record TemplBlob;
                    begin
                        TempBlob.DeleteAll();
                        Filename := CommonDialog.OpenFileDialog('Import File Name', '', 'EDI PO Files (*.5*)|*.5*|Text Files (*.txt)|*.txt|All Files (*.*)|*.*');
                        TempBlob.Init();
                        TempBlob.MyBlob.Import(Filename);
                        TempBlob.Insert();
                    end;
                }
                field("Do not check for duplicates"; DoNotDedupe)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ImportPO: Codeunit "EDI Import Purchase Order";
        CommonDialog: Codeunit "File Management";
        Filename: Text[512];
        DoNotDedupe: Boolean;
}

