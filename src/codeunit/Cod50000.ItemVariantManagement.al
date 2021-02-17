codeunit 50000 "Item Variant Management"
{
    // version OPS01


    trigger OnRun();
    begin
    end;

    var
        ItemVarMgmtSetup: Record "Item Variant Mgmt. Setup";
        SizeColorVarType: Option "00","01","02","10","11","12","20","21","22";
        bSuppressMessage: Boolean;

    procedure SetDefaultSizeColorVarType();
    begin
        CLEAR(ItemVarMgmtSetup);
        ItemVarMgmtSetup.FIND('-');
        SizeColorVarType := ItemVarMgmtSetup."Size/Color Variant Type";
    end;

    procedure SetCurrentSizeColorVarType(SzColVarType: Option "00","01","02","10","11","12","20","21","22");
    begin
        SizeColorVarType := SzColVarType;
    end;

    procedure SetColorVariantSetup(ItemColor: Record "Item Color");
    var
        ItemSize: Record "Item Size";
    begin
        SetDefaultSizeColorVarType;
        ItemSize.SETRANGE("Item No.", ItemColor."Item No.");
        if (ItemSize.FIND('-')) then
            repeat
                SetVariantSetup(ItemColor."Item No.", ItemColor, ItemSize);
            until (ItemSize.NEXT = 0);
    end;

    procedure SetSizeVariantSetup(ItemSize: Record "Item Size");
    var
        ItemColor: Record "Item Color";
    begin
        SetDefaultSizeColorVarType;
        ItemColor.SETRANGE("Item No.", ItemSize."Item No.");
        if (ItemColor.FIND('-')) then
            repeat
                SetVariantSetup(ItemSize."Item No.", ItemColor, ItemSize);
            until (ItemColor.NEXT = 0);
    end;

    procedure SetVariantSetup("ItemNo.": Code[20]; ItemColor: Record "Item Color"; ItemSize: Record "Item Size");
    var
        Variant: Record "Item Variant";
    begin
        ItemColor.CALCFIELDS("Variant Assignment Code");
        ItemSize.CALCFIELDS("Variant Assignment Code");

        case (SizeColorVarType) of
            SizeColorVarType::"00": // No Saleable Variant / No Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                     ItemVarMgmtSetup."Variant Separator" +
                                     ItemSize."Variant Assignment Code");
                    Variant.DELETEALL(true);

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    Variant.DELETEALL(true);

                end;
            SizeColorVarType::"01": // No Saleable Variant / Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                     ItemVarMgmtSetup."Variant Separator" +
                                     ItemSize."Variant Assignment Code");
                    Variant.DELETEALL(true);

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := false;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);

                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Sample Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant.Blocked := false;
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";
                        Variant.INSERT;

                    end;

                end;
            SizeColorVarType::"02": // No Saleable Variant / Blocked Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" + ItemSize."Variant Assignment Code");
                    Variant.DELETEALL(true);

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := true;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);

                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Sample Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant.Blocked := true;
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;
                end;
            SizeColorVarType::"10": // Saleable Variant / No Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := false;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    Variant.DELETEALL(true);

                end;
            SizeColorVarType::"11": // Saleable Variant / Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemSize."Variant Assignment Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := false;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := false;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemSize."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Sample Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                end;
            SizeColorVarType::"12": // Saleable Variant / Blocked Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := false;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := true;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Sample Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant.Blocked := true;
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                end;
            SizeColorVarType::"20": // Blocked Saleable Variant / No Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := true;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant.Blocked := true;
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    Variant.DELETEALL(true);

                end;
            SizeColorVarType::"21": // Blocked Saleable Variant / Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                     ItemVarMgmtSetup."Variant Separator" +
                                     ItemSize."Variant Assignment Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := true;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant.Blocked := true;
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := false;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Sample Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                end;
            SizeColorVarType::"22": // Blocked Saleable Variant / Blocked Sample Variant
                begin

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := true;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant.Blocked := true;
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                    CLEAR(Variant);

                    Variant.SETRANGE("Item No.", "ItemNo.");
                    Variant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Variant Separator" +
                                           ItemSize."Variant Assignment Code" +
                                           ItemVarMgmtSetup."Sample Code");
                    if (Variant.FIND('-')) then begin

                        Variant.Blocked := true;
                        Variant.MODIFY;

                    end else begin

                        CLEAR(Variant);
                        Variant."Item No." := "ItemNo.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Sample Code";
                        GetVariantDescriptions(Variant, ItemColor, ItemSize);
                        Variant.Blocked := true;
                        Variant."Color Code" := ItemColor."Color Code";
                        Variant."Size Code" := ItemSize."Size Code";

                        Variant.INSERT;

                    end;

                end;
        end;
    end;

    procedure GetVariantSetup("ItemNo.": Code[20]; ColorCode: Code[10]; SizeCode: Code[10]) VarType: Integer;
    var
        ItemSize: Record "Item Size";
        ItemColor: Record "Item Color";
        SaleableVariant: Record "Item Variant";
        SampleVariant: Record "Item Variant";
    begin
        if not (ItemVarMgmtSetup.FIND('-')) then
            exit(0);
        if not (ItemColor.GET("ItemNo.", ColorCode)) then
            exit(0);
        if not (ItemSize.GET("ItemNo.", SizeCode)) then
            exit(0);

        ItemColor.CALCFIELDS("Variant Assignment Code");
        ItemSize.CALCFIELDS("Variant Assignment Code");

        SaleableVariant.SETCURRENTKEY("Item No.", Code);
        SaleableVariant.SETRANGE("Item No.", "ItemNo.");
        SaleableVariant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                 ItemVarMgmtSetup."Variant Separator" +
                                 ItemSize."Variant Assignment Code");

        SampleVariant.SETCURRENTKEY("Item No.", Code);
        SampleVariant.SETRANGE("Item No.", "ItemNo.");
        SampleVariant.SETRANGE(Code, ItemColor."Variant Assignment Code" +
                                     ItemVarMgmtSetup."Variant Separator" +
                                     ItemSize."Variant Assignment Code" +
                                     ItemVarMgmtSetup."Sample Code");

        // SizeColorVarType::"00" - No Saleable Variant / No Sample Variant

        if not (SaleableVariant.FIND('-'))
         and not (SampleVariant.FIND('-')) then
            exit(0);

        // SizeColorVarType::"01" - No Saleable Variant / Sample Variant

        SaleableVariant.SETRANGE(Blocked);
        SampleVariant.SETRANGE(Blocked, false);
        if not (SaleableVariant.FIND('-'))
         and (SampleVariant.FIND('-')) then
            exit(1);

        // SizeColorVarType::"02" - No Saleable Variant / Blocked Sample Variant

        SaleableVariant.SETRANGE(Blocked);
        SampleVariant.SETRANGE(Blocked, true);
        if not (SaleableVariant.FIND('-'))
         and (SampleVariant.FIND('-')) then
            exit(2);

        // SizeColorVarType::"10" - Saleable Variant / No Sample Variant

        SaleableVariant.SETRANGE(Blocked, false);
        SampleVariant.SETRANGE(Blocked);
        if (SaleableVariant.FIND('-'))
         and not (SampleVariant.FIND('-')) then
            exit(3);

        // SizeColorVarType::"11" - Saleable Variant / Sample Variant

        SaleableVariant.SETRANGE(Blocked, false);
        SampleVariant.SETRANGE(Blocked, false);
        if (SaleableVariant.FIND('-'))
         and (SampleVariant.FIND('-')) then
            exit(4);

        // SizeColorVarType::"12" - Saleable Variant / Blocked Sample Variant

        SaleableVariant.SETRANGE(Blocked, false);
        SampleVariant.SETRANGE(Blocked, true);
        if (SaleableVariant.FIND('-'))
         and (SampleVariant.FIND('-')) then
            exit(5);

        // SizeColorVarType::"20" - Blocked Saleable Variant / No Sample Variant

        SaleableVariant.SETRANGE(Blocked, true);
        SampleVariant.SETRANGE(Blocked);
        if (SaleableVariant.FIND('-'))
         and not (SampleVariant.FIND('-')) then
            exit(6);

        // SizeColorVarType::"21" - Blocked Saleable Variant / Sample Variant

        SaleableVariant.SETRANGE(Blocked, true);
        SampleVariant.SETRANGE(Blocked, false);
        if (SaleableVariant.FIND('-'))
         and (SampleVariant.FIND('-')) then
            exit(7);

        // SizeColorVarType::"22" - Blocked Saleable Variant / Blocked Sample Variant

        SaleableVariant.SETRANGE(Blocked, true);
        SampleVariant.SETRANGE(Blocked, true);
        if (SaleableVariant.FIND('-'))
         and (SampleVariant.FIND('-')) then
            exit(8);
    end;

    procedure CreateVariants(Item: Record Item);
    var
        ItemColor: Record "Item Color";
        ItemSize: Record "Item Size";
        ItemVarMgmtSetup: Record "Item Variant Mgmt. Setup";
        Variant: Record "Item Variant";
        VariantCreated: Integer;
    begin
        ItemVarMgmtSetup.FINDFIRST;

        ItemColor.SETRANGE(ItemColor."Item No.", Item."No.");
        if (ItemColor.FINDFIRST) then
            repeat
                ItemColor.CALCFIELDS(ItemColor."Variant Assignment Code");

                ItemSize.SETRANGE(ItemSize."Item No.", Item."No.");
                if (ItemSize.FINDFIRST) then
                    repeat
                        ItemSize.CALCFIELDS(ItemSize."Variant Assignment Code");
                        Variant."Item No." := Item."No.";
                        Variant.Code := ItemColor."Variant Assignment Code" +
                                        ItemVarMgmtSetup."Variant Separator" +
                                        ItemSize."Variant Assignment Code";

                        GetVariantDescriptions(Variant, ItemColor, ItemSize);

                        Variant."Size Code" := ItemSize."Size Code";
                        Variant."Color Code" := ItemColor."Color Code";

                        if (Variant.INSERT) then
                            VariantCreated += 1;

                    until (ItemSize.NEXT = 0);

            until (ItemColor.NEXT = 0);

        if not (bSuppressMessage) then
            MESSAGE('Created %1 Variants', VariantCreated);
    end;

    procedure SetSuppressMessage();
    begin
        bSuppressMessage := true;
    end;

    PROCEDURE GetVariantDescriptions(VAR Var1: Record "Item Variant"; ItemCol: Record "Item Color"; ItemSz: Record "Item Size");
    VAR
        Item: Record Item;
    BEGIN
        Item.GET("Var1"."Item No.");
        ItemCol.CALCFIELDS("Color Description");
        ItemSz.CALCFIELDS("Size Description");

        if (STRPOS("Var1".Code, ItemVarMgmtSetup."Sample Code") > 0) then
            "Var1".Description := COPYSTR(Item.Description + ' ' + ItemVarMgmtSetup."Sample Description", 1, MAXSTRLEN("Var1".Description))
        else
            "Var1".Description := COPYSTR(Item.Description, 1, MAXSTRLEN("Var1".Description));

        "Var1"."Description 2" := COPYSTR(ItemCol."Color Description" + ' ' +
                                         ItemSz."Size Description", 1,
                                         MAXSTRLEN("Var1"."Description 2"));
    END;

}

