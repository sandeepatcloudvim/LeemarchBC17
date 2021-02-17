report 50004 "LEE_Update Style Feature"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update Style Feature.rdlc';

    dataset
    {
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

    labels
    {
    }

    trigger OnInitReport();
    begin
        ClearVariables;
    end;

    trigger OnPostReport();
    begin

        Window.CLOSE;
        MESSAGE('Store orders were successfully updated.');
    end;

    trigger OnPreReport();
    begin

        if StoreNo = '' then
            ERROR('Please enter Store No.');

        if StyleNo = '' then
            ERROR('Please enter Style No.');

        if (NewColor = '') and
            (NewZip = '') and
            (NewFit = '') and
            (NewPad = '') and
            (NewFlatLock = '') and
            (NewLycraColor = '') and
            (NewFabric = '') then
            ERROR('Please enter a new feature');

        SH.SETRANGE("Your Reference", StoreNo);
        if not SH.FINDSET then
            ERROR('Store %1 has no outstanding order.', StoreNo);

        TotalRec := SH.COUNT;
        CountRec := 1;
        Window.OPEN('Progress: @1@@@@@@@@');

        CLEAR(Found);
        repeat
            Window.UPDATE(1, ROUND(CountRec / TotalRec * 10000, 1));
            SL.SETRANGE("Document Type", SH."Document Type");
            SL.SETRANGE("Document No.", SH."No.");
            SL.SETRANGE(Type, SL.Type::Item);
            SL.SETRANGE("No.", StyleNo);
            if SL.FINDSET then begin

                IF NewColor <> '' THEN
                    SL.MODIFYALL("LEE_Color Code", NewColor);

                IF NewZip <> '' THEN
                    SL.MODIFYALL(Zip, NewZip);

                IF NewFit <> '' THEN
                    SL.MODIFYALL(Fit, NewFit);

                IF NewPad <> '' THEN
                    SL.MODIFYALL(Pad, NewPad);

                IF NewFlatLock <> '' THEN
                    SL.MODIFYALL("Flat Lock", NewFlatLock);

                IF NewFabric <> '' THEN
                    SL.MODIFYALL(Fabric, NewFabric);

                IF NewLycraColor <> '' THEN
                    SL.MODIFYALL("Lycra Color", NewLycraColor);

                Found := true;
            end;
        until SH.NEXT = 0;

        if not Found then
            ERROR('Store %1 has no outstanding Order for Style %2', StoreNo, StyleNo);
    end;

    var
        NewColor: Code[10];
        NewZip: Code[10];
        NewFit: Code[10];
        NewPad: Code[10];
        NewFlatLock: Code[10];
        NewFabric: Code[10];
        NewLycraColor: Code[10];
        Item: Record Item;
        StyleNo: Code[20];
        StoreNo: Code[20];
        WebOrder: Record "LEE_Web Order";
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        Found: Boolean;
        Window: Dialog;
        TotalRec: Integer;
        CountRec: Integer;

    procedure ClearVariables();
    begin
        CLEAR(NewColor);
        CLEAR(NewZip);
        CLEAR(NewFit);
        CLEAR(NewPad);
        CLEAR(NewFlatLock);
        CLEAR(NewFabric);
        CLEAR(NewLycraColor);
        CLEAR(StyleNo);
        CLEAR(StoreNo);
    end;
}

