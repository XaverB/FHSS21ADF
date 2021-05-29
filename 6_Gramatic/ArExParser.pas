UNIT ArExParser;

INTERFACE

FUNCTION Parse(input: STRING): BOOLEAN;

IMPLEMENTATION

USES ArExScanner;

VAR
    success: BOOLEAN;

PROCEDURE Expr; FORWARD;
PROCEDURE Term; FORWARD;
PROCEDURE Fact; FORWARD;


PROCEDURE Fact;
BEGIN
    CASE CurrentSymbol OF
        numberSym: BEGIN
            GetNextSymbol;
        END;
        leftParSym: BEGIN
            GetNextSymbol;
            Expr; IF NOT success THEN Exit;
            IF CurrentSymbol <> rightParSym THEN BEGIN success := FALSE; Exit; END;
            GetNextSymbol;
        END;
        ELSE BEGIN success := FALSE; Exit; END;
    END;
END;

PROCEDURE Term;
BEGIN
 Fact; IF NOT success THEN Exit;
    WHILE (CurrentSymbol = multSym) OR (CurrentSymbol = divSym) DO BEGIN
        CASE CurrentSymbol OF
            multSym: BEGIN
                GetNextSymbol;
                Fact; IF NOT success THEN Exit;
            END;
            divSym: BEGIN
                GetNextSymbol;
                Fact; IF NOT success THEN Exit;
            END;
        END;
    END;
END;

PROCEDURE Expr;
BEGIN
    Term; IF NOT success THEN Exit;
    WHILE (CurrentSymbol = plusSym) OR (CurrentSymbol = minusSym) DO BEGIN
        CASE CurrentSymbol OF
            plusSym: BEGIN
                GetNextSymbol;
                Term; IF NOT success THEN Exit;
            END;
            minusSym: BEGIN
                GetNextSymbol;
                Term; IF NOT success THEN Exit;
            END;
        END;
    END;
END;

FUNCTION Parse(input: STRING): BOOLEAN;
BEGIN
    InitScanner(input);
    success := TRUE;
    Expr;
    Parse := success;
END;


BEGIN

END.