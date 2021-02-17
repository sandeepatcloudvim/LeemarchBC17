report 50007 "Export Item Avail. Sched. Run"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ShowPrintStatus = false;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(JobQueueEntry; "Job Queue Entry")
        {
            trigger OnAfterGetRecord()
            var
                _exportBrandGrp: Record "Export Brand Group";
                _errorTxt: Text;
                _exportFileName: Text[250];
                _text00001: Label 'There is no %1 data to process.';
                _text00002: Label 'ITEMAVAILEXP';
            begin

                IF (_exportBrandGrp.FINDSET) THEN BEGIN
                    REPEAT
                        CLEARLASTERROR;
                        CLEAR(_errorTxt);

                        _exportFileName := SRSetup."Item Avail. Export File Path";

                        IF (COPYSTR(_exportFileName, STRLEN(_exportFileName), 1) <> '\') THEN
                            _exportFileName := _exportFileName + '\';

                        _exportFileName := _exportFileName + SetExportFileName(_exportBrandGrp.Code);

                        CLEAR(UtilityFunctions);
                        UtilityFunctions.SetItemAvailExpParams(
                          0D, FilterPdEnd, SRSetup."Default Availability Location", _exportBrandGrp.Code, _exportFileName, _text00002);
                        IF NOT (UtilityFunctions.RUN) THEN BEGIN
                            IF (GETLASTERRORTEXT <> '') THEN BEGIN
                                _errorTxt := COPYSTR(GETLASTERRORTEXT, 1, MAXSTRLEN(_errorTxt));
                                LogAddEntry(2, _errorTxt);
                            END;
                        END;
                    UNTIL _exportBrandGrp.NEXT = 0;
                END ELSE BEGIN
                    _errorTxt := STRSUBSTNO(_text00001, _exportBrandGrp.TABLECAPTION);
                    LogAddEntry(2, _errorTxt);
                END;
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin

        InitialiseReport();

        IF (JobQueueEntry.FINDFIRST) THEN;
        LogAddEntry(1, '');
    end;

    trigger OnPostReport()
    begin
        LogAddEntry(0, '');
    end;

    var
        SRSetup: Record "Sales & Receivables Setup";
        UtilityFunctions: Codeunit "Utility Functions";
        FilterPdEnd: Date;
        Text00001: Label 'Batch report execution complete.';

    local procedure InitialiseReport()
    begin
        SRSetup.GET();

        SRSetup.TESTFIELD("Default Availability Location");
        SRSetup.TESTFIELD("Item Avail. Export File Path");
        IF (FORMAT(SRSetup."Item Avail. Export Period Len.") = '') THEN
            SRSetup.FIELDERROR("Item Avail. Export Period Len.");

        IF (COPYSTR(SRSetup."Item Avail. Export File Path", STRLEN(SRSetup."Item Avail. Export File Path")) <> '\') THEN
            SRSetup."Item Avail. Export File Path" := SRSetup."Item Avail. Export File Path" + '\';

        FilterPdEnd := CALCDATE('<' + FORMAT(SRSetup."Item Avail. Export Period Len.") + '>', WORKDATE);
    end;

    local procedure LogAddEntry(_status: Option Success,"In Process",Error; _errorTxt: Text[2048])
    var
        _jobQueueLog: Record "Job Queue Log Entry";
    begin

        _jobQueueLog.INIT;
        _jobQueueLog."Entry No." := 0;    //autoincrementing field
        _jobQueueLog.ID := JobQueueEntry.ID;
        _jobQueueLog."User ID" := USERID;

        IF (_status <> _status::Success) THEN
            _jobQueueLog."Start Date/Time" := CURRENTDATETIME;

        IF (_status = _status::Success) THEN
            _jobQueueLog."End Date/Time" := CURRENTDATETIME;

        _jobQueueLog."Object Type to Run" := JobQueueEntry."Object Type to Run";
        _jobQueueLog."Object ID to Run" := JobQueueEntry."Object ID to Run";
        _jobQueueLog.Status := _status;

        IF (_status = _status::Error) THEN BEGIN
            IF (STRLEN(_errorTxt) > MAXSTRLEN(_jobQueueLog."Error Message")) THEN BEGIN
                _jobQueueLog."Error Message" := COPYSTR(_errorTxt, 1, MAXSTRLEN(_jobQueueLog."Error Message"));
                _errorTxt := COPYSTR(_errorTxt, MAXSTRLEN(_jobQueueLog."Error Message") + 1);
            END ELSE BEGIN
                _jobQueueLog."Error Message" := _errorTxt;
                _errorTxt := '';
            END;
            IF (_errorTxt <> '') THEN BEGIN
                // IF (STRLEN(_errorTxt) > MAXSTRLEN(_jobQueueLog."Error Message 2")) THEN BEGIN
                //     _jobQueueLog."Error Message 2" := COPYSTR(_errorTxt, 1, MAXSTRLEN(_jobQueueLog."Error Message 2"));
                //     _errorTxt := COPYSTR(_errorTxt, MAXSTRLEN(_jobQueueLog."Error Message 2") + 1);
                // END ELSE BEGIN
                //     _jobQueueLog."Error Message 2" := _errorTxt;
                //     _errorTxt := '';
                // END;
                // END;
                // IF (_errorTxt <> '') THEN BEGIN
                // IF (STRLEN(_errorTxt) > MAXSTRLEN(_jobQueueLog."Error Message 3")) THEN BEGIN
                //     _jobQueueLog."Error Message 3" := COPYSTR(_errorTxt, 1, MAXSTRLEN(_jobQueueLog."Error Message 3"));
                //     _errorTxt := COPYSTR(_errorTxt, MAXSTRLEN(_jobQueueLog."Error Message 3") + 1);
                // END ELSE BEGIN
                //     _jobQueueLog."Error Message 3" := _errorTxt;
                //     _errorTxt := '';
                // END;
                _jobQueueLog."Error Message" := _errorTxt;
            END;
        END;

        _jobQueueLog.INSERT(FALSE);

        COMMIT;
    end;

    local procedure SetExportFileName(_prefix: Code[20]): Text[250]
    var
        // _commonDlgMgmt: Codeunit "Common Dialog Management";
        _fileName: Text[80];
    begin

        _fileName := _prefix + '-' + FORMAT(DATE2DMY(WORKDATE, 3));

        IF (DATE2DMY(WORKDATE, 2) < 10) THEN
            _fileName := _fileName + '0' + FORMAT(DATE2DMY(WORKDATE, 2))
        ELSE
            _fileName := _fileName + FORMAT(DATE2DMY(WORKDATE, 2));

        IF (DATE2DMY(WORKDATE, 1) < 10) THEN
            _fileName := _fileName + '0' + FORMAT(DATE2DMY(WORKDATE, 1))
        ELSE
            _fileName := _fileName + FORMAT(DATE2DMY(WORKDATE, 1));

        _fileName := _fileName + '.csv';

        EXIT(_fileName);

    end;
}
