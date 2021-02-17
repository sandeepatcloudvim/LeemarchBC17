table 50006 "LEE_Web Order"
{
    // version J11515


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Store ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Order Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Ship-to Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Ship-to Address"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Ship-to Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Ship-to City"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Ship-to Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Ship-to County"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Ship-to Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Ship-to Phone"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Ship-to Email"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Style No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(15; Size; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = LEE_Size WHERE(Code = FIELD(Size));
        }
        field(16; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Sales Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Import Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Import Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Imported By User"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            // TableRelation = Table2000000002;

            // trigger OnLookup();
            // var
            //     LoginMgt: Codeunit "User Management";
            // begin
            //     LoginMgt.LookupUserID("Imported By User");
            // end;
        }
        field(22; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(23; "Customer Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(24; "Ship-to Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(25; "Order Created By User"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            // TableRelation = Table2000000002;

            // trigger OnLookup();
            // var
            //     LoginMgt: Codeunit "User Management";
            // begin
            //     LoginMgt.LookupUserID("Order Created By User");
            // end;
        }
        field(26; "Order Created Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order),
                                                        "No." = FIELD("Sales Order No."));
        }
        field(28; "Shipping Total"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(29; "Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Resource;
        }
        field(30; "Shipping Agent"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(31; "Shipping Agent Service"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent"));
        }
        field(32; Taxable; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33; UPC; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(34; Discount; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'CAN_PS';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Sales Order No.")
        {
        }
        key(Key3; "Store ID")
        {
        }
        key(Key4; "Ship-to Name")
        {
        }
        key(Key5; "Customer No.")
        {
        }
        key(Key6; "Customer Name")
        {
        }
        key(Key7; "Store ID", "Order No.", "Sales Order Created")
        {
        }
    }

    fieldgroups
    {
    }
}

