// codeunit 50003 "Utility Functions"
// {
//     // version OPS046,BFC006

//     // // OPS029: 10/12/2009 (OfficeOps - JG)
//     // //         Created function run from the posted Sales Invoice that allows
//     // //         posted Document Dimensions to be changed and their associated entries updated.
//     // 
//     // // OPS046: 02/06/2013 (OfficeOps - JG)
//     // //         Modified original ValidateRepBrands function.
//     // //         Compare BRAND Dimensions on Sales Order against "authorized" BRAND Dimensions in Salesperson Brand Assignment
//     // //         on associated Salesperson Card.
//     // 
//     // //BFC006; 20170610; FRB
//     //   - Added functions: ExecuteObject(), SetItemAvailExpParams()
//     //   - Added code to execute item availability data export batch report


//     trigger OnRun();
//     begin
//         //BFC006 -
//         IF (Parameter <> '') THEN BEGIN
//             ExecuteObject();
//             EXIT;
//         END;
//         //BFC006 +
//     end;

//     var
//         ExportBrandGrp: Code[20];
//         ExportFileName: Text[250];
//         FilterLocation: Text[1024];
//         FilterPdEnd: Date;
//         FilterPdStart: Date;
//         Parameter: Code[20];

//     procedure GetDateTimeStamp() txtDateTimeStamp: Text[80];
//     begin
//         txtDateTimeStamp := FORMAT(TODAY) + ' ' + FORMAT(TIME) + ' ' + UPPERCASE(USERID);
//     end;

//     procedure ProperCase(UPPERCASETEXT: Text[50]) txtMixedCaseText: Text[50];
//     var
//         iCharNum: Integer;
//         txtPriorChar: Text[1];
//         txtSpecialChar: Text[30];
//     begin
//         iCharNum := 1;
//         txtPriorChar := ' ';
//         txtSpecialChar := ' (/-0123456789*.,';
//         REPEAT
//             IF (STRPOS(txtSpecialChar, txtPriorChar) <> 0) THEN
//                 txtMixedCaseText += UPPERCASE(COPYSTR(UPPERCASETEXT, iCharNum, 1))
//             ELSE
//                 txtMixedCaseText += LOWERCASE(COPYSTR(UPPERCASETEXT, iCharNum, 1));

//             txtPriorChar := COPYSTR(UPPERCASETEXT, iCharNum, 1);
//             iCharNum += 1;
//         UNTIL (iCharNum > STRLEN(UPPERCASETEXT))
//          OR (iCharNum > MAXSTRLEN(txtMixedCaseText));

//         EXIT(txtMixedCaseText);
//     end;

//     procedure MoveFileSafe(SourcePath: Text[512]; DestPath: Text[512]) OutFileName: Text[512];
//     var
//         File1: Record File;
//     begin
//         OutFileName := CopyFileSafe(SourcePath, DestPath);

//         // Reset file system record variable.  For some reason, Navision doesn't update this temporary
//         // table unless you change the filter.  Here, we change the filter to the root directory so that
//         // when it is set again, the latest contents of the folder will be viewed.
//         CLEAR(File1);
//         File1.SETRANGE(Path, 'c:\');
//         File1.FIND('-');

//         File1.SETRANGE(Path, DestPath);
//         File1.SETRANGE(Name, OutFileName);

//         IF (File1.FIND('-')) THEN
//             ERASE(SourcePath);

//         EXIT(OutFileName);
//     end;

//     procedure CopyFileSafe(SourcePath: Text[512]; DestPath: Text[512]) OutFileName: Text[512];
//     begin
//         OutFileName := GetFileName(SourcePath);
//         OutFileName := GetSafeFileName(DestPath, OutFileName);

//         IF NOT (FILE.COPY(SourcePath, DestPath + OutFileName)) THEN
//             OutFileName := '';

//         EXIT(OutFileName);
//     end;

//     procedure GetFileName(PathText: Text[1024]) OutFileName: Text[512];
//     var
//         PosIdx: Integer;
//         FoundBackSlash: Boolean;
//     begin
//         PosIdx := STRLEN(PathText);
//         IF (PosIdx > 0) THEN
//             REPEAT
//                 FoundBackSlash := (COPYSTR(PathText, PosIdx, 1) = '\');
//                 PosIdx -= 1;
//             UNTIL (PosIdx = 0)
// OR (FoundBackSlash);

//         IF (PosIdx = 0) THEN
//             OutFileName := PathText
//         ELSE // iPosIdx value needs to be adjusted by 2 positions.
//             OutFileName := COPYSTR(PathText, PosIdx + 2);

//         EXIT(OutFileName);
//     end;

//     procedure GetSafeFileName(PathText: Text[1024]; InFileName: Text[1024]) OutFileName: Text[512];
//     var
//         PosIdx: Integer;
//         FileIdx: Integer;
//         FileExt: Text[30];
//     begin
//         IF EXISTS(PathText + InFileName) THEN BEGIN
//             FOR PosIdx := STRLEN(InFileName) DOWNTO 1 DO BEGIN
//                 IF (COPYSTR(InFileName, PosIdx, 1) = '.') THEN BEGIN
//                     FileExt := COPYSTR(InFileName, PosIdx);
//                     InFileName := COPYSTR(InFileName, 1, (PosIdx - 1));
//                     PosIdx := 1;
//                 END;
//             END;

//             FileIdx := 1;

//             WHILE EXISTS(PathText + InFileName + '_' + FORMAT(FileIdx) + FileExt) DO BEGIN
//                 FileIdx += 1;
//             END;

//             InFileName := InFileName + '_' + FORMAT(FileIdx) + FileExt;

//         END;

//         OutFileName := InFileName;

//         EXIT(OutFileName);
//     end;

//     procedure CheckPath(InPathText: Text[512]) OutPathText: Text[512];
//     begin
//         IF NOT (InPathText[STRLEN(InPathText)] = '\') THEN
//             InPathText += '\';

//         OutPathText := InPathText;
//         EXIT(OutPathText);
//     end;

//     procedure CreateTempFile(var fFile: File; txtExtension: Text[10]);
//     var
//         fTmpFile: File;
//         txtTempFileName: Text[256];
//     begin
//         fTmpFile.CREATETEMPFILE;
//         txtTempFileName := fTmpFile.NAME;
//         fTmpFile.CLOSE;
//         fFile.TEXTMODE := TRUE;
//         fFile.CREATE(txtTempFileName + txtExtension);
//     end;

//     procedure ApplNewSInvDims(SInvHeader: Record "Sales Invoice Header");
//     var
//         GLSetup: Record "General Ledger Setup";
//         SrcCodeSetup: Record "Source Code Setup";
//         SInvLine: Record "Sales Invoice Line";
//         CLEntry: Record "Cust. Ledger Entry";
//         ILEntry: Record "Item Ledger Entry";
//         VEntry: Record "Value Entry";
//         GLEntry: Record "G/L Entry";
//         GLEntry2: Record "G/L Entry";
//         TGLEntry: Record "G/L Entry" temporary;
//         LEDim: Record "Dimension Set ID Filter Line";
//         NewLEDim: Record "Dimension Set ID Filter Line";
//         PDocDim: Record Table359;
//         TXT_ERROR_NONEWDIMS: Label 'No new Dimension Values exist for Sales Invoice %1!';
//         PDocDim2: Record Table359;
//         AView: Record "Analysis View";
//         IAView: Record "Item Analysis View";
//         xDimCode: Code[20];
//         Window: Dialog;
//         DimProgress: Integer;
//         DocProgress: Integer;
//         DimCount: Integer;
//         Operations: Integer;
//         DocCount: Integer;
//         DimIndicator: Integer;
//         DocIndicator: Integer;
//         TXT_CONFIRM_NEWDIMS: Label 'Apply new Dimension Value(s) for Sales Invoice %1?';
//         "FirstGLEntryNo.": Integer;
//         "FirstILEntryNo.": Integer;
//         LastAmount: Decimal;
//     begin
//         PDocDim.SETFILTER("Table ID", '%1|%2', DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line");
//         PDocDim.SETRANGE("Document No.", SInvHeader."No.");
//         PDocDim.SETFILTER("New Dimension Value Code", '<>''''');
//         IF NOT (PDocDim.FINDSET(TRUE, FALSE)) THEN
//             ERROR(TXT_ERROR_NONEWDIMS, SInvHeader."No.")
//         ELSE BEGIN

//             IF NOT (CONFIRM(TXT_CONFIRM_NEWDIMS, FALSE, SInvHeader."No.")) THEN
//                 EXIT;

//             "FirstGLEntryNo." := 0;
//             "FirstILEntryNo." := 0;

//             GLSetup.FINDFIRST();
//             SrcCodeSetup.FINDFIRST();

//             Operations := 4;
//             DimProgress := 0;
//             DimIndicator := 0;
//             DimCount := (PDocDim.COUNT * Operations);

//             Window.OPEN('Applying New Dimension Values...          \' +
//                         'Dimension Code:       #1##################\' +
//                         ' Dim. Progress:       @2@@@@@@@@@@@@@@@@@@\' +
//                         ' Doc. Progress:       @3@@@@@@@@@@@@@@@@@@',
//                         PDocDim."Dimension Code",
//                         DimIndicator,
//                         DocIndicator);

//             REPEAT

//                 Window.UPDATE(1);

//                 SInvLine.RESET;

//                 xDimCode := PDocDim."Dimension Value Code";
//                 PDocDim."Dimension Value Code" := PDocDim."New Dimension Value Code";
//                 PDocDim."New Dimension Value Code" := '';
//                 PDocDim.MODIFY;

//                 SInvLine.SETRANGE("Document No.", SInvHeader."No.");
//                 IF (PDocDim."Line No." <> 0) THEN
//                     SInvLine.SETRANGE("Line No.", PDocDim."Line No.");
//                 CASE (TRUE) OF
//                     (PDocDim."Dimension Code" = GLSetup."Global Dimension 1 Code"):
//                         BEGIN
//                             SInvLine.SETRANGE("Shortcut Dimension 1 Code", xDimCode);
//                             SInvLine.MODIFYALL("Shortcut Dimension 1 Code", PDocDim."Dimension Value Code");
//                         END;
//                     (PDocDim."Dimension Code" = GLSetup."Global Dimension 2 Code"):
//                         BEGIN
//                             SInvLine.SETRANGE("Shortcut Dimension 2 Code", xDimCode);
//                             SInvLine.MODIFYALL("Shortcut Dimension 2 Code", PDocDim."Dimension Value Code");
//                         END;
//                 END;

//                 DimProgress += 1;
//                 DimIndicator := ROUND((DimProgress / DimCount) * 10000, 1);
//                 Window.UPDATE(2);

//                 PDocDim2.SETRANGE("Table ID", DATABASE::"Sales Invoice Line");
//                 PDocDim2.SETRANGE("Document No.", SInvHeader."No.");
//                 PDocDim2.SETRANGE("Dimension Code", PDocDim."Dimension Code");
//                 PDocDim2.MODIFYALL("Dimension Value Code", PDocDim."Dimension Value Code");

//             UNTIL (PDocDim.NEXT = 0);

//             PDocDim.SETRANGE("New Dimension Value Code");

//             // Customer Ledger / General Ledger
//             PDocDim.SETRANGE("Line No.", 0);
//             IF (PDocDim.FINDSET(FALSE, FALSE)) THEN BEGIN

//                 LEDim.RESET;

//                 CLEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
//                 CLEntry.SETRANGE("Customer No.", SInvHeader."Bill-to Customer No.");
//                 CLEntry.SETRANGE("Document Type", CLEntry."Document Type"::Invoice);
//                 CLEntry.SETRANGE("Document No.", SInvHeader."No.");

//                 IF (CLEntry.FINDFIRST) THEN BEGIN

//                     LEDim.SETRANGE("Table ID", DATABASE::"Cust. Ledger Entry");
//                     LEDim.SETRANGE("Entry No.", CLEntry."Entry No.");

//                     REPEAT

//                         LEDim.SETRANGE("Dimension Code", PDocDim."Dimension Code");

//                         IF (LEDim.FINDFIRST) THEN BEGIN

//                             LEDim."Dimension Value Code" := PDocDim."Dimension Value Code";
//                             LEDim.MODIFY;

//                             CASE (TRUE) OF
//                                 (PDocDim."Dimension Code" = GLSetup."Global Dimension 1 Code"):
//                                     BEGIN
//                                         CLEntry."Global Dimension 1 Code" := PDocDim."Dimension Value Code";
//                                         CLEntry.MODIFY;
//                                     END;
//                                 (PDocDim."Dimension Code" = GLSetup."Global Dimension 2 Code"):
//                                     BEGIN
//                                         CLEntry."Global Dimension 2 Code" := PDocDim."Dimension Value Code";
//                                         CLEntry.MODIFY;
//                                     END;
//                             END;

//                         END;

//                         DimProgress += 1;
//                         DimIndicator := ROUND((DimProgress / DimCount) * 10000, 1);
//                         Window.UPDATE(2);

//                     UNTIL (PDocDim.NEXT = 0);

//                 END;

//             END;

//             // Item Ledger / Value Entry
//             PDocDim.SETFILTER("Line No.", '<>0');
//             IF (PDocDim.FINDSET(FALSE, FALSE)) THEN BEGIN

//                 TGLEntry.RESET;
//                 TGLEntry.DELETEALL;

//                 LEDim.RESET;

//                 SInvLine.RESET;

//                 REPEAT

//                     SInvLine.SETRANGE("Document No.", SInvHeader."No.");
//                     SInvLine.SETRANGE(Type, SInvLine.Type::Item);
//                     SInvLine.SETRANGE("Line No.", PDocDim."Line No.");
//                     IF (SInvLine.FINDFIRST) THEN BEGIN
//                         VEntry.SETCURRENTKEY("Item Ledger Entry No.", "Document No.", "Document Line No.");
//                         VEntry.SETRANGE("Document Type", VEntry."Document Type"::"Sales Invoice");
//                         VEntry.SETRANGE("Document No.", SInvLine."Document No.");
//                         VEntry.SETRANGE("Document Line No.", SInvLine."Line No.");
//                         IF (VEntry.FINDSET(FALSE, FALSE)) THEN
//                             REPEAT

//                                 LEDim.SETRANGE("Table ID", DATABASE::"Value Entry");
//                                 LEDim.SETRANGE("Entry No.", VEntry."Entry No.");
//                                 LEDim.SETRANGE("Dimension Code", PDocDim."Dimension Code");
//                                 IF (LEDim.FINDFIRST) THEN BEGIN
//                                     LEDim."Dimension Value Code" := PDocDim."Dimension Value Code";
//                                     LEDim.MODIFY;
//                                 END;

//                                 IF (ILEntry.GET(VEntry."Item Ledger Entry No.")) THEN BEGIN

//                                     IF ("FirstILEntryNo." = 0) THEN
//                                         "FirstILEntryNo." := ILEntry."Entry No.";

//                                     LEDim.SETRANGE("Table ID", DATABASE::"Item Ledger Entry");
//                                     LEDim.SETRANGE("Entry No.", ILEntry."Entry No.");
//                                     LEDim.SETRANGE("Dimension Code", PDocDim."Dimension Code");
//                                     IF (LEDim.FINDFIRST) THEN BEGIN
//                                         LEDim."Dimension Value Code" := PDocDim."Dimension Value Code";
//                                         LEDim.MODIFY;
//                                     END;
//                                 END;

//                                 // G/L Entry - Post Inventory Cost to G/L
//                                 GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
//                                 GLEntry.SETRANGE("Document No.", SInvLine."Document No.");
//                                 GLEntry.SETRANGE("Posting Date", SInvHeader."Posting Date");
//                                 GLEntry.SETRANGE("Source Code", SrcCodeSetup."Inventory Post Cost");
//                                 GLEntry.SETRANGE(Amount, VEntry."Cost Posted to G/L");

//                                 IF (GLEntry.FINDSET(FALSE, FALSE)) THEN
//                                     REPEAT

//                                         IF ("FirstGLEntryNo." = 0) THEN
//                                             "FirstGLEntryNo." := GLEntry."Entry No.";

//                                         IF NOT (TGLEntry.GET(GLEntry."Entry No.")) THEN BEGIN

//                                             LEDim.SETRANGE("Table ID", DATABASE::"G/L Entry");
//                                             LEDim.SETRANGE("Entry No.", GLEntry."Entry No.");
//                                             LEDim.SETRANGE("Dimension Code", PDocDim."Dimension Code");
//                                             IF (LEDim.FINDFIRST) THEN BEGIN
//                                                 LEDim."Dimension Value Code" := PDocDim."Dimension Value Code";
//                                                 LEDim.MODIFY;
//                                             END;

//                                             TGLEntry := GLEntry;
//                                             IF NOT (TGLEntry.INSERT) THEN;

//                                             GLEntry2 := GLEntry;
//                                             IF (GLEntry2.NEXT <> 0) THEN BEGIN
//                                                 LEDim.SETRANGE("Table ID", DATABASE::"G/L Entry");
//                                                 LEDim.SETRANGE("Entry No.", GLEntry2."Entry No.");
//                                                 LEDim.SETRANGE("Dimension Code", PDocDim."Dimension Code");
//                                                 IF (LEDim.FINDFIRST) THEN BEGIN
//                                                     LEDim."Dimension Value Code" := PDocDim."Dimension Value Code";
//                                                     LEDim.MODIFY;
//                                                 END;

//                                                 TGLEntry := GLEntry2;
//                                                 IF NOT (TGLEntry.INSERT) THEN;
//                                             END;

//                                         END;

//                                     UNTIL (GLEntry.NEXT = 0);

//                             UNTIL (VEntry.NEXT = 0);

//                     END;

//                     DimProgress += 1;
//                     DimIndicator := ROUND((DimProgress / DimCount) * 10000, 1);
//                     Window.UPDATE(2);

//                 UNTIL (PDocDim.NEXT = 0);

//             END;

//             GLEntry.RESET;

//             // G/L Entry - Gen. Posting Type Sale
//             IF (PDocDim.FINDSET(FALSE, FALSE)) THEN BEGIN
//                 GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
//                 GLEntry.SETRANGE("Document No.", SInvHeader."No.");
//                 GLEntry.SETRANGE("Posting Date", SInvHeader."Posting Date");
//                 GLEntry.SETRANGE("Gen. Posting Type", GLEntry."Gen. Posting Type"::Sale);
//                 IF (GLEntry.FINDSET(FALSE, FALSE)) THEN
//                     REPEAT

//                         LEDim.SETRANGE("Table ID", DATABASE::"G/L Entry");
//                         LEDim.SETRANGE("Entry No.", GLEntry."Entry No.");

//                         REPEAT

//                             LEDim.SETRANGE("Dimension Code", PDocDim."Dimension Code");
//                             IF (LEDim.FINDFIRST) THEN BEGIN
//                                 LEDim."Dimension Value Code" := PDocDim."Dimension Value Code";
//                                 LEDim.MODIFY;
//                             END;

//                             CASE (TRUE) OF
//                                 (PDocDim."Dimension Code" = GLSetup."Global Dimension 1 Code"):
//                                     BEGIN
//                                         GLEntry."Global Dimension 1 Code" := PDocDim."Dimension Value Code";
//                                         GLEntry.MODIFY;
//                                     END;
//                                 (PDocDim."Dimension Code" = GLSetup."Global Dimension 2 Code"):
//                                     BEGIN
//                                         GLEntry."Global Dimension 2 Code" := PDocDim."Dimension Value Code";
//                                         GLEntry.MODIFY;
//                                     END;
//                             END;

//                             DimProgress += 1;
//                             DimIndicator := ROUND((DimProgress / DimCount) * 10000, 1);
//                             Window.UPDATE(2);

//                         UNTIL (PDocDim.NEXT = 0);

//                     UNTIL (GLEntry.NEXT = 0);

//             END;

//             // Analysis Views
//             IF (AView.FINDSET(TRUE, FALSE)) THEN
//                 REPEAT
//                     AView."Last Entry No." := 0;
//                     AView.MODIFY;
//                     AView.AnalysisViewReset();
//                 UNTIL (AView.NEXT = 0);

//             IF (IAView.FINDSET(TRUE, FALSE)) THEN
//                 REPEAT
//                     IAView."Last Entry No." := 0;
//                     IAView.MODIFY;
//                     IAView.ItemAnalysisViewReset();
//                 UNTIL (IAView.NEXT = 0);

//         END;
//     end;

//     procedure ValidateRepBrands(SHeader: Record "Sales Header");
//     var
//         SLine: Record "Sales Line";
//         Salesperson: Record "Salesperson/Purchaser";
//         SPBrandAssign: Record "Salesperson Brand Auth.";
//         DefDim: Record "Default Dimension";
//         DocDim: Record Table357;
//         DimValue: Record "Dimension Value";
//         Item: Record Item;
//         TXT_BRAND: Label 'BRAND';
//         TXT_ERR_NOSP: Label '%1 %2 must reference a valid %3!';
//         TXT_ERR_NOBRANDASSIGN: Label '%1 %2 has no valid %3 record(s)!\\%3 is required for %1 %2.';
//         TXT_ERR_NOBRANLINE: Label '%1 %2 does not exist on %3 %4 %5!\\Item: %6 %7 %8\\%1 %2 is required on every Item line.';
//         TXT_ERR_NOBRAND: Label '%1 %2 is not assigned to %3 %4 (%5)!\\%6 is required for %1 %2.';
//         TXT_BadRep: Label 'Sales Rep %1 not Authorized for Brand %2 Item %3';
//         BrandAssign: Record "Salesperson Brand Auth.";
//         TempBrand: Record "Salesperson Brand Auth." temporary;
//     begin
//         // OPS046: Begin

//         IF NOT (Salesperson.GET(SHeader."Salesperson Code")) THEN
//             ERROR(TXT_ERR_NOSP,
//                   SHeader."Document Type",
//                   SHeader."No.",
//                   SHeader.FIELDCAPTION("Salesperson Code"));

//         SPBrandAssign.SETRANGE("Salesperson Code", Salesperson.Code);
//         IF NOT (SPBrandAssign.FINDFIRST) THEN
//             ERROR(TXT_ERR_NOBRANDASSIGN,
//                   SHeader.FIELDCAPTION("Salesperson Code"),
//                   SHeader."Salesperson Code",
//                   SPBrandAssign.TABLECAPTION);

//         DocDim.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Line No.", "Dimension Code");

//         SLine.SETRANGE(SLine."Document Type", SHeader."Document Type");
//         SLine.SETRANGE(SLine."Document No.", SHeader."No.");
//         SLine.SETRANGE(SLine.Type, SLine.Type::Item);
//         IF (SLine.FINDFIRST) THEN
//             REPEAT

//                 DocDim.SETRANGE("Table ID", DATABASE::"Sales Line");
//                 DocDim.SETRANGE("Document Type", SLine."Document Type");
//                 DocDim.SETRANGE("Document No.", SLine."Document No.");
//                 DocDim.SETRANGE("Line No.", SLine."Line No.");
//                 DocDim.SETFILTER("Dimension Code", TXT_BRAND);
//                 IF NOT (DocDim.FINDFIRST) THEN BEGIN

//                     ERROR(TXT_ERR_NOBRANLINE,
//                           TXT_BRAND,
//                           DocDim.TABLECAPTION,
//                           SLine.TABLECAPTION,
//                           SLine.FIELDCAPTION("Line No."),
//                           SLine."Line No.",
//                           SLine."No.",
//                           SLine."Color Code",
//                           SLine."Size Code");

//                 END ELSE BEGIN

//                     BrandAssign.SETRANGE("Salesperson Code", SHeader."Salesperson Code");
//                     BrandAssign.SETRANGE("Brand Dimension Code", DocDim."Dimension Code");
//                     BrandAssign.SETRANGE("Brand Dimension Value", DocDim."Dimension Value Code");
//                     IF NOT (BrandAssign.FINDFIRST) THEN
//                         ERROR(TXT_ERR_NOBRAND,
//                               TXT_BRAND,
//                               DocDim."Dimension Value Code",
//                               SHeader.FIELDCAPTION("Salesperson Code"),
//                               SHeader."Salesperson Code",
//                               Salesperson.Name,
//                               BrandAssign.TABLECAPTION);

//                 END;
//             UNTIL (SLine.NEXT = 0);

//         // OPS046: End
//     end;

//     procedure ExecuteObject();
//     var
//         _text00001: Label 'Parameter for ExecuteObject function ''%1'' is invalid.';
//         _exportItemAvail: Report Report50048;
//     begin
//         //BFC006 -
//         CASE Parameter OF
//             'ITEMAVAILEXP':
//                 BEGIN
//                     CLEAR(_exportItemAvail);
//                     _exportItemAvail.USEREQUESTFORM(FALSE);
//                     _exportItemAvail.SetParameters(FilterPdStart, FilterPdEnd, FilterLocation, ExportBrandGrp, ExportFileName, TRUE);
//                     _exportItemAvail.RUNMODAL;
//                 END;
//             ELSE
//                 ERROR(_text00001, Parameter);
//         END;
//         //BFC006 +
//     end;

//     procedure SetItemAvailExpParams(_filterPdStart: Date; _filterPdEnd: Date; _filterLocation: Text[1024]; _exportBrandGrp: Code[20]; _exportFileName: Text[250]; _parameter: Code[20]);
//     var
//         _text00001: Label '0123456789';
//     begin
//         //BFC006 -
//         FilterPdStart := _filterPdStart;
//         FilterPdEnd := _filterPdEnd;
//         FilterLocation := _filterLocation;
//         ExportBrandGrp := _exportBrandGrp;
//         ExportFileName := _exportFileName;
//         Parameter := _parameter;
//         //BFC006 +
//     end;
// }

