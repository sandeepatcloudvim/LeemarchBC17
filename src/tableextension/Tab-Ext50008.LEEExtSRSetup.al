tableextension 50008 "LEE_Ext_SRSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "WebOrder Tax%"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Item Avail. Export File Path"; Text[250])
        {
            DataClassification = CustomerContent;

        }
        field(50002; "Item Avail. Export Period Len."; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Default Availability Location"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
    }

    var
        myInt: Integer;
}