xmlport 50006 "SO IMPORT - CAN  DSG"
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
                textelement("values[20]")
                {
                    XmlName = 'Value20';
                    MinOccurs = Zero;
                }
                textelement("values[21]")
                {
                    XmlName = 'Value21';
                    MinOccurs = Zero;
                }
                textelement("values[22]")
                {
                    XmlName = 'Value22';
                    MinOccurs = Zero;
                }

                trigger OnPreXmlItem()
                begin
                    OrderImprt.DELETEALL;
                end;

                trigger OnAfterInsertRecord()
                begin

                    WITH OrderImprt DO BEGIN
                        INIT;
                        "Entry No." := LastNo;
                        if StrPos("values[1]", '"') = 1 then begin
                            NewString := "values[1]";
                            NewString := DELCHR(NewString, '=', '"');

                            Value1 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value2 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value3 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value4 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value5 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value6 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value7 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value8 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value9 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value10 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value11 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value12 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value13 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value14 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value15 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value16 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value17 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value18 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value19 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value20 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value21 := COPYSTR(NewString, 1, (STRPOS(NewString, ',') - 1));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));

                            Value21 := COPYSTR(NewString, 1, (STRLEN(NewString)));
                            NewString := DELSTR(NewString, 1, STRPOS(NewString, ','));
                        end else begin
                            Value1 := "values[1]";
                            Value2 := "values[2]";
                            Value3 := "values[3]";
                            Value4 := "values[4]";
                            Value5 := "values[5]";
                            Value6 := "values[6]";
                            Value7 := "values[7]";
                            Value8 := "values[8]";
                            Value9 := "values[9]";
                            Value10 := "values[10]";
                            Value11 := "values[11]";
                            Value12 := "values[12]";
                            Value13 := "values[13]";
                            Value14 := "values[14]";
                            Value15 := "values[15]";
                            Value16 := "values[16]";
                            Value17 := "values[17]";
                            Value18 := "values[18]";
                            Value19 := "values[19]";
                            Value20 := "values[20]";
                            Value21 := "values[21]";

                            INSERT;
                        end;
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
        NewString: Text;

    procedure LastNo(): Integer;
    begin
        if OrderImprt.FINDLAST then
            LineNo := OrderImprt."Entry No." + 1;
        exit(LineNo);
    end;
}

