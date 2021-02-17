pageextension 50009 "LEE_Ext_SRSetup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Default Posting Date")
        {
            field("Default Availability Location"; "Default Availability Location")
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
        addafter("Archive Orders")
        {
            field("WebOrder Tax%"; "WebOrder Tax%")
            {
                ApplicationArea = All;
            }
        }
        addafter("Number Series")
        {
            group(Custom)
            {
                field("Item Avail. Export File Path"; "Item Avail. Export File Path")
                {
                    ApplicationArea = All;
                }
                field("Item Avail. Export Period Len."; "Item Avail. Export Period Len.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}