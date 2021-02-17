tableextension 50021 ExtendInventorySetup extends "Inventory Setup"
{
    fields
    {
        field(50000; "Catalog Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Catalog Nos.';
        }
        field(50001; "Default Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Location Code';
        }
        field(50002; "Show all Items"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show all Items';
        }
    }

    var
        myInt: Integer;
}