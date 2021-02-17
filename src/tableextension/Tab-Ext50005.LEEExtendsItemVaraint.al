tableextension 50005 "LEE_Extends_ItemVaraint" extends "Item Variant"
{
    fields
    {
        field(50000; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Color Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Size Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Kit BOM No."; Code[20])
        {
            DataClassification = CustomerContent;
            ObsoleteState = Removed;

        }
        field(50006; "Kit Disassembly BOM No."; Code[20])
        {
            CaptionML = ENU = 'Kit Disassembly BOM No.', ESM = 'L.M. de desmontaje de kit Nº', FRC = 'N° nomenclature de démontage de jeu de pièces', ENC = 'Kit Disassembly BOM No.';
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
        }


    }

    var
        myInt: Integer;
}