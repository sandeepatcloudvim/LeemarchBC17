tableextension 50012 "Lee_ExtendsItemAvailLine" extends "Item Availability Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            MinValue = 0;
        }

    }
}