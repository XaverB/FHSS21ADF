UNIT CCTParser;

INTERFACE

PROCEDURE Parse(var inputFile: TEXT; VAR ok: BOOLEAN; VAR count: INTEGER);

IMPLEMENTATION

USES CCTScanner, sysutils;

VAR
    success: BOOLEAN;

PROCEDURE List(VAR count: INTEGER); FORWARD;
PROCEDURE Entry(VAR isDangerous: BOOLEAN); FORWARD;
PROCEDURE Duration(VAR duration: INTEGER); FORWARD;
PROCEDURE Distance(VAR distance: INTEGER); FORWARD;


PROCEDURE Parse(var inputFile: TEXT; VAR ok: BOOLEAN; VAR count: INTEGER);
BEGIN
    InitScanner(inputFile);
    success := TRUE;
    List(count);
    ok := success;
END;

PROCEDURE List(VAR count: INTEGER);
VAR 
    isDangerous: BOOLEAN;
BEGIN
    {sem} count := 0; {sem}

    WHILE currentSymbol = idSym DO BEGIN
        GetNextSymbol;
        Entry(isDangerous); IF NOT success THEN Exit;
        {sem} IF isDangerous THEN Inc(count); {sem}

        IF currentSymbol <> eofSym THEN
            GetNextSymbol;
    END;

    IF currentSymbol <> eofSym THEN BEGIN success := FALSE; Exit; End;
END;

PROCEDURE Entry(VAR isDangerous: BOOLEAN);
VAR
    dur: INTEGER;
    dis: INTEGER;
BEGIN
    dur := 0;
    dis := 0;

    Duration(dur); IF NOT success THEN Exit;

    Distance(dis); IF NOT success THEN Exit;
    {sem} IF (dis <= 200) AND (dur >= 15) THEN isDangerous := true ELSE isDangerous := false; {sem}

    IF (currentSymbol <> semicolonSym) AND (currentSymbol <> eofSym) THEN BEGIN success := FALSE; Exit; End;
END;

PROCEDURE Duration(VAR duration: INTEGER);
BEGIN
    GetNextSymbol;
    IF currentSymbol <> numberSym THEN BEGIN success := FALSE; Exit; End;
    {sem} duration := CurrentNumberValue; {sem}

    GetNextSymbol;

    IF currentSymbol <> minSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;
END;

PROCEDURE Distance(VAR distance: INTEGER);
BEGIN
    CASE currentSymbol OF 
         numberSym: BEGIN
              distance := CurrentNumberValue;
              GetNextSymbol;
              CASE currentSymbol OF
                cmSym: BEGIN
                    GetNextSymbol;
                END;
                mSym: BEGIN
                    {sem} distance := distance * 100; {sem}
                    GetNextSymbol;
                END;
              ELSE BEGIN success := FALSE; Exit; End;
              END;
         END;
         wildcardSym: BEGIN
            {sem} distance := 10000; {sem}
            GetNextSymbol;
         END;
        ELSE BEGIN success := FALSE; Exit; End;
    END;
END;

BEGIN
END.