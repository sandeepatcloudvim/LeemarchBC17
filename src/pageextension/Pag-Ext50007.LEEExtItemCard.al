pageextension 50007 "LEE_Ext_ItemCard" extends "Item Card"
{
    layout
    {
        addafter("Service Item Group")
        {
            field("Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
        addafter("Search Description")
        {
            field("LEE_Export Brand Group"; "LEE_Export Brand Group")
            {
                Caption = 'Export Brand Group';
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                Caption = 'Description 2';
                ApplicationArea = All;
            }
        }
        addafter(Warehouse)
        {
            group(Style)
            {
                Caption = 'Style Feature';
                field(Color; LEE_Color)
                {
                    Caption = 'Color';
                    ApplicationArea = All;
                }
                field(Pattern; LEE_Pattern)
                {
                    Caption = 'Pattern';
                    ApplicationArea = All;
                }
                field(Zip; LEE_Zip)
                {
                    Caption = 'Zip';
                    ApplicationArea = All;
                }
                field(Fit; LEE_Fit)
                {
                    Caption = 'Fit';
                    ApplicationArea = All;
                }
                field(Pad; LEE_Pad)
                {
                    Caption = 'Pad';
                    ApplicationArea = All;
                }
                field("Flat Lock"; "LEE_Flat Lock")
                {
                    Caption = 'Flat Lock';
                    ApplicationArea = All;
                }
                field(Fabric; LEE_Fabric)
                {
                    Caption = 'Fabric';
                    ApplicationArea = All;
                }
                field("Custom Item Group"; "LEE_Custom Item Group")
                {
                    Caption = 'Custom Item Group';
                    ApplicationArea = All;
                }
                field("Custom Item No."; "LEE_Custom Item No.")
                {
                    Caption = 'Custom Item No.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Period)
        {
            action(Colour)
            {
                ApplicationArea = All;
                Caption = 'Color';
                Image = ItemVariant;
                RunObject = page "Item Availability by Colors";
                RunPageLink = "Item No." = FIELD("No.");
                RunPageView = SORTING("Item No.", "Color Sort Order") ORDER(Ascending);

                trigger OnAction()
                begin

                end;
            }
        }
        addafter(ItemsByLocation)
        {
            group(ColorSize)

            {
                Caption = 'Colors & Sizes';
                Image = ItemAvailability;
                action("Create Variants")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Variants';
                    Image = Period;
                    trigger OnAction()
                    var
                        ItemVariantMgt: Codeunit "Item Variant Management";
                    begin
                        ItemVariantMgt.CreateVariants(Rec);
                    end;
                }
                action("Item Colors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Colors';
                    Image = Period;
                    RunObject = Page "Item Colors";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Item Sizes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Sizes';
                    Image = Period;
                    RunObject = Page "Item Sizes";
                    RunPageLink = "Item No." = FIELD("No.");

                }
                action("Item Color/Size Matrix")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Color/Size Matrix';

                }

            }
        }

    }

    var
        myInt: Integer;
}