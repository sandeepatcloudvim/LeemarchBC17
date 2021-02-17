codeunit 50006 EventSubscriber
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Cust./Item Stat. by Salespers." then
            NewReportId := Report::"LEE Cust/Item Stat by Salesper";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeRecreateSalesLinesHandler', '', false, false)]
    local procedure UpdateVatInfo(VAR SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; ChangedFieldName: Text[100]; VAR IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}