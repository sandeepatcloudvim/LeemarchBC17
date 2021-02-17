page 50017 "Job Queue Task Execution"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    // SourceTable = TableName;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Job Queue Entry ID"; JobQueueEntry.ID)
                {
                    ApplicationArea = All;
                }
                field("No. of Minutes Between Runs"; ExecInterval)
                {
                    ApplicationArea = All;
                }
                field("Object Type to Run"; FORMAT(JobQueueEntry."Object Type to Run"))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Object ID to Run"; JobQueueEntry."Object ID to Run")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Object Name to Run"; JobQueueEntry."Object Caption to Run")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Execution Date/Time"; FORMAT(ExecTimeLast, 0, '<Month,2>/<Day,2>/<Year4> <Hours24>:<Minutes,2>:<Seconds,2>'))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Next Execution Date/Time"; FORMAT(ExecTimeNext, 0, '<Month,2>/<Day,2>/<Year4> <Hours24>:<Minutes,2>:<Seconds,2>'))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Heartbeat; FORMAT(Heartbeat))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Execution Count"; ExecCount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Log Entries")
            {
                ApplicationArea = All;
                Image = History;

                trigger OnAction()
                begin
                    ShowLogEntries();
                end;
            }
            group("Change &Status")
            {
                action(Ready)
                {
                    ApplicationArea = All;
                    Image = Start;

                    trigger OnAction()
                    begin

                        IF (Status = Status::Ready) THEN
                            EXIT;

                        JobQueueEntry.TESTFIELD(ID);

                        Status := Status::Ready;

                        InitTimer();

                        UpdateExecTime();
                    end;
                }
                action(Paused)
                {
                    ApplicationArea = All;
                    Image = Pause;

                    trigger OnAction()
                    begin

                        Status := Status::Paused;

                        InitTimer();

                        UpdateExecTime();
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        InitForm();
    end;

    var
        JobQueueEntry: Record "Job Queue Entry";
        NAVTimer: Integer;//CV_PS
        ExecCount: Integer;
        ExecInterval: Integer;
        ExecTimeLast: DateTime;
        ExecTimeNext: DateTime;
        Heartbeat: DateTime;
        Status: Option Ready,Processing,Paused,Error;
        Text00001: Label 'No. of Minutes Between Runs cannot be zero when the Status is "Ready".';

    procedure ExecuteTask()
    var
        myInt: Integer;
    begin

        IF (ExecTimeNext = 0DT) OR
           (CURRENTDATETIME < ExecTimeNext)
        THEN
            EXIT;

        ExecTimeLast := CURRENTDATETIME;
        Status := Status::Processing;

        CurrPage.UPDATE(FALSE);

        CASE JobQueueEntry."Object Type to Run" OF
            JobQueueEntry."Object Type to Run"::Codeunit:
                CODEUNIT.RUN(JobQueueEntry."Object ID to Run", JobQueueEntry);
            JobQueueEntry."Object Type to Run"::Report:
                REPORT.RUN(JobQueueEntry."Object ID to Run", FALSE, FALSE, JobQueueEntry);
        END;

        JobQueueEntry.FIND('=');

        Status := Status::Ready;
        ExecCount += 1;

        UpdateExecTime();
    end;

    local procedure InitForm()
    var
        myInt: Integer;
    begin

        CLEAR(JobQueueEntry);

        Status := Status::Paused;
        ExecCount := 0;
        ExecTimeLast := 0DT;
        ExecTimeNext := 0DT;
        Heartbeat := 0DT;

        UpdateExecTime();
    end;

    local procedure InitTimer()
    var
        myInt: Integer;
    begin
        //CV__PS>>
        // Heartbeat := 0DT;

        // IF ISCLEAR(NAVTimer) THEN
        //     CREATE(NAVTimer);

        // NAVTimer.Enabled := FALSE;
        // NAVTimer.Interval := 5000;

        // IF (Status = Status::Ready) THEN
        //     NAVTimer.Enabled := TRUE;
        //CV__PS>>
    end;

    local procedure JobQueueEntryIDOnValidate()
    var
        myInt: Integer;
    begin

        JobQueueEntry.FIND('=');
        JobQueueEntry.CALCFIELDS("Object Caption to Run");

        JobQueueEntry.TESTFIELD(Status, JobQueueEntry.Status::Ready);
        JobQueueEntry.TESTFIELD("Object ID to Run");
        JobQueueEntry.TESTFIELD("Recurring Job", TRUE);
        JobQueueEntry.TESTFIELD("No. of Minutes between Runs");

        ExecInterval := JobQueueEntry."No. of Minutes between Runs";
    end;

    local procedure ShowLogEntries()
    var
        _jobQLogEntry: Record "Job Queue Log Entry";
        _jobQLogEntries: Page "Job Queue Log Entries";
    begin

        JobQueueEntry.TESTFIELD(ID);

        _jobQLogEntry.ASCENDING(FALSE);
        _jobQLogEntry.SETRANGE(ID, JobQueueEntry.ID);

        CLEAR(_jobQLogEntries);
        _jobQLogEntries.SETTABLEVIEW(_jobQLogEntry);
        _jobQLogEntries.EDITABLE(FALSE);
        _jobQLogEntries.RUN
    end;

    local procedure UpdateExecTime()
    var

    begin

        IF (ExecInterval = 0) AND
           (Status = Status::Ready)
        THEN
            ERROR(Text00001);

        ExecTimeNext := 0DT;

        IF (Status = Status::Ready) AND
           (ExecInterval > 0)
        THEN
            ExecTimeNext := CURRENTDATETIME + (ExecInterval * 60000);
    end;


}
