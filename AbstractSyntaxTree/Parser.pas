UNIT Parser;

INTERFACE

(*
* Parses the input and calculates the arithmetic value if the parsing was successful.
* IN input: string with operators and operands.
* OUT value: calculated value. Undefined if Parse returns false.
* RETURN: true if input string was a valid arithmetic string else false.
*)
FUNCTION Parse(input: STRING; VAR value: INTEGER): BOOLEAN;

IMPLEMENTATION

USES Scanner, AST, sysutils;

VAR
    success: BOOLEAN;

PROCEDURE Expr(var e: NodePtr); FORWARD;
PROCEDURE Term(var t: NodePtr); FORWARD;
PROCEDURE Fact(var f: NodePtr); FORWARD;


PROCEDURE Fact(var f: NodePtr);
BEGIN
    CASE CurrentSymbol OF
        numberSym: BEGIN
            f := CreateNode(NIL, IntToStr(CurrentNumberValue), NIL);
            GetNextSymbol;
        END;
            leftParSym: BEGIN
            GetNextSymbol;
            Expr(f); IF NOT success THEN Exit;
            IF CurrentSymbol <> rightParSym THEN BEGIN success := FALSE; Exit; END;
            GetNextSymbol;
        END;
        ELSE BEGIN success := FALSE; Exit; END;
    END;
END;

PROCEDURE Term(var t: NodePtr);
VAR
    temp: NodePtr;
BEGIN
    Fact(t); IF NOT success THEN Exit;
    WHILE (CurrentSymbol = multSym) OR (CurrentSymbol = divSym) DO BEGIN
        CASE CurrentSymbol OF
            multSym: BEGIN
                GetNextSymbol;
                Fact(temp); IF NOT success THEN Exit;
                t := CreateNode(t, '*', temp);
            END;
            divSym: BEGIN
                GetNextSymbol;
                Fact(temp); IF NOT success THEN Exit;
                t := CreateNode(t, '/', temp);
            END;
        END;
    END;
END;

PROCEDURE Expr(var e: NodePtr);
VAR
    temp: NodePtr;
BEGIN
    Term(e); IF NOT success THEN Exit;
    WHILE (CurrentSymbol = plusSym) OR (CurrentSymbol = minusSym) DO BEGIN
        CASE CurrentSymbol OF
            plusSym: BEGIN
                GetNextSymbol;
                Term(temp); IF NOT success THEN Exit;
                e := CreateNode(e, '+', temp);
            END;
            minusSym: BEGIN
                GetNextSymbol;
                Term(temp); IF NOT success THEN Exit;
                e := CreateNode(e, '-', temp);
            END;
        END;
    END;
END;

FUNCTION Parse(input: STRING; VAR value: INTEGER): BOOLEAN;
VAR
    root: NodePtr;
BEGIN
    root := NIL;
    InitScanner(input);
    success := TRUE;
    Expr(root);
    Parse := success;

    IF success THEN BEGIN
        Print(root);
        value := ValueOf(root);
    END;
END;

BEGIN
END.