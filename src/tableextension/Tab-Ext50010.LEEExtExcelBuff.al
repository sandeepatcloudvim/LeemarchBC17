tableextension 50010 "LEE_Ext_ExcelBuff" extends "Excel Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(50000; NewWorksheet; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50001; InteriorColorIndex; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50002; Font; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Add Picture"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50004; Locked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50005; FontColorIndex; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50006; MergeRange; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}