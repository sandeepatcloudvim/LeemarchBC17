pageextension 50004 "LEE_Extends_ItemCross" extends "Item Cross Reference Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addfirst(Processing)
        {
            action("LEE_Assign UPC No(s).")
            {
                Image = Action;
                Caption = 'Assign UPC No(s).';
                ApplicationArea = All;

                trigger OnAction()
                var
                    AssignUPC: Report "Assign UPC to Items";
                    TXT_CONFIRM_ASSIGN: Label 'Assign UPC No(s). to Item/Variants?';
                begin
                    IF (CONFIRM(TXT_CONFIRM_ASSIGN, TRUE)) THEN BEGIN
                        AssignUPC.UseRequestPage(FALSE);
                        AssignUPC.SetItemFilter("Item No.");
                        AssignUPC.RUNMODAL;
                        CLEAR(AssignUPC);
                    END;
                end;
            }
        }
    }

    var
        myInt: Integer;
}