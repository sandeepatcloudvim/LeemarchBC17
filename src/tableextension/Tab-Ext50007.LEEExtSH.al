tableextension 50007 "LEE_Ext_SH" extends "Sales Header"
{
    fields
    {
        field(50000; "LEE_Start Ship Date"; Date)
        {
            Caption = 'Start Ship Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                // OPS01: Begin
                IF ("LEE_Start Ship Date" > "Shipment Date") THEN
                    VALIDATE("Shipment Date", "LEE_Start Ship Date");
                UpdateSalesLines(FIELDCAPTION("LEE_Start Ship Date"), CurrFieldNo <> 0);
                // OPS01: End
            end;
        }
        field(50001; "LEE_Cancel Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Date';
            trigger OnValidate()
            begin

            end;
        }
        field(50002; "Designer Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50003; "Reference ID"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        // field(5004; "Reference Description"; Text[60])
        // {
        //     DataClassification = CustomerContent;
        //     ObsoleteState = Removed;
        //     ObsoleteReason = 'Wrong field ID';
        // }

        field(50004; "Reference Description1"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference Description';
        }
        field(50021; "Custom Order"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        modify("Requested Delivery Date")
        {
            Caption = 'Cancel Date';
        }
    }

    var
        myInt: Integer;
    //Begin RS_CloudVim on 18-12-2020
    Procedure MultiSenderID()
    var
        SMTPMailMultiSetup: Record SMTPMultiSetup;
        SMTPMailSetup: Record "SMTP Mail Setup";
        DocPrint: Codeunit "Document-Print";
        CustRec: Record Customer;
    begin

        CLEAR(SMTPMailMultiSetup);
        SMTPMailSetup.GET;
        clear(CustRec);
        if CustRec.Get("Sell-to Customer No.") then;

        IF CustRec."Customer Category" = CustRec."Customer Category"::SLD THEN BEGIN
            SMTPMailMultiSetup.GET('2');
        END ELSE BEGIN
            SMTPMailMultiSetup.GET('1');
        END;
        SMTPMailSetup.VALIDATE(SMTPMailSetup."SMTP Server", SMTPMailMultiSetup."SMTP Server");
        SMTPMailSetup.VALIDATE(SMTPMailSetup.Authentication, SMTPMailSetup.Authentication::Basic);
        SMTPMailSetup.VALIDATE(SMTPMailSetup."User ID", SMTPMailMultiSetup."User ID");
        SMTPMailSetup.VALIDATE(SMTPMailSetup."SMTP Server Port", SMTPMailMultiSetup."SMTP Server Port");
        SMTPMailSetup.VALIDATE(SMTPMailSetup."Secure Connection", true);
        SMTPMailSetup.VALIDATE(SMTPMailSetup."Password Key", SMTPMailMultiSetup."Password Key");
        SMTPMailSetup.VALIDATE(SMTPMailSetup."Send As", SMTPMailMultiSetup."Send As");
        SMTPMailSetup.VALIDATE(SMTPMailSetup."Allow Sender Substitution", SMTPMailMultiSetup."Allow Sender Substitution");
        SMTPMailSetup.MODIFY(true);
        DocPrint.EmailSalesHeader(Rec);
    end;
    //Begin RS_CloudVim on 18-12-2020
}