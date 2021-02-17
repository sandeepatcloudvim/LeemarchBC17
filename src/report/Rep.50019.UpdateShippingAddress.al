report 50019 "Update Shipping Address"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Ship-to Code" = FILTER(<> ''));

            trigger OnAfterGetRecord()
            var
                recShipToAdd: Record "Ship-to Address";
            begin
                if not recShipToAdd.get("Sell-to Customer No.", "Ship-to Code") then begin
                    recShipToAdd.Init();
                    recShipToAdd."Customer No." := "Sell-to Customer No.";
                    recShipToAdd.Code := "Ship-to Code";
                    recShipToAdd.Name := "Ship-to Name";
                    recShipToAdd."Name 2" := "Ship-to Name 2";
                    recShipToAdd.Address := "Ship-to Address";
                    recShipToAdd."Address 2" := "Ship-to Address 2";
                    recShipToAdd.City := "Ship-to City";
                    recShipToAdd.Contact := "Ship-to Contact";
                    recShipToAdd.County := "Ship-to County";
                    recShipToAdd."Country/Region Code" := "Ship-to Country/Region Code";
                    recShipToAdd."Post Code" := "Ship-to Post Code";
                    recShipToAdd."Shipment Method Code" := "Shipment Method Code";
                    recShipToAdd."Shipping Agent Service Code" := "Shipping Agent Service Code";
                    if recShipToAdd.Insert() then;
                end;

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
}

