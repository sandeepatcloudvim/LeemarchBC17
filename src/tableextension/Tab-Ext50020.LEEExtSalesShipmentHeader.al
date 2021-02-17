tableextension 50020 ExtendSalesShipmentHeader extends "Sales Shipment Header"
{
    fields
    {
        modify("Requested Delivery Date")
        {
            Caption = 'Cancel Date';
        }
    }

    var
        myInt: Integer;
}