xmlport 50005 "SO IMPORT - CAN"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number);
                textelement("values[1]")
                {
                    XmlName = 'Value1';
                    MinOccurs = Zero;
                }
                textelement("values[2]")
                {
                    XmlName = 'Value2';
                    MinOccurs = Zero;
                }
                textelement("values[3]")
                {
                    XmlName = 'Value3';
                    MinOccurs = Zero;
                }
                textelement("values[4]")
                {
                    XmlName = 'Value4';
                    MinOccurs = Zero;
                }
                textelement("values[5]")
                {
                    XmlName = 'Value5';
                    MinOccurs = Zero;
                }
                textelement("values[6]")
                {
                    XmlName = 'Value6';
                    MinOccurs = Zero;
                }
                textelement("values[7]")
                {
                    XmlName = 'Value7';
                    MinOccurs = Zero;
                }
                textelement("values[8]")
                {
                    XmlName = 'Value8';
                    MinOccurs = Zero;
                }
                textelement("values[9]")
                {
                    XmlName = 'Value9';
                    MinOccurs = Zero;
                }
                textelement("values[10]")
                {
                    XmlName = 'Value10';
                    MinOccurs = Zero;
                }
                textelement("values[11]")
                {
                    XmlName = 'Value11';
                    MinOccurs = Zero;
                }
                textelement("values[12]")
                {
                    XmlName = 'Value12';
                    MinOccurs = Zero;
                }
                textelement("values[13]")
                {
                    XmlName = 'Value13';
                    MinOccurs = Zero;
                }
                textelement("values[14]")
                {
                    XmlName = 'Value14';
                    MinOccurs = Zero;
                }
                textelement("values[15]")
                {
                    XmlName = 'Value15';
                    MinOccurs = Zero;
                }
                textelement("values[16]")
                {
                    XmlName = 'Value16';
                    MinOccurs = Zero;
                }
                textelement("values[17]")
                {
                    XmlName = 'Value17';
                    MinOccurs = Zero;
                }
                textelement("values[18]")
                {
                    XmlName = 'Value18';
                    MinOccurs = Zero;
                }
                textelement("values[19]")
                {
                    XmlName = 'Value19';
                    MinOccurs = Zero;
                }
                // textelement("values[20]")
                // {
                //     XmlName = 'Value20';
                // }

                trigger OnPreXmlItem()
                begin
                    OrderImprt.DELETEALL;
                    ReorderText := '';
                end;

                trigger OnAfterInsertRecord()
                begin

                    WITH OrderImprt DO BEGIN
                        INIT;
                        "Entry No." := LastNo;
                        //IF Values[1]" <> '** REORDERS' THEN BEGIN
                        Value1 := COPYSTR("values[1]", 1, 100);
                        Value2 := COPYSTR("values[2]", 1, 100);
                        Value3 := COPYSTR("values[3]", 1, 100);
                        Value4 := COPYSTR("values[4]", 1, 100);
                        Value5 := COPYSTR("values[5]", 1, 100);
                        Value6 := COPYSTR("values[6]", 1, 100);
                        Value7 := COPYSTR("values[7]", 1, 100);
                        Value8 := COPYSTR("values[8]", 1, 100);
                        Value9 := COPYSTR("values[9]", 1, 100);
                        Value10 := COPYSTR("values[10]", 1, 100);
                        Value11 := COPYSTR("values[11]", 1, 100);
                        Value12 := COPYSTR("values[12]", 1, 100);
                        Value13 := COPYSTR("values[13]", 1, 100);
                        Value14 := COPYSTR("values[14]", 1, 100);
                        Value15 := COPYSTR("values[15]", 1, 100);
                        Value16 := COPYSTR("values[16]", 1, 100);
                        Value17 := COPYSTR("values[17]", 1, 100);
                        Value18 := COPYSTR("values[18]", 1, 100);
                        Value19 := COPYSTR("values[19]", 1, 100);
                        CLEAR("values[19]"); //CAN_PS 20052019
                        //Value20 := COPYSTR("values[20]", 1, 100);
                        //END ELSE
                        IF "values[1]" = 'NOTES:' THEN BEGIN
                            Value1 := COPYSTR("values[1]", 1, 100);
                            Value2 := COPYSTR("values[2]", 1, 100);
                            Value3 := COPYSTR("values[2]", 100, 200);
                            Value4 := COPYSTR("values[2]", 200, 300);
                            Value5 := COPYSTR("values[2]", 300, 400);
                            Value6 := COPYSTR("values[2]", 400, 500);
                            //    MESSAGE("values[2]");
                        END;
                        IF "values[1]" = '** REORDERS' THEN BEGIN
                            ReorderText := "values[2]";
                            Value1 := COPYSTR("values[1]", 1, 100);
                            Value2 := COPYSTR("values[2]", 1, 100);
                            ReorderText := DELSTR("values[2]", 1, 100);
                            Value3 := COPYSTR(ReorderText, 1, 100);
                            ReorderText := DELSTR(ReorderText, 1, 100);
                            Value4 := COPYSTR(ReorderText, 1, 100);
                            ReorderText := DELSTR(ReorderText, 1, 100);
                            Value5 := COPYSTR(ReorderText, 1, 100);
                        END;
                        INSERT;

                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        OrderImprt: Record "SO IMPORT - CAN";
        "Fields": array[40] of Text[1024];
        LineNo: Integer;
        Values: array[100] of Text[1024];
        ReorderText: Text[1024];
        Text001: Label '"Re-orders of the same "';

    procedure LastNo(): Integer;
    begin
        if OrderImprt.FINDLAST then
            LineNo := OrderImprt."Entry No." + 1;
        exit(LineNo);
    end;
}

