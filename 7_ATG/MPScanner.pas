UNIT MPScanner;

INTERFACE

TYPE
    Symbol = (noSym,
        beginSym, endSym, integerSym, programSym, readSym, varSym, writeSym, 
        plusSym, minusSym, multSym, divSym, leftParSym, rightParSym,
        commaSym, colonSym, assignSym, semicolonSym, periodSym,
        identSym, numberSym
    );

PROCEDURE InitScanner(var inputFile: TEXT);

PROCEDURE GetNextSymbol;
FUNCTION CurrentSymbol: Symbol;

FUNCTION CurrentNumberValue: INTEGER;
FUNCTION CurrentIdentName: STRING;

IMPLEMENTATION

PROCEDURE InitScanner(var inputFile: TEXT);
BEGIN
END;

PROCEDURE GetNextSymbol;
BEGIN
END;

FUNCTION CurrentSymbol: Symbol;
BEGIN
END;

FUNCTION CurrentNumberValue: INTEGER;
BEGIN
END;

FUNCTION CurrentIdentName: STRING;
BEGIN
END;


END.