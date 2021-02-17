report 50003 "LEE_Make Store Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Make Store Order.rdlc';

    dataset
    {
        dataitem("Web Order"; "LEE_Web Order")
        {
            column(EntryNo_WebOrder; "Web Order"."Entry No.")
            {
            }
            column(StoreID_WebOrder; "Web Order"."Store ID")
            {
            }
            column(OrderNo_WebOrder; "Web Order"."Order No.")
            {
            }
            column(OrderDate_WebOrder; "Web Order"."Order Date")
            {
            }
            column(ShiptoName_WebOrder; "Web Order"."Ship-to Name")
            {
            }
            column(ShiptoAddress_WebOrder; "Web Order"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_WebOrder; "Web Order"."Ship-to Address 2")
            {
            }
            column(ShiptoCity_WebOrder; "Web Order"."Ship-to City")
            {
            }
            column(ShiptoPostCode_WebOrder; "Web Order"."Ship-to Post Code")
            {
            }
            column(ShiptoCounty_WebOrder; "Web Order"."Ship-to County")
            {
            }
            column(ShiptoCountryRegionCode_WebOrder; "Web Order"."Ship-to Country/Region Code")
            {
            }
            column(ShiptoPhone_WebOrder; "Web Order"."Ship-to Phone")
            {
            }
            column(ShiptoEmail_WebOrder; "Web Order"."Ship-to Email")
            {
            }
            column(StyleNo_WebOrder; "Web Order"."Style No.")
            {
            }
            column(Size_WebOrder; "Web Order".Size)
            {
            }
            column(Quantity_WebOrder; "Web Order".Quantity)
            {
            }
            column(UnitPrice_WebOrder; "Web Order"."Unit Price")
            {
            }
            column(SalesOrderCreated_WebOrder; "Web Order"."Sales Order Created")
            {
            }
            column(ImportDate_WebOrder; "Web Order"."Import Date")
            {
            }
            column(ImportTime_WebOrder; "Web Order"."Import Time")
            {
            }
            column(ImportedByUser_WebOrder; "Web Order"."Imported By User")
            {
            }
            column(CustomerNo_WebOrder; "Web Order"."Customer No.")
            {
            }
            column(CustomerName_WebOrder; "Web Order"."Customer Name")
            {
            }
            column(ShiptoCode_WebOrder; "Web Order"."Ship-to Code")
            {
            }
            column(OrderCreatedByUser_WebOrder; "Web Order"."Order Created By User")
            {
            }
            column(OrderCreatedDate_WebOrder; "Web Order"."Order Created Date")
            {
            }
            column(SalesOrderNo_WebOrder; "Web Order"."Sales Order No.")
            {
            }
            column(ShippingTotal_WebOrder; "Web Order"."Shipping Total")
            {
            }
            column(ResourceNo_WebOrder; "Web Order"."Resource No.")
            {
            }
            column(ShippingAgent_WebOrder; "Web Order"."Shipping Agent")
            {
            }
            column(ShippingAgentService_WebOrder; "Web Order"."Shipping Agent Service")
            {
            }
            column(Taxable_WebOrder; "Web Order".Taxable)
            {
            }
            column(UPC_WebOrder; "Web Order".UPC)
            {
            }
            column(Discount_WebOrder; "Web Order".Discount)
            {
            }
            trigger OnPreDataItem()
            begin

                RESET;
                IF StoreID = '' THEN
                    ERROR('There are no sales orders created.');

                IF (ShipmentDate = 0D) THEN
                    ERROR('Please enter Shipment Date');

                IF (CancelDate = 0D) THEN
                    ERROR('Please enter Cancel Date');

                SETRANGE("Store ID", StoreID);
                SETRANGE("Sales Order Created", FALSE);
                IF NOT FINDSET THEN
                    ERROR('There are no sales orders created.');

                Window.OPEN(
                  'Web Order #1##############\' +
                  'Item      #2##############\',
                  "Order No.",
                  "Style No.");
            end;

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE;
                StoreOrderMgt.MakeSalesOrder("Web Order", OrderDate, ShipmentDate, CancelDate, AutoRelease);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Store ID"; StoreID)
                {
                    ApplicationArea = All;
                }
                field("Customer No"; CustomerNo)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; CustomerName)
                {
                    ApplicationArea = All;
                }
                field("Number Of Orders"; NumberOfOrders)
                {
                    ApplicationArea = All;
                }
                field("Order Date"; OrderDate)
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; ShipmentDate)
                {
                    ApplicationArea = All;
                }
                field("Cancel Date"; CancelDate)
                {
                    ApplicationArea = All;
                }
                field("Auto Release"; AutoRelease)
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
        StoreOrderMgt: Codeunit "Store Order Management";
        WebOrder2: Record "LEE_Web Order";
        StoreID: Code[20];
        CustomerNo: Code[20];
        CustomerName: Text[50];
        NumberOfOrders: Integer;
        Window: Dialog;
        TempWebOrder: Record "LEE_Web Order" temporary;
        ShipmentDate: Date;
        CancelDate: Date;
        AutoRelease: Boolean;
        OrderDate: Date;

    procedure InitStore(_weborder: Record "LEE_Web Order");
    var
        _weborder2: Record "LEE_Web Order";
        _currentOrder: Code[20];
    begin

        StoreID := _weborder."Store ID";
        CustomerNo := _weborder."Customer No.";
        CustomerName := _weborder."Customer Name";
        CLEAR(_currentOrder);
        _weborder2.SETRANGE("Store ID", _weborder."Store ID");
        if _weborder2.FINDSET then
            repeat
                if _currentOrder <> _weborder2."Order No." then begin
                    _currentOrder := _weborder2."Order No.";
                    NumberOfOrders += 1;
                end;
            until _weborder2.NEXT = 0;
    end;

    trigger OnInitReport()
    begin
        AutoRelease := TRUE;
        OrderDate := TODAY;
        ShipmentDate := TODAY;
        CancelDate := TODAY;
    end;
}

