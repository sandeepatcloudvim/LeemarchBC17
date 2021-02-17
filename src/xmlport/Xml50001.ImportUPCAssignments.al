xmlport 50001 "Import UPC Assignments"
{

    schema
    {
        textelement(Root)
        {
            tableelement("Original UPC Assignment"; "Original UPC Assignment")
            {
                AutoUpdate = true;
                XmlName = 'OriginalUPCAssignment';
                fieldelement(UPC; "Original UPC Assignment".UPC)
                {
                }
                fieldelement(ItemNo; "Original UPC Assignment"."Item No.")
                {
                }
                fieldelement(VariantCode; "Original UPC Assignment"."Variant Code")
                {
                }
                fieldelement(Description; "Original UPC Assignment".Description)
                {
                }
                fieldelement(Description2; "Original UPC Assignment"."Description 2")
                {
                }
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
}

