tableextension 50011 "LEE_Ext_SalesInvoiceHeader" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "LEE_Start Ship Date"; Date)
        {
            Caption = 'Start Ship Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
            end;
        }
        field(50021; "Custom Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
        SalesInvHeader: Record "Sales Invoice Header";
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

    end;
    //Begin RS_CloudVim on 18-12-2020
}