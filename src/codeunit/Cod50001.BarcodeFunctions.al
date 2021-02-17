codeunit 50001 "Barcode Functions"
{
    // version OPSBLO


    trigger OnRun();
    var
        charvar: Char;
    begin
        MESSAGE(GenerateUPCa('790740123540'));
    end;

    procedure GenerateUPCa(DataToEncode: Text[30]) OutString: Text[30];
    var
        DataToPrint: Text[30];
        OnlyCorrectData: Text[30];
        StringLength: Integer;
        CurrentCharNum: Char;
        CurrentCharVal: Integer;
        Factor: Integer;
        WeightedTotal: Integer;
        i: Integer;
        CheckDigit: Integer;
        TempChar: Char;
        CurrentCheckChar: Integer;
    begin
        DataToPrint := '';
        OnlyCorrectData := '';
        //Check to make sure data is numeric and remove dashes, etc.
        StringLength := STRLEN(DataToEncode);

        //ensure all numeric values
        //For I = 1 To StringLength
        i := 0;
        while i < StringLength do begin
            i += 1;
            //If IsNumeric(Mid(DataToEncode, I, 1)) Then OnlyCorrectData = OnlyCorrectData & Mid(DataToEncode, I, 1)
            CurrentCharNum := DataToEncode[i] + 0;
            if (CurrentCharNum > 47) and (CurrentCharNum < 58) then
                OnlyCorrectData := OnlyCorrectData + FORMAT(DataToEncode[i]);
        end;

        StringLength := STRLEN(OnlyCorrectData);
        //'Remove check digits if they added one
        if StringLength < 11 then OnlyCorrectData := '00000000000';
        if StringLength = 15 then OnlyCorrectData := '00000000000';
        if StringLength > 18 then OnlyCorrectData := '00000000000';
        if StringLength = 12 then OnlyCorrectData := COPYSTR(OnlyCorrectData, 1, 11);
        if StringLength = 14 then OnlyCorrectData := COPYSTR(OnlyCorrectData, 1, 11) + COPYSTR(OnlyCorrectData, 13, 2);
        if StringLength = 17 then OnlyCorrectData := COPYSTR(OnlyCorrectData, 1, 11) + COPYSTR(OnlyCorrectData, 13, 5);

        StringLength := STRLEN(OnlyCorrectData);

        DataToEncode := COPYSTR(OnlyCorrectData, 1, 11);

        //<<<< Calculate Check Digit >>>>
        Factor := 3;
        WeightedTotal := 0;
        i := STRLEN(DataToEncode);
        //For I = Len(DataToEncode) To 1 Step -1
        while i > 0 do begin
            //Get the value of each number starting at the end
            CurrentCharNum := DataToEncode[i];
            if not EVALUATE(CurrentCheckChar, FORMAT(CurrentCharNum)) then begin end;
            //multiply by the weighting factor which is 3,1,3,1...
            //and add the sum together
            WeightedTotal += CurrentCheckChar * Factor;
            //      WeightedTotal += CurrentCharNum * Factor;
            //change factor for next calculation
            Factor := 4 - Factor;
            i -= 1;
        end;

        //Find the CheckDigit by finding the number + WeightedTotal that = a multiple of 10
        //Divide by 10, get the remainder and subtract from 10
        i := (WeightedTotal mod 10);
        if i <> 0 then
            CheckDigit := (10 - i)
        else
            CheckDigit := 0;

        DataToEncode := DataToEncode + FORMAT(CheckDigit);

        //Now that have the total number including the check digit, determine character to print
        //for proper barcoding
        i := 0;
        StringLength := STRLEN(DataToEncode);
        while i < StringLength do begin
            i += 1;
            //Get the ASCII value of each number
            CurrentCharNum := DataToEncode[i];
            CurrentCharVal := DataToEncode[i] + 0;
            //Print different barcodes according to the location of the CurrentChar
            case i of
                1:
                    begin
                        //For the first character, print the human readable character, the normal
                        //guard pattern, and then the barcode without the human readable character
                        if (CurrentCharVal - 48) > 4 then begin
                            TempChar := CurrentCharNum + 64;
                            DataToPrint := DataToPrint + FORMAT(TempChar) + '(';
                            TempChar := CurrentCharNum + 49;
                            DataToPrint := DataToPrint + FORMAT(TempChar);
                        end;
                        if (CurrentCharVal - 48) < 5 then begin
                            TempChar := CurrentCharNum + 37;
                            DataToPrint := DataToPrint + FORMAT(TempChar) + '(';
                            TempChar := CurrentCharNum + 49;
                            DataToPrint := DataToPrint + FORMAT(TempChar);
                        end;
                    end;
                2:
                    DataToPrint := DataToPrint + FORMAT(CurrentCharNum);
                3:
                    DataToPrint := DataToPrint + FORMAT(CurrentCharNum);
                4:
                    DataToPrint := DataToPrint + FORMAT(CurrentCharNum);
                5:
                    DataToPrint := DataToPrint + FORMAT(CurrentCharNum);
                6:
                    //Print the center guard pattern after the 6th character
                    DataToPrint := DataToPrint + FORMAT(CurrentCharNum) + '*';
                7:
                    //Add 27 to the ASII value of characters 6-12 to print from character set C
                    //This is required when printing to the right of the center guard pattern
                    begin
                        TempChar := CurrentCharNum + 27;
                        DataToPrint := DataToPrint + FORMAT(TempChar);
                    end;
                8:
                    begin
                        TempChar := CurrentCharNum + 27;
                        DataToPrint := DataToPrint + FORMAT(TempChar);
                    end;
                9:
                    begin
                        TempChar := CurrentCharNum + 27;
                        DataToPrint := DataToPrint + FORMAT(TempChar);
                    end;
                10:
                    begin
                        TempChar := CurrentCharNum + 27;
                        DataToPrint := DataToPrint + FORMAT(TempChar);
                    end;
                11:
                    begin
                        TempChar := CurrentCharNum + 27;
                        DataToPrint := DataToPrint + FORMAT(TempChar);
                    end;
                12:
                    //For the last character, print the barcode without the human readable character,
                    //the normal guard pattern, and then the human readable character.
                    begin
                        if (CurrentCharVal - 48) > 4 then begin
                            TempChar := CurrentCharNum + 59;
                            DataToPrint := DataToPrint + FORMAT(TempChar) + '(';
                            TempChar := CurrentCharNum + 64;
                            DataToPrint := DataToPrint + FORMAT(TempChar);
                        end;
                        if (CurrentCharVal - 48) < 5 then begin
                            TempChar := CurrentCharNum + 59;
                            DataToPrint := DataToPrint + FORMAT(TempChar) + '(';
                            TempChar := CurrentCharNum + 37;
                            DataToPrint := DataToPrint + FORMAT(TempChar);
                        end;
                    end;
            end;
        end;
        exit(DataToPrint);
    end;
}

