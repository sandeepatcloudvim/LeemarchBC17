table 50005 "Customer CC Info"
{
    // version OPS01

    DrillDownPageID = "Customer CC List";
    LookupPageID = "Customer CC List";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(2; "Card ID"; Code[10])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Card Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Cardholder Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Card Number"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Expiration Month"; Text[2])
        {
            DataClassification = CustomerContent;
            Numeric = true;
            ValuesAllowed = '01;02;03;04;05;06;07;08;09;10;11;12';
        }
        field(7; "Expiration Year"; Text[4])
        {
            DataClassification = CustomerContent;
            Numeric = true;
        }
        field(8; CID; Text[4])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Card Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Visa/MC",Amex,Discover;
        }
        field(10; "Bill-to Address"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Bill-to Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Bill-to City"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Bill-to County"; Text[30])
        {
            DataClassification = CustomerContent;
            CaptionML = ENU = 'Bill-to State',
                        ESM = 'Provincia',
                        FRC = 'Comté',
                        ENC = 'Province/State';
        }
        field(14; "Bill-to Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Post Code";

            trigger OnLookup();
            begin
                // PostCode.LookUpPostCode("Bill-to City", "Bill-to Post Code", "Bill-to County", TRUE);
            end;

            trigger OnValidate();
            begin
                // PostCode.ValidatePostCode("Bill-to City", "Bill-to Post Code", "Bill-to County", , false);
            end;
        }
        field(15; "Default Card"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                IF ("Default Card") THEN BEGIN
                    rCustCC.SETRANGE("Customer No.", "Customer No.");
                    rCustCC.SETFILTER("Card ID", '<>%1', "Card ID");
                    rCustCC.SETRANGE("Default Card", TRUE);
                    IF (rCustCC.FINDFIRST) THEN
                        ERROR(TXT_ERROR_CC,
                              FIELDCAPTION("Card ID"),
                              "Card ID",
                              rCustCC."Card ID");
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Card ID")
        {
        }
        key(Key2; "Bill-to Address")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify();
    begin
        IF ("Default Card") THEN BEGIN
            rCustCC.SETRANGE("Customer No.", "Customer No.");
            rCustCC.SETFILTER("Card ID", '<>%1', "Card ID");
            rCustCC.SETRANGE("Default Card", TRUE);
            IF (rCustCC.FINDFIRST) THEN
                ERROR(TXT_ERROR_CC,
                      FIELDCAPTION("Card ID"),
                      "Card ID",
                      rCustCC."Card ID");
        END;
    end;

    var
        PostCode: Record "Post Code";
        rCustCC: Record "Customer CC Info";
        TXT_ERROR_CC: Label 'You cannot set %1 %2 to default because %1 %3 is already set to default.';
}

