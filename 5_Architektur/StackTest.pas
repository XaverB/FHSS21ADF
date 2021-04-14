PROGRAM StackTest;

USES StackADTa;


VAR
    ok: BOOLEAN;
    value: INTEGER;
BEGIN
    Push(3, ok); Writeln(ok);
    Push(5, ok); Writeln(ok);
    Push(8, ok); Writeln(ok);
    Push(3, ok); Writeln(ok);
    Peak(value, ok); Writeln(ok, ' ', value);
    WHILE NOT IsEmpty DO BEGIN
        Pop(value, ok); Writeln(ok, ' ', value);
    END;
    Peak(value, ok); Writeln(ok, ' ', value);
    Pop(value, ok); Writeln(ok, ' ', value);
    // REPEAT(Persönliche, Microsoft gefärbte Meinung)
    //     Push(12345, ok); WriteLn('X');
    // UNTIL NOT ok;
END.