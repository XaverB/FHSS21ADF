UNIT Scanner;

INTERFACE

TYPE
    (* Symbol scanned by scanner *)
    Symbol = (
        unknownSym,
        plusSym, minusSym, multSym, divSym, leftParSym, rightParSym,
        numberSym
    );


(* Initializes the scanner with a new input *)
(* IN input: Text of arithmetic expression to scan. *)
(* Automatically scans the first symbol. *)
PROCEDURE InitScanner(input: STRING);

(* Advances to the next symbol. *)
PROCEDURE GetNextSymbol;

(* Get the current symbol = last symbol that has been scanned. *)
(* RETURNS The last scanned symbol. *)
FUNCTION CurrentSymbol: Symbol;

(* Gets the value of of a scanned number symbol *)
(* RETURNS Value of scanned nunmber symbol. *)
(* Value is only valid when current symbol is a number symbol, otherwise undefined *)
FUNCTION CurrentNumberValue: LONGINT;


IMPLEMENTATION

    CONST
        InvalidChar = Chr(0);


    VAR
        inp: STRING;
        pos: INTEGER;
        curChar: CHAR;
        curSymbol: Symbol;
        curNumberValue: LONGINT;

PROCEDURE GetNextChar;
BEGIN
    IF pos < Length(inp) THEN BEGIN
        pos := pos + 1;
        curChar := inp[pos];
    END ELSE
        curChar := InvalidChar;
END;

PROCEDURE InitScanner(input: STRING);
BEGIN
    inp := input;
    pos := 0;
    GetNextChar;
    GetNextSymbol;
END;

PROCEDURE GetNextSymbol;
BEGIN
    (* remove whitespace *)
    WHILE curChar = ' ' DO 
        GetNextChar;
    (* scan symbol *)
    CASE curChar OF
        '+': BEGIN curSymbol := plusSym; GetNextChar; END;
        '-': BEGIN curSymbol := minusSym; GetNextChar; END;
        '*': BEGIN curSymbol := multSym; GetNextChar; END;
        '/': BEGIN curSymbol := divSym; GetNextChar; END;
        '(': BEGIN curSymbol := leftParSym; GetNextChar; END;
        ')': BEGIN curSymbol := rightParSym; GetNextChar; END;
        '0'..'9': BEGIN
            curSymbol := numberSym;
            curNumberValue := 0;
            WHILE curChar IN ['0'..'9'] DO BEGIN
                curNumberValue := curNumberValue * 10 + (Ord(curChar) - Ord('0')); // horner schema magic
                GetNextChar;
            END;
        END;
        // TODO number
        ELSE BEGIN curSymbol := unknownSym; GetNextChar; END;
    END;
END;


FUNCTION CurrentSymbol: Symbol;
BEGIN
    CurrentSymbol := curSymbol;
END;

FUNCTION CurrentNumberValue: LONGINT;
BEGIN
    CurrentNumberValue := curNumberValue;
END;

BEGIN
    InitScanner('');
END.
