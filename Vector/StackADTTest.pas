PROGRAM StackADTTest;

USES StackADT;

PROCEDURE AssertEquals(expected: INTEGER; actual: INTEGER);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert failed! Expected: (', IntToStr(expected), '), Actual: (', IntToStr(actual),')');
END;

VAR
    s, s2: Stack;
    ok: BOOLEAN;
    value: INTEGER;
BEGIN
    InitStack(s);

    (* push some values *)
    Push(s, 3, ok);
    Push(s, 5, ok);
    Push(s, 8, ok);

    InitStack(s2);

    WHILE NOT IsEmpty(s) DO BEGIN
        (* the pushed values must be printed in reverse order *)
        Pop(s, value, ok);  Writeln(ok, ' ', value);
        (* push the values into the second stack *)
        Push(s2, value, ok);
    END;

    (* stack s is empty *)
    Pop(s, value, ok); 
    (* must be false, because the stack is empty *)
    Writeln(ok, ' ', value);

    (* push a value --> IsEmpty must be false *)
    Push(s, 1, ok); 
    Writeln(IsEmpty(s));

    DisposeStack(s);

    (* now the pushed values must be printed in reverse again *)
    WHILE NOT isEmpty(s2) DO BEGIN
        Pop(s2, value, ok); Writeln(value);
    END;

    DisposeStack(s2);
END.