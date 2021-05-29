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
CONST
	Tab = Chr(9);
	LF = Chr(10);
	CR = Chr(13);
	Blank = ' ';

VAR
	inpFile: TEXT;
	curChar: CHAR;
	charLine, charColumn: INTEGER;

	curSymbol: Symbol;
	symbolLine, symbolColumn: INTEGER;

	curNumberValue: INTEGER;
	curIdentName: STRING;

PROCEDURE GetNextChar;
BEGIN
	Read(inpFile, curChar);
	(* handle new line *)
	IF (curChar = CR) OR (curChar = LF) THEN BEGIN
		(* REMARK: line count like this is not correct when file has CR line separators (which should not be a problem nowadays) *)
		IF curChar = LF THEN
			Inc(charLine);
		charColumn := 0;
	END ELSE
		Inc(charColumn);
END;

PROCEDURE InitScanner(VAR inputFile: TEXT);
BEGIN
	inpFile := inputFile;
	charLine := 1;
	charColumn := 0;
	GetNextChar;
	GetNextSymbol;
END;

PROCEDURE GetNextSymbol;
VAR
	temp: STRING;
BEGIN
	(* skip whitespace *)
	WHILE (curChar = Blank) OR (curChar = Tab) OR (curChar = CR) OR (curChar = LF) DO
		GetNextChar;
	(* parse next symbol *)
	symbolLine := charLine;
	symbolColumn := charColumn;
	CASE curChar OF
		'+': BEGIN curSymbol := plusSym; GetNextChar; END;
		'-': BEGIN curSymbol := minusSym; GetNextChar; END;
		'*': BEGIN curSymbol := multSym; GetNextChar; END;
		'/': BEGIN curSymbol := divSym; GetNextChar; END;
		'(': BEGIN curSymbol := leftParSym; GetNextChar; END;
		')': BEGIN curSymbol := rightParSym; GetNextChar; END;
		'.': BEGIN curSymbol := periodSym; GetNextChar; END;
		',': BEGIN curSymbol := commaSym; GetNextChar; END;
		';': BEGIN curSymbol := semicolonSym; GetNextChar; END;
		':': BEGIN
			GetNextChar;
			IF curChar = '=' THEN BEGIN
				curSymbol := assignSym;
				GetNextChar;
			END ELSE
				curSymbol := colonSym;
		END;
		'a'..'z', 'A'..'Z', '_': BEGIN
			temp := '';
			WHILE curChar IN ['a'..'z', 'A'..'Z', '0'..'9', '_'] DO BEGIN
				temp := temp + UpCase(curChar);
				GetNextChar;
			END;
			IF temp = 'BEGIN' THEN
				curSymbol := beginSym
			ELSE IF temp = 'END' THEN
				curSymbol := endSym
			ELSE IF temp = 'INTEGER' THEN
				curSymbol := integerSym
			ELSE IF temp = 'PROGRAM' THEN
				curSymbol := programSym
			ELSE IF temp = 'READ' THEN
				curSymbol := readSym
			ELSE IF temp = 'VAR' THEN
				curSymbol := varSym
			ELSE IF temp = 'WRITE' THEN
				curSymbol := writeSym
			ELSE BEGIN
				curSymbol := identSym;
				curIdentName := temp;
			END;
		END;
		'0'..'9': BEGIN
			curSymbol := numberSym;
			curNumberValue := 0;
			WHILE curChar IN ['0'..'9'] DO BEGIN
				curNumberValue := (curNumberValue * 10) + (Ord(curChar) - Ord('0'));
				GetNextChar;
			END;
		END;
		ELSE BEGIN curSymbol := noSym; GetNextChar; END;
	END;
END;

FUNCTION CurrentSymbol: Symbol;
BEGIN
	CurrentSymbol := curSymbol;
END;

FUNCTION CurrentNumberValue: INTEGER;
BEGIN
	CurrentNumberValue := curNumberValue;
END;

FUNCTION CurrentIdentName: STRING;
BEGIN
	CurrentIdentName := curIdentName;
END;

END.