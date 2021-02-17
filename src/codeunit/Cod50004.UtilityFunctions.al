codeunit 50004 "Utility Functions"
{
    trigger OnRun()
    begin

        //BFC006 -
        IF (Parameter <> '') THEN BEGIN
            ExecuteObject();
            EXIT;
        END;
        //BFC006 +
    end;


    procedure ExecuteObject()
    var
        _exportItemAvail: Report "Export Item Avail. by Variant";
        _text00001: Label 'Parameter for ExecuteObject function "%1" is invalid.';
    begin
        //BFC006 -
        CASE Parameter OF
            'ITEMAVAILEXP':
                BEGIN
                    CLEAR(_exportItemAvail);
                    _exportItemAvail.UseRequestPage(FALSE);
                    _exportItemAvail.SetParameters(FilterPdStart, FilterPdEnd, FilterLocation, ExportBrandGrp, ExportFileName, TRUE);
                    _exportItemAvail.RUNMODAL;
                END;
            ELSE
                ERROR(_text00001, Parameter);
        END;
        //BFC006 +
    end;

    procedure SetItemAvailExpParams(_filterPdStart: Date; _filterPdEnd: Date; _filterLocation: Text[1024]; _exportBrandGrp: Code[20]; _exportFileName: Text[250]; _parameter: Code[20])
    var
        _text00001: Label '0123456789';
    begin
        //BFC006 -
        FilterPdStart := _filterPdStart;
        FilterPdEnd := _filterPdEnd;
        FilterLocation := _filterLocation;
        ExportBrandGrp := _exportBrandGrp;
        ExportFileName := _exportFileName;
        Parameter := _parameter;
        //BFC006 +
    end;

    procedure GetDateTimeStamp() txtDateTimeStamp: Text[80]
    var
    begin
        txtDateTimeStamp := FORMAT(TODAY) + ' ' + FORMAT(TIME) + ' ' + UPPERCASE(USERID);
    end;

    var
        ExportBrandGrp: Code[20];
        ExportFileName: Text[250];
        FilterLocation: Text[1024];
        FilterPdEnd: Date;
        FilterPdStart: Date;
        Parameter: Code[20];
}