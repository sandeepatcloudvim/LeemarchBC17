page 50025 "Customer CC Info"
{
    PageType = Card;
    SourceTable = "Customer CC Info";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Card ID"; "Card ID")
                {
                    ApplicationArea = All;
                }
                field("Card Description"; "Card Description")
                {
                    ApplicationArea = All;
                }
                field("Default Card"; "Default Card")
                {
                    ApplicationArea = All;
                }
                field("Cardholder Name"; "Cardholder Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to County"; "Bill-to County")
                {
                    ApplicationArea = All;
                }
                field("Card Type"; "Card Type")
                {
                    ApplicationArea = All;
                }
                field("Card Number"; "Card Number")
                {
                    ApplicationArea = All;
                }
                field("Expiration Month"; "Expiration Month")
                {
                    ApplicationArea = All;
                }
                field("Expiration Year"; "Expiration Year")
                {
                    ApplicationArea = All;
                }
                field(CID; CID)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        myInt: Integer;
}