tableextension 50009 "LEE_Ext_Cust" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Customer Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Custom,IBD,Major,SLD,BRW,IND,GRS,CHR,SPN;
            OptionCaption = ' ,Custom,IBD,Major,SLD,BRW,IND,GRS,CHR,SPN';
        }
        field(50001; "SPS Vendor No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "SPS Vendor File Ext"; Code[3])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "SPS Trading Partner ID"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}