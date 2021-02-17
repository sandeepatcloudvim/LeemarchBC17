xmlport 50002 "Web Order Import"
{
    // version NAVW17.10

    Caption = 'Web Order Import';
    Direction = Import;
    Format = VariableText;
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;
    Permissions = TableData 2000000026 = rimd;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Integer';
                SourceTableView = SORTING(Number);
                AutoUpdate = false;
                AutoSave = false;
                AutoReplace = false;
                textelement("field[1]")
                {
                    XmlName = 'Field1';
                    MinOccurs = Once;

                }
                textelement("field[2]")
                {
                    XmlName = 'Field2';
                    MinOccurs = Once;

                }
                textelement("field[3]")
                {
                    XmlName = 'Field3';
                    MinOccurs = Once;

                }
                textelement("field[4]")
                {
                    XmlName = 'Field4';
                    MinOccurs = Once;

                }
                textelement("field[5]")
                {
                    XmlName = 'Field5';
                    MinOccurs = Once;

                }
                textelement("field[6]")
                {
                    XmlName = 'Field6';
                    MinOccurs = Once;

                }
                textelement("field[7]")
                {
                    XmlName = 'Field7';
                    MinOccurs = Once;

                }
                textelement("field[8]")
                {
                    XmlName = 'Field8';
                    MinOccurs = Once;
                    ;
                }
                textelement("field[9]")
                {
                    XmlName = 'Field9';
                    MinOccurs = Once;

                }
                textelement("field[10]")
                {
                    XmlName = 'Field10';
                    MinOccurs = Once;

                }
                textelement("field[11]")
                {
                    XmlName = 'Field11';
                    MinOccurs = Once;

                }
                textelement("field[12]")
                {
                    XmlName = 'Field12';
                    MinOccurs = Once;

                }
                textelement("field[13]")
                {
                    XmlName = 'Field13';
                    MinOccurs = Once;

                }
                textelement("field[14]")
                {
                    XmlName = 'Field14';
                    MinOccurs = Once;

                }
                textelement("field[15]")
                {
                    XmlName = 'Field15';
                    MinOccurs = Once;

                }
                textelement("field[16]")
                {
                    XmlName = 'Field16';
                    MinOccurs = Once;

                }
                textelement("field[17]")
                {
                    XmlName = 'Field17';
                    MinOccurs = Once;

                }
                textelement("field[18]")
                {
                    XmlName = 'Field18';
                    MinOccurs = Once;

                }
                textelement("field[19]")
                {
                    XmlName = 'Field19';
                    MinOccurs = Once;

                }
                textelement("field[20]")
                {
                    XmlName = 'Field20';
                    MinOccurs = Once;

                }
                textelement("field[21]")
                {
                    XmlName = 'Field21';
                    MinOccurs = Once;

                }
                textelement("field[22]")
                {
                    XmlName = 'Field22';
                    MinOccurs = Once;

                }
                textelement("field[23]")
                {
                    XmlName = 'Field23';
                    MinOccurs = Once;

                }
                // textelement("field[24]")
                // {
                //     XmlName = 'Field24';
                //     MinOccurs = Once;
                //     ;
                // }
                // textelement("field[25]")
                // {
                //     XmlName = 'Field25';
                //     MinOccurs = Once;
                //     ;
                // }

                trigger OnAfterInsertRecord()
                begin
                    if FirstLine then begin
                        if ("field[1]" <> 'Store ID') or
                           ("field[2]" <> 'Order Number') or
                           ("field[3]" <> 'Order Date') or
                           ("field[4]" <> 'Name') or
                           ("field[5]" <> 'Address 1') or
                           ("field[6]" <> 'Address 2') or
                           ("field[7]" <> 'City') or
                           ("field[8]" <> 'State') or
                           ("field[9]" <> 'Zip') or
                           ("field[10]" <> 'Country') or
                           ("field[11]" <> 'Phone') or
                           ("field[12]" <> 'Email') or
                           ("field[13]" <> 'Style No.') or
                           ("field[14]" <> 'Size') or
                           ("field[15]" <> 'Quantity') or
                           ("field[16]" <> 'Unit Price') or
                           ("field[17]" <> 'Shipping Total') or
                           ("field[18]" <> 'Resource No.') or
                           ("field[19]" <> 'Shipping Agent') or
                           ("field[20]" <> 'Agent Service') or
                           ("field[21]" <> 'Taxed') then
                            ERROR('The Header row does not match. The allowed columns and their orders are:\' +
                                  'Store ID, Order Number, Order Date, Name, Address 1, Address 2, City, State, Zip, Country, Phone, Email, \' +
                                  'Style No., Size, Quantity, Unit Price, Shipping Total, Resource No., Shipping Agent, Agent Service, Taxed');

                        FirstLine := false;
                        currXMLport.SKIP;
                    end else begin
                        with TempWebOrder do begin
                            /*
                            MESSAGE('Store ID       :' + Field[1] + '\' +
                                    'Order Number   :' + Field[2] + '\' +
                                    'Order Date     :' + Field[3] + '\' +
                                    'Name           :' + Field[4] + '\' +
                                    'Address 1      :' + Field[5] + '\' +
                                    'Address 2      :' + Field[6] + '\' +
                                    'City           :' + Field[7] + '\' +
                                    'State          :' + Field[8] + '\' +
                                    'Zip            :' + Field[9] + '\' +
                                    'Country        :' + Field[10] + '\' +
                                    'Phone          :' + Field[11] + '\' +
                                    'Email          :' + Field[12] + '\' +
                                    'Style No.      :' + Field[13] + '\' +
                                    'Size           :' + Field[14] + '\' +
                                    'Quantity       :' + Field[15] + '\' +
                                    'Unit Price     :' + Field[16] + '\' +
                                    'Shipping Total :' + Field[17] + '\' +
                                    'Resource No.   :' + Field[18] + '\' +
                                    'Shipping Agent :' + Field[19] + '\' +
                                    'Agent Service  :' + Field[20] + '\' +
                                    'Taxed        :' + Field[21] );
                            */


                            WebOrder1.SETRANGE("Store ID", Field[1]);
                            if WebOrder1.FINDFIRST then
                                if Reimport then
                                    WebOrder1.DELETEALL
                                else
                                    ERROR(TEXT100,
                                      WebOrder1."Store ID",
                                      WebOrder1."Imported By User",
                                      WebOrder1."Import Date");


                            INIT;
                            LineNo += 1;
                            "Entry No." := LineNo;
                            EVALUATE("Store ID", "field[1]");
                            TESTFIELD("Store ID");
                            EVALUATE("Order No.", "field[2]");
                            TESTFIELD("Order No.");
                            if EVALUATE(OrderDateTime, "field[3]") then
                                OrderDate := DT2DATE(OrderDateTime)
                            else
                                EVALUATE(OrderDate, "field[3]");

                            "Order Date" := OrderDate;
                            TESTFIELD("Order Date");
                            "Ship-to Name" := "field[4]";
                            TESTFIELD("Ship-to Name");
                            "Ship-to Address" := COPYSTR("field[5]", 1, 50);
                            TESTFIELD("Ship-to Address");
                            "Ship-to Address 2" := COPYSTR("field[6]", 1, 50);
                            "Ship-to City" := COPYSTR("field[7]", 1, 30);
                            TESTFIELD("Ship-to City");
                            "Ship-to County" := COPYSTR("field[8]", 1, 30);
                            EVALUATE("Ship-to Post Code", COPYSTR("field[9]", 1, 20));
                            TESTFIELD("Ship-to Post Code");
                            "Ship-to Country/Region Code" := "field[10]";
                            TESTFIELD("Ship-to Country/Region Code");
                            EVALUATE("Ship-to Phone", COPYSTR("field[11]", 1, 30));
                            "Ship-to Email" := "field[12]";
                            EVALUATE("Style No.", "field[13]");
                            //EVALUATE(UPC, "field[22]");
                            //VALIDATE("Style No.",Field[13]);

                            if Sizes.GET("field[14]") then
                                VALIDATE(Size, Sizes.Code)
                            else
                                ERROR('There is no Size available with Description: %1', Field[14]);

                            EVALUATE(Quantity, "field[15]");
                            TESTFIELD(Quantity);

                            EVALUATE("Unit Price", "field[16]");

                            EVALUATE("Shipping Total", "field[17]");

                            "Resource No." := "field[18]";
                            TESTFIELD("Resource No.");

                            "Shipping Agent" := "field[19]";
                            TESTFIELD("Shipping Agent");

                            "Shipping Agent Service" := "field[20]";
                            TESTFIELD("Shipping Agent Service");

                            if ("field[21]" = 'Y') or ("field[21]" = 'y') then
                                Taxable := true;

                            "Import Date" := TODAY;
                            "Import Time" := TIME;
                            "Imported By User" := USERID;
                            "Customer No." := CustNo;
                            "Customer Name" := CustName;
                            INSERT;


                            for i := 1 to ARRAYLEN(Field) do begin
                                Field[i] := '';
                            end;
                        end;
                    end;

                end;

                trigger OnPreXmlItem();
                begin
                    FirstLine := true;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(CustNo; CustNo)
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Customer.GET(CustNo);
                        CustName := Customer.Name;
                        RequestOptionsPage.UPDATE;
                    end;
                }
                field(CustName; CustName)
                {
                    Editable = false;
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                // field(Filename; Filename)
                // {
                //     ApplicationArea = All;
                //     trigger OnAssistEdit()
                //     var
                //     begin

                //         Filename := CommDialog.OpenFile('Select Store Orders File...', Filename, 4, 'Store Order (*.csv)|*.csv', 0);
                //         CurrDataport.FILENAME := Filename;
                //     end;
                // }
                field(Reimport; Reimport)
                {
                    Caption = 'ReImport Orders';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    var
        _tempWebOrder: Record "LEE_Web Order" temporary;
    begin

        if TempWebOrder.FINDSET then
            repeat
                CLEAR(EntryNo);
                EntryNo := 1;
                WebOrder2.LOCKTABLE;
                if WebOrder2.FINDLAST then
                    EntryNo := WebOrder2."Entry No." + 1;

                WebOrder3 := TempWebOrder;
                WebOrder3."Entry No." := EntryNo;
                WebOrder3.INSERT;
                _tempWebOrder := WebOrder3;
                _tempWebOrder.INSERT;
            until TempWebOrder.NEXT = 0;

        if _tempWebOrder.FINDSET then
            repeat
                UpdateShipToCode(_tempWebOrder);
            until _tempWebOrder.NEXT = 0;
        MESSAGE('Store orders were successfully imported.');
    end;

    trigger OnPreXmlPort();
    begin

        if CustNo = '' then
            ERROR(TEXT300);

        FirstLine := true;
    end;

    var
        WebOrder1: Record "LEE_Web Order";
        "Field": array[25] of Text[250];
        LineNo: Integer;
        WebOrder2: Record "LEE_Web Order";
        EntryNo: Integer;
        WebOrder: Record "LEE_Web Order";
        FirstLine: Boolean;
        OrderDateTime: DateTime;
        OrderDate: Date;
        TempWebOrder: Record "LEE_Web Order" temporary;
        i: Integer;
        Reimport: Boolean;
        Filename: Text[1024];
        Customer: Record Customer;
        CustNo: Code[20];
        CustName: Text[50];
        WebOrder3: Record "LEE_Web Order";
        Sizes: Record LEE_Size;
        TEXT100: Label 'Orders of Store %1 were imported by user %2 on %3. There are no new orders imported.';
        TEXT200: Label 'Country is not valid. Store: %1, Order No.: %2, Name: %3, Country: %4';
        TEXT300: Label 'Please select Store''s Customer No.';

    procedure UpdateShipToCode(_tmpweborder: Record "LEE_Web Order");
    var
        ShipToAddress: Record "Ship-to Address";
        _weborder: Record "LEE_Web Order";
        _country: Record "Country/Region";
        _length: Integer;
        ShipToAddress2: Record "Ship-to Address";
        NewCode: Code[10];
        _continue: Boolean;
    begin
        with _tmpweborder do begin
            ShipToAddress.RESET;
            ShipToAddress.SETRANGE("Customer No.", "Customer No.");
            ShipToAddress.SETRANGE(Name, "Ship-to Name");
            ShipToAddress.SETRANGE(Address, "Ship-to Address");
            ShipToAddress.SETRANGE("Address 2", "Ship-to Address 2");
            ShipToAddress.SETRANGE(City, "Ship-to City");
            _length := STRLEN("Ship-to Country/Region Code");
            case _length of
                0:
                    ShipToAddress.SETRANGE("Country/Region Code", 'US');
                2:
                    ShipToAddress.SETRANGE("Country/Region Code", "Ship-to Country/Region Code");
                else begin
                        _country.SETRANGE(Name, "Ship-to Country/Region Code");
                        if _country.FINDFIRST then
                            ShipToAddress.SETRANGE("Country/Region Code", _country.Code)
                        else
                            ERROR(TEXT200,
                            _tmpweborder."Store ID",
                            _tmpweborder."Order No.",
                            _tmpweborder."Ship-to Name",
                            _tmpweborder."Ship-to Country/Region Code");
                    end;
            end;
            ShipToAddress.SETRANGE(County, "Ship-to County");
            ShipToAddress.SETRANGE("Post Code", "Ship-to Post Code");
            if ShipToAddress.FINDFIRST then begin
                _weborder.GET("Entry No.");
                _weborder."Ship-to Code" := ShipToAddress.Code;
                _weborder.MODIFY;
            end else begin
                NewCode := FORMAT(DATE2DWY(TODAY, 2)) +
                           COPYSTR(FORMAT(DATE2DWY(TODAY, 3)), 3, 2);
                NewCode := NewCode + '000000';
                CLEAR(_continue);
                repeat
                    NewCode := INCSTR(NewCode);
                    if not ShipToAddress2.GET("Customer No.", NewCode) then
                        _continue := true;
                until _continue = true;

                ShipToAddress.INIT;
                ShipToAddress."Customer No." := "Customer No.";
                ShipToAddress.Code := NewCode;
                ShipToAddress.Name := "Ship-to Name";
                ShipToAddress.Address := "Ship-to Address";
                ShipToAddress."Address 2" := "Ship-to Address 2";
                ShipToAddress.City := "Ship-to City";
                ShipToAddress.County := "Ship-to County";
                ShipToAddress."Post Code" := "Ship-to Post Code";
                _length := STRLEN("Ship-to Country/Region Code");
                case _length of
                    0:
                        ShipToAddress.VALIDATE("Country/Region Code", 'US');
                    2:
                        ShipToAddress.VALIDATE("Country/Region Code", "Ship-to Country/Region Code");
                    else begin
                            _country.SETRANGE(Name, "Ship-to Country/Region Code");
                            if _country.FINDFIRST then
                                ShipToAddress.VALIDATE("Country/Region Code", _country.Code)
                            else
                                ERROR(TEXT200,
                                _tmpweborder."Store ID",
                                _tmpweborder."Order No.",
                                _tmpweborder."Ship-to Name",
                                _tmpweborder."Ship-to Country/Region Code");
                        end;
                end;
                ShipToAddress."Phone No." := "Ship-to Phone";
                ShipToAddress.VALIDATE("E-Mail", "Ship-to Email");
                ShipToAddress.INSERT(true);
                //CV_PS 11182020>>
                ShipToAddress.Name := "Ship-to Name";
                ShipToAddress.Modify();
                //CV_PS 11182020<<
                _weborder.GET("Entry No.");
                _weborder."Ship-to Code" := ShipToAddress.Code;
                _weborder.MODIFY;
            end;
            COMMIT;
        end;
    end;
}

