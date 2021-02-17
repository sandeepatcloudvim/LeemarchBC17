report 50028 UpdateDimensionCode
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnAfterGetRecord()
            begin
                DefaultDimension.Reset();
                DefaultDimension.SetFilter("Table ID", '%1', 18);
                DefaultDimension.SetFilter("Dimension Code", '%1', 'BRAND');
                DefaultDimension.SetRange("No.", "No.");
                if DefaultDimension.FindFirst() then begin
                    case "Customer Category" of
                        "Customer Category"::SLD:
                            begin
                                Validate("Global Dimension 1 Code", 'SLD');
                                DefaultDimension."Dimension Value Code" := 'SLD';
                                DefaultDimension.Modify(false);
                            end;
                        "Customer Category"::IBD, "Customer Category"::Major, "Customer Category"::IND:
                            begin
                                Validate("Global Dimension 1 Code", 'Cycling');
                                DefaultDimension."Dimension Value Code" := 'Cycling';
                                DefaultDimension.Modify(false);
                            end;
                        "Customer Category"::Custom, "Customer Category"::BRW, "Customer Category"::GRS, "Customer Category"::SPN, "Customer Category"::CHR:
                            begin
                                Validate("Global Dimension 1 Code", 'Custom');
                                DefaultDimension."Dimension Value Code" := 'Custom';
                                DefaultDimension.Modify(false);
                            end;
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
        DefaultDimension: Record "Default Dimension";
}