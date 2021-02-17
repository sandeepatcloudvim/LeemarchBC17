codeunit 50002 "Store Order Management"
{
    // version J11515


    trigger OnRun();
    begin
    end;

    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        pos: Integer;

    procedure ImportStoreOrders();
    var
        WebOrderDataport: XmlPort "Web Order Import";
    begin

        CLEAR(WebOrderDataport);
        WebOrderDataport.RUN();
    end;

    procedure MakeSalesOrder(var WebOrder: Record "LEE_Web Order"; OrderDate: Date; ShipmentDate: Date; CancelDate: Date; ReleaseOrder: Boolean);
    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        Customer: Record Customer;
        Item: Record Item;
        recShipToAdd: Record "Ship-to Address";
        WebOrder2: Record "LEE_Web Order";
        CurrentOrderNo: Code[20];
        LineNo: Integer;
        SL2: Record "Sales Line";
        UPC_Color: Code[10];
        UPC_Size: Code[10];
        ItemCrossRef: Record "Item Cross Reference";
        VariantCode: Code[10];
        hyphen: Integer;
    begin

        IF NOT WebOrder."Sales Order Created" THEN BEGIN

            WebOrder2.SETRANGE("Store ID", WebOrder."Store ID");
            WebOrder2.SETRANGE("Order No.", WebOrder."Order No.");
            WebOrder2.SETRANGE("Sales Order Created", TRUE);

            IF NOT WebOrder2.FINDFIRST THEN BEGIN
                SH.INIT;
                SH."Document Type" := SH."Document Type"::Order;
                SH."No." := '';
                SH.INSERT(TRUE);
                SH.SetHideValidationDialog(TRUE);
                SH."Sell-to Customer No." := WebOrder."Customer No.";
                SH.InitRecord();

                SH.VALIDATE("Posting Date", OrderDate);
                SH.VALIDATE("Order Date", OrderDate);
                SH.VALIDATE("LEE_Start Ship Date", OrderDate);
                SH.VALIDATE("Sell-to Customer No.", WebOrder."Customer No.");
                SH.VALIDATE("External Document No.", WebOrder."Order No.");
                SH.VALIDATE("Your Reference", WebOrder."Store ID");
                SH.VALIDATE("Ship-to Code", WebOrder."Ship-to Code");
                SH.VALIDATE("Shipment Method Code", 'DELIVERY');
                SH.VALIDATE("Shipping Agent Code", WebOrder."Shipping Agent");
                // SH.VALIDATE("E-Ship Agent Service", WebOrder."Shipping Agent Service");
                SH.VALIDATE("Shipment Date", ShipmentDate);
                SH.VALIDATE("Requested Delivery Date", CancelDate);
                SH.VALIDATE("LEE_Cancel Date", CancelDate);
                //CAN_PS 12062019 Start
                IF SH."Ship-to County" = 'CA' THEN
                    SH.VALIDATE("Tax Liable", TRUE);
                //CAN_PS 12062019 Stop
                SH.MODIFY(TRUE);

                if not recShipToAdd.get(SH."Sell-to Customer No.", SH."Ship-to Code") then begin
                    recShipToAdd.Init();
                    recShipToAdd."Customer No." := SH."Sell-to Customer No.";
                    recShipToAdd.Code := SH."Ship-to Code";
                    recShipToAdd.Name := SH."Ship-to Name";
                    recShipToAdd."Name 2" := SH."Ship-to Name 2";
                    recShipToAdd.Address := SH."Ship-to Address";
                    recShipToAdd."Address 2" := SH."Ship-to Address 2";
                    recShipToAdd.City := SH."Ship-to City";
                    recShipToAdd.Contact := SH."Ship-to Contact";
                    recShipToAdd.County := SH."Ship-to County";
                    recShipToAdd."Country/Region Code" := SH."Ship-to Country/Region Code";
                    recShipToAdd."Post Code" := SH."Ship-to Post Code";
                    recShipToAdd."Shipment Method Code" := SH."Shipment Method Code";
                    recShipToAdd."Shipping Agent Service Code" := SH."Shipping Agent Service Code";
                    if recShipToAdd.Insert() then;
                end;

            END ELSE BEGIN
                SH.RESET;
                SH.SETRANGE("Your Reference", WebOrder."Store ID");
                SH.SETRANGE("External Document No.", WebOrder."Order No.");
                IF NOT SH.FINDFIRST THEN
                    ERROR('Sales Header for Store ID: %1, Order No.: %2 was not found.', WebOrder."Store ID", WebOrder."Order No.")
                ELSE
                    //CAN_PS 12062019 Start
                    IF NOT SH."Tax Liable" THEN
                        IF SH."Ship-to County" = 'CA' THEN BEGIN
                            SH.VALIDATE("Tax Liable", TRUE);
                            SH.MODIFY(TRUE);
                        END;
                //CAN_PS 12062019 Stop
            END;

            SL2.SETRANGE("Document Type", SL2."Document Type"::Order);
            SL2.SETRANGE("Document No.", SH."No.");
            LineNo := 10000;
            IF SL2.FINDLAST THEN
                LineNo := SL2."Line No." + 10000;

            SL.INIT;
            SL.SetHideValidationDialog(TRUE);
            SL.VALIDATE("Document Type", SL."Document Type"::Order);
            SL.VALIDATE("Document No.", SH."No.");
            SL.VALIDATE("Line No.", LineNo);
            SL.VALIDATE(Type, SL.Type::Item);

            //SBC SNK 12-10-17
            UPC_Color := '';
            UPC_Size := WebOrder.Size;

            IF WebOrder.UPC <> '' THEN BEGIN
                ItemCrossRef.SETRANGE("Cross-Reference No.", WebOrder.UPC);
                IF ItemCrossRef.FIND('-') THEN BEGIN
                    pos := STRPOS(ItemCrossRef."Variant Code", '-'); //WCC SBC 2018-02-07
                    UPC_Color := COPYSTR(ItemCrossRef."Variant Code", 1, pos - 1); //WCC SBC 2018-02-07
                    Item.GET(ItemCrossRef."Item No.");
                END;
            END
            ELSE
                Item.GET(WebOrder."Style No.");

            //SBC SNK 12-10-17

            //SL.VALIDATE("No.",Item."No."); //CAN_PS COmmented 18062019
            SL.VALIDATE("No.", WebOrder."Style No."); //CAN_PS Added 18062019
            SL.VALIDATE("Size Code", WebOrder.Size);
            //SL.VALIDATE("LEE_Color Code", Item.Color);
            SL.VALIDATE("LEE_Color Code", UPC_Color); //SBC SNK 12-10-2017

            SL."Pattern Code" := Item.LEE_Pattern;
            SL.Fit := Item.LEE_Fit;
            SL.Zip := Item.LEE_Zip;
            SL.Pad := Item.LEE_Pad;
            SL."Flat Lock" := Item."LEE_Flat Lock";
            SL.Fabric := Item.LEE_Fabric;
            SL."Custom Item Group" := Item."LEE_Custom Item Group";
            SL."Custom Item No." := Item."LEE_Custom Item No.";
            SL.INSERT(TRUE);

            SL.VALIDATE(Quantity, WebOrder.Quantity);
            SL.VALIDATE("Unit Price", WebOrder."Unit Price");
            SL.MODIFY(TRUE);

            WebOrder."Sales Order No." := SH."No.";
            WebOrder."Sales Order Created" := TRUE;
            WebOrder."Order Created By User" := USERID;
            WebOrder."Order Created Date" := TODAY;
            WebOrder.MODIFY(TRUE);


            IF OrderIsComplete(WebOrder) THEN BEGIN

                AddShippingCharge(WebOrder);

                //CAN_PS 19062019 start comment
                //IF SH."Tax Liable" THEN
                //  AddWebOrderTaxLine(WebOrder); //CAN_PS 12062019 Added Code for Adding the TaxLine
                //CAN_PS 19062019 stop comment

                IF WebOrder.Taxable THEN BEGIN
                    SH."Tax Liable" := TRUE;
                    SH.UpdateSalesLines(SH.FIELDCAPTION("Tax Liable"), FALSE);
                    SH.MODIFY(TRUE);
                END;

                //SH.VALIDATE("Custom Order",TRUE); //CAN_PS 12062019 Commented Code
                SH.MODIFY(TRUE);

                AddDiscountline(WebOrder); //CAN_PS 18062019 Added code for adding the discount line

                IF ReleaseOrder THEN
                    IF SH.Status <> SH.Status::Released THEN
                        ReleaseSalesDoc.PerformManualRelease(SH);
            END;

        END;
    end;

    procedure AddShippingCharge(WebOrder: Record "LEE_Web Order");
    var
        SL: Record "Sales Line";
        LineNo: Integer;
        SL2: Record "Sales Line";
        WebOrder2: Record "LEE_Web Order";
    begin
        LineNo := 10000;
        SL2.SETRANGE("Document Type", SL2."Document Type"::Order);
        SL2.SETRANGE("Document No.", WebOrder."Sales Order No.");
        IF SL2.FINDLAST THEN
            LineNo := SL2."Line No." + 10000;
        //SL2.SETRANGE(Type, SL.Type::Resource);  //CAN_PS Commented 12062019
        SL2.SETRANGE(Type, SL.Type::"G/L Account"); //CAN_PS Added 12062019
        IF NOT SL2.FINDFIRST THEN BEGIN
            SL.INIT;
            SL.SetHideValidationDialog(TRUE);
            SL.VALIDATE("Document Type", SL."Document Type"::Order);
            SL.VALIDATE("Document No.", WebOrder."Sales Order No.");
            SL.VALIDATE("Line No.", LineNo);
            //  SL.VALIDATE(Type, SL.Type::Resource);        //CAN_PS Commented 12062019
            //  SL.VALIDATE("No.", WebOrder."Resource No."); //CAN_PS Commented 12062019
            SL.VALIDATE(Type, SL.Type::"G/L Account");     //CAN_PS Added 12062019
            SL.VALIDATE("No.", '5250');                     //CAN_PS Added 12062019
            SL.VALIDATE("Tax Group Code", 'NONTAXABLE');    //CAN_PS Added 13062019
            SL.INSERT(TRUE);
            SL.VALIDATE(Quantity, 1);
            SL.VALIDATE("Unit Price", WebOrder."Shipping Total");
            SL.MODIFY(TRUE);
        END;
    end;

    procedure OrderIsComplete(WebOrder: Record "LEE_Web Order"): Boolean;
    var
        SL: Record "Sales Line";
        LineNo: Integer;
        SL2: Record "Sales Line";
        WebOrder2: Record "LEE_Web Order";
    begin
        WebOrder2.SETRANGE("Store ID", WebOrder."Store ID");
        WebOrder2.SETRANGE("Order No.", WebOrder."Order No.");
        WebOrder2.SETRANGE("Sales Order Created", FALSE);
        IF WebOrder2.FINDFIRST THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    procedure ImportStoreOrdersWithUPC();
    var
        WebOrderDataportWithUPC: XmlPort "Web Order Import With UPC";
    begin

        CLEAR(WebOrderDataportWithUPC);
        WebOrderDataportWithUPC.RUN();
    end;

    procedure AddWebOrderTaxLine(WebOrder: Record "LEE_Web Order");
    var
        SL: Record "Sales Line";
        LineNo: Integer;
        SL2: Record "Sales Line";
        WebOrder2: Record "LEE_Web Order";
        SH: Record "Sales Header";
        TaxAmount: Decimal;
        SRSetup: Record "Sales & Receivables Setup";
    begin
        CLEAR(TaxAmount);
        SRSetup.GET;
        LineNo := 10000;
        SL2.SETRANGE("Document Type", SL2."Document Type"::Order);
        SL2.SETRANGE("Document No.", WebOrder."Sales Order No.");
        IF SL2.FINDLAST THEN
            LineNo := SL2."Line No." + 10000;
        SL2.SETRANGE(Type, SL.Type::"G/L Account");
        SL2.SETRANGE("No.", '2300');
        IF NOT SL2.FINDFIRST THEN BEGIN
            SL.INIT;
            SL.SetHideValidationDialog(TRUE);
            SL.VALIDATE("Document Type", SL."Document Type"::Order);
            SL.VALIDATE("Document No.", WebOrder."Sales Order No.");
            SL.VALIDATE("Line No.", LineNo);
            SL.VALIDATE(Type, SL.Type::"G/L Account");
            SL.VALIDATE("No.", '2300');
            SL.INSERT(TRUE);
            SL.VALIDATE(Quantity, 1);
            IF SH.GET(SH."Document Type"::Order, WebOrder."Sales Order No.") THEN BEGIN
                SH.CALCFIELDS(Amount);
                TaxAmount := (SRSetup."WebOrder Tax%" * SH.Amount) / 100;
                SL.VALIDATE("Unit Price", TaxAmount);
                SL.MODIFY(TRUE);
            END;

        END;
        IF SL2.FINDFIRST THEN BEGIN
            IF SH.GET(SH."Document Type"::Order, WebOrder."Sales Order No.") THEN BEGIN
                SH.CALCFIELDS(Amount);
                TaxAmount := (SRSetup."WebOrder Tax%" * SH.Amount) / 100;
                SL2."Unit Price" := TaxAmount;
                SL2.MODIFY(TRUE);
            END;

        END;
    end;

    procedure AddDiscountline(WebOrder: Record "LEE_Web Order");
    var
        RecWebOrder: Record "LEE_Web Order";
        DiscAmt: Decimal;
        SL: Record "Sales Line";
        LineNo: Integer;
        SL2: Record "Sales Line";
        WebOrder2: Record "LEE_Web Order";
    begin
        CLEAR(DiscAmt);
        RecWebOrder.SETCURRENTKEY("Store ID", "Order No.", "Sales Order Created");
        RecWebOrder.SETRANGE("Store ID", WebOrder."Store ID");
        RecWebOrder.SETRANGE("Order No.", WebOrder."Order No.");
        RecWebOrder.SETRANGE("Sales Order Created", TRUE);
        IF RecWebOrder.FINDFIRST THEN BEGIN
            //RecWebOrder.CALCSUMS(Discount);
            DiscAmt := RecWebOrder.Discount * (-1);

            LineNo := 10000;
            SL2.SETRANGE("Document Type", SL2."Document Type"::Order);
            SL2.SETRANGE("Document No.", WebOrder."Sales Order No.");
            IF SL2.FINDLAST THEN
                LineNo := SL2."Line No." + 10000;

            SL2.SETRANGE(Type, SL.Type::"G/L Account");
            SL2.SETRANGE("No.", '4400');  //CHange the GL Account Number for
            IF NOT SL2.FINDFIRST THEN BEGIN
                IF DiscAmt <> 0 THEN BEGIN
                    SL.INIT;
                    SL.SetHideValidationDialog(TRUE);
                    SL.VALIDATE("Document Type", SL."Document Type"::Order);
                    SL.VALIDATE("Document No.", WebOrder."Sales Order No.");
                    SL.VALIDATE("Line No.", LineNo);
                    SL.VALIDATE(Type, SL.Type::"G/L Account");
                    SL.VALIDATE("No.", '4400'); //CHange the GL Account Number for
                    SL.INSERT(TRUE);
                    SL."Unit Price" := DiscAmt;
                    SL.VALIDATE(Quantity, 1);
                    SL.MODIFY;
                END;
            END ELSE BEGIN
                IF DiscAmt <> 0 THEN BEGIN
                    SL."Unit Price" := DiscAmt;
                    SL.MODIFY;
                END;
            END;
        END;
    end;
}

