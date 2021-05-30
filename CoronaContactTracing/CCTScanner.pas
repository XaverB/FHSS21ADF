UNIT CCTScanner;

INTERFACE

TYPE
    Symbol = (noSym,
        minSym,
        mSym, cmSym, 
        numberSym, 
        wildcardSym, 
        semicolonSym, 
        coloSym,
        dotSym, 
        idSym,
        eofSym
    );

PROCEDURE InitScanner(var inputFile: TEXT);

PROCEDURE GetNextSymbol;
FUNCTION CurrentSymbol: Symbol;

FUNCTION CurrentNumberValue: INTEGER;

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
	currentId: INTEGER;

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
		'*': BEGIN curSymbol := wildcardSym; GetNextChar; END;
		';': BEGIN curSymbol := semicolonSym; GetNextChar; END;
		'.': BEGIN curSymbol := eofSym; GetNextChar; END;
		'a'..'z': BEGIN
			temp := '';
			WHILE curChar IN ['a'..'z'] DO BEGIN
				temp := temp + curChar;
				GetNextChar;
			END;
			IF temp = 'min' THEN
				curSymbol := minSym
			ELSE IF temp = 'cm' THEN
				curSymbol := cmSym
            ELSE IF temp = 'm' THEN
				curSymbol := mSym
		END;
		'0'..'9': BEGIN
            curSymbol := numberSym;
			curNumberValue := 0;
			WHILE curChar IN ['0'..'9'] DO BEGIN
				curNumberValue := (curNumberValue * 10) + (Ord(curChar) - Ord('0'));
				GetNextChar;
                IF curChar = ':' THEN BEGIN
                    curSymbol := idSym;
                    currentId := curNumberValue;
                END;
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

BEGIN
END.