PROGRAM ScannerTest;

USES Scanner;

BEGIN
    InitScanner(ParamStr(1));
    WHILE CurrentSymbol <> unknownSym DO BEGIN
        Writeln(CurrentSymbol);
        IF CurrentSymbol = numberSym THEN
            Writeln(CurrentNumberValue);
        GetNextSymbol;
    END;
END.