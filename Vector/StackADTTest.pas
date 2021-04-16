PROGRAM StackADTTest;

USES StackADT;

VAR
    s, s2: Stack;
    ok: BOOLEAN;
    value: INTEGER;
BEGIN
    InitStack(s);

    Push(s, 3, ok); WriteLn(ok);
    Push(s, 5, ok); WriteLn(ok);
    Push(s, 8, ok); WriteLn(ok);

    InitStack(s2);

    WHILE NOT IsEmpty(s) DO BEGIN
        Pop(s, value, ok); Writeln(ok, ' ', value);
        Push(s2, value, ok);
    END;

    Pop(s, value, ok); Writeln(ok, ' ', value);
    Push(s, 1, ok); Writeln(IsEmpty(s));

    DisposeStack(s);

    WHILE NOT isEmpty(s2) DO BEGIN
        Pop(s2, value, ok); Writeln(value);
    END;

    DisposeStack(s2);
END.