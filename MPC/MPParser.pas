UNIT MPParser;

INTERFACE

PROCEDURE Parse(VAR inputFile: TEXT; VAR ok: BOOLEAN);

IMPLEMENTATION

USES MPScanner;

VAR
    success: BOOLEAN;

PROCEDURE MP(VAR outFile: File); FORWARD;
PROCEDURE VarDecl; FORWARD;
PROCEDURE StatSeq; FORWARD;
PROCEDURE Stat; FORWARD;
PROCEDURE Expr; FORWARD;
PROCEDURE Term; FORWARD;
PROCEDURE Fact; FORWARD;


PROCEDURE Parse(var inputFile: TEXT; VAR ok: BOOLEAN);
BEGIN
    InitScanner(inputFile);
    success := TRUE;
    MP;
    ok := success;

END;

PROCEDURE MP(VAR outFile: File);
BEGIN
    IF currentSymbol <> programSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;
   
   IF currentSymbol <> identSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;

    IF currentSymbol <> semicolonSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;
   
    IF currentSymbol = varSym THEN BEGIN; // optional nonterminal
    VarDecl; IF NOT success THEN Exit;
    END;

    IF currentSymbol <> beginSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;

    StatSeq; IF NOT success THEN Exit;

    IF currentSymbol <> endSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;

    IF currentSymbol <> periodSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;
END;

PROCEDURE VarDecl;
BEGIN

    IF currentSymbol <> varSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;

    IF currentSymbol <> identSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;
    WHILE currentSymbol = commaSym DO BEGIN // 1 oder mehrmals
       GetNextSymbol;
       IF currentSymbol <> identSym THEN BEGIN success := FALSE; Exit; End;
       GetNextSymbol;
    END;

   IF currentSymbol <> colonSym THEN BEGIN success := FALSE; Exit; End;
    GetNextSymbol;

   IF currentSymbol <> integerSym THEN BEGIN success := FALSE; Exit; End;
   GetNextSymbol;

   IF currentSymbol <> semicolonSym THEN BEGIN success := FALSE; Exit; End;
   GetNextSymbol;

END;

PROCEDURE StatSeq;
BEGIN
  Stat; IF NOT success THEN Exit;
  WHILE currentSymbol = semicolonSym DO BEGIN
     GetNextSymbol;
     Stat; IF NOT success THEN Exit;
  END;
END;

PROCEDURE Stat;
BEGIN
    CASE currentSymbol OF 
         identSym: BEGIN
              GetNextSymbol;
              IF currentSymbol <> assignSym THEN BEGIN success := FALSE; Exit; End;
              GetNextSymbol;
              Expr; IF NOT success THEN Exit;

         END;
         readSym: BEGIN
            GetNextSymbol;
            IF currentSymbol <> leftParSym THEN BEGIN success := FALSE; Exit; End;
            GetNextSymbol;

            IF currentSymbol <> identSym THEN BEGIN success := FALSE; Exit; End;
              GetNextSymbol;

              IF currentSymbol <> rightParSym THEN BEGIN success := FALSE; Exit; End;
              GetNextSymbol;
            
         END;
         writeSym: BEGIN
           GetNextSymbol;
            IF currentSymbol <> leftParSym THEN BEGIN success := FALSE; Exit; End;
            GetNextSymbol;

            Expr; IF NOT success THEN Exit;

            IF currentSymbol <> rightParSym THEN BEGIN success := FALSE; Exit; End;
            GetNextSymbol;
         END;
    END;
END;

PROCEDURE Fact;
BEGIN
    CASE CurrentSymbol OF
        identSym: BEGIN
            GetNextSymbol;
        END;
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

BEGIN
END.