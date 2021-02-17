pageextension 50003 "LEE_Extends_CompInfo" extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter(Tax)
        {
            group(UPC)

            {
                field("LEE_UCC Manufacturer ID"; "UCC Manufacturer ID")
                {
                    Caption = 'UCC Manufacturer ID';
                    ApplicationArea = All;
                }
                field("LEE_UPC Allocation %"; UPCAssignment.GetAllocationInd(Rec))
                {
                    Caption = 'UPC Allocation';
                    ApplicationArea = All;
                }
            }
            part("LEE_UPC Assignment"; "UPC Assignment")
            {
                ApplicationArea = All;
                Caption = 'UPC Assignment';
                SubPageView = SORTING("UCC Manufacturer ID", "Base UPC No.") ORDER(Ascending);
                SubPageLink = "UCC Manufacturer ID" = FIELD("UCC Manufacturer ID");
            }
        }
    }


    actions
    {
        // Add changes to page actions here
        addafter("Regional Settings")
        {
            group(LEE_UPCActions)
            {
                Caption = 'UPC';
                action("LEE_Create UPC Range")
                {
                    Image = Create;
                    Caption = 'Create UPC Range';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UPCAssignment.CreateUPCRange(Rec);
                    end;
                }
                action("LEE_Assign UPC By Item")
                {
                    Image = Action;
                    Caption = 'Assign UPC By Item';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage."LEE_UPC Assignment".Page.AssignUPCToItemVariant();
                    end;
                }
                action("LEE_Item Cross Reference")
                {
                    Image = ReferenceData;
                    Caption = 'Item Cross Reference';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        CurrPage."LEE_UPC Assignment".Page.ShowCrossRefEntries();
                    end;
                }
            }
        }
    }

    var
        UPCAssignment: Record "UPC Assignment";
}