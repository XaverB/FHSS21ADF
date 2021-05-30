PROGRAM CCTScannerTest;

USES CCTScanner;

VAR
    inputFile: TEXT;

BEGIN
    Assign(inputFile, ParamStr(1));
    Reset(inputFIle);

    InitScanner(inputFile);
    WHILE CurrentSymbol <> eofSym DO BEGIN
        Writeln(CurrentSymbol);
        IF CurrentSymbol = numberSym THEN
            Writeln(CurrentNumberValue);
        GetNextSymbol;
    END;
END.