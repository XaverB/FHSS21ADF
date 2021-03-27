PROGRAM Foo;

VAR
    i: INTEGER;

BEGIN
    Writeln(ParamCount);
    FOR i := 1 TO ParamCount DO BEGIN
        Writeln(ParamStr(i));
    END;
END.