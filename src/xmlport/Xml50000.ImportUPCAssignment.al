xmlport 50000 "Import UPC Assignment"
{
    Direction = Import;
    // Encoding = UTF8;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(UPC_Load; "LEE_UPC_Load")
            {
                AutoUpdate = true;
                XmlName = 'UPC_Load';
                SourceTableView = SORTING("ItemNo.");
                fieldelement(ItemNo; UPC_Load."ItemNo.")
                {
                }
                fieldelement(ColorCode; UPC_Load.ColorCode)
                {
                }
                fieldelement(ColorDesc; UPC_Load.ColorDesc)
                {
                }
                fieldelement(SizeCode; UPC_Load.SizeCode)
                {
                }
                textelement(txtNothing)
                {
                }
                textelement(txtNothing1)
                {
                }
                fieldelement(Description; UPC_Load.Description)
                {
                }
                textelement(txtNothing2)
                {
                }
                textelement(txtNothing3)
                {
                }
                textelement(txtNothing4)
                {
                }
                textelement(txtNothing5)
                {
                }
                textelement(txtNothing6)
                {
                }
                textelement(txtNothing7)
                {
                }
                fieldelement(UPCCode; UPC_Load.UPCCode)
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

