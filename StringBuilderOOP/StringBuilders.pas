UNIT StringBuilders;

INTERFACE

CONST
    tab = Char(9);

TYPE
    StringBuilder = OBJECT
        CONSTRUCTOR Init;

        PROCEDURE AppendStr(e: STRING); VIRTUAL;

        PROCEDURE AppendChar(e: CHAR); VIRTUAL;

        PROCEDURE AppendInt(e: INTEGER); VIRTUAL;

        PROCEDURE AppendBool(e: BOOLEAN); VIRTUAL;

        FUNCTION AsString: STRING;

        PRIVATE 
            buffer: STRING;
    END;

    TabStringBuilder = OBJECT(StringBuilder)
        CONSTRUCTOR Init(spacesCount: INTEGER);

        PROCEDURE AppendStr(e: STRING); VIRTUAL;

        PROCEDURE AppendChar(e: CHAR); VIRTUAL;

        PROCEDURE AppendInt(e: INTEGER); VIRTUAL;

        PROCEDURE AppendBool(e: BOOLEAN); VIRTUAL;

        PRIVATE
            spaces: INTEGER;
            isEmpty: BOOLEAN;
            PROCEDURE AddTabs;
    END;

    StringJoiner2 = OBJECT(StringBuilder)
        CONSTRUCTOR Init(delimiter: CHAR);
        
        PROCEDURE Add(e: STRING); VIRTUAL;

        PRIVATE
            delimiter: CHAR;
            isEmpty: BOOLEAN;
    END;

IMPLEMENTATION

USES sysutils;

// ---------------------------------
// StringBuilder Implementation
// ---------------------------------

CONSTRUCTOR StringBuilder.Init;
BEGIN
    SELF.buffer := '';
END;

PROCEDURE StringBuilder.AppendStr(e: STRING);
BEGIN
    SELF.buffer := SELF.buffer + e;
END;

PROCEDURE StringBuilder.AppendChar(e: CHAR);
BEGIN
    SELF.buffer := SELF.buffer + e;
END;

PROCEDURE StringBuilder.AppendInt(e: INTEGER);
BEGIN
    SELF.buffer := SELF.buffer + IntToStr(e);
END;

PROCEDURE StringBuilder.AppendBool(e: BOOLEAN);
BEGIN
    IF e THEN 
        SELF.buffer := SELF.buffer + 'true'
    ELSE
        SELF.buffer := SELF.buffer + 'false'
END;

FUNCTION StringBuilder.AsString: STRING;
BEGIN
    AsString := buffer;
END;

// ---------------------------------
// TabStringBuilder Implementation
// ---------------------------------

CONSTRUCTOR TabStringBuilder.Init(spacesCount: INTEGER);
BEGIN
    SELF.isEmpty := true;
END;

PROCEDURE TabStringBuilder.AppendStr(e: STRING);
BEGIN
    IF SELF.isEmpty = FALSE THEN
        SELF.AddTabs;

    Inherited AppendStr(e);
    
    SELF.isEmpty := false;
END;

PROCEDURE TabStringBuilder.AppendChar(e: CHAR);
BEGIN
    IF SELF.isEmpty = FALSE THEN
        SELF.AddTabs;

    Inherited AppendChar(e);
    
    SELF.isEmpty := false;
END;

PROCEDURE TabStringBuilder.AppendInt(e: INTEGER);
BEGIN
    IF SELF.isEmpty = FALSE THEN
        SELF.AddTabs;

    Inherited AppendInt(e);
    
    SELF.isEmpty := false;
END;

PROCEDURE TabStringBuilder.AppendBool(e: BOOLEAN);
BEGIN
    IF SELF.isEmpty = FALSE THEN
        SELF.AddTabs;

    Inherited AppendBool(e);
    
    SELF.isEmpty := false;
END;

PROCEDURE TabStringBuilder.AddTabs;
VAR
    i: INTEGER;
BEGIN
    FOR i := 0 TO SELF.spaces DO BEGIN
        inherited AppendChar(tab);
    END;
END;

// ---------------------------------
// StringJoiner2 Implementation
// ---------------------------------

CONSTRUCTOR StringJoiner2.Init(delimiter: CHAR);
BEGIN
    SELF.delimiter := delimiter;
    SELF.isEmpty := true;
END;

PROCEDURE StringJoiner2.Add(e: STRING);
BEGIN
    IF SELF.isEmpty = FALSE THEN
        Inherited AppendChar(SELF.delimiter);
    
    Inherited AppendStr(e);
    SELF.isEmpty := FALSE;
END;

BEGIN
END.