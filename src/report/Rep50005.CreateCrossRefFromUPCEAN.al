report 50005 "Create Cross Ref. From UPC/EAN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Create Cross Ref. From UPCEAN.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            // RequestFilterFields = "No.", "Item UPC/EAN Number";
            RequestFilterFields = "No.";
            dataitem("Item Unit of Measure"; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Item No.", Code);
                // RequestFilterFields = "Code", "Std. Pack UPC/EAN Number";
                RequestFilterFields = "Code";
            }
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

