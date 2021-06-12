PROGRAM StackOOPTest;

USES
    StackOOP;

// using class Stack with DYNAMIC object(s):
VAR
    p: ^Stack; // p is a pointer to a "future" object
    ok: BOOLEAN;
    value: INTEGER;
BEGIN
    New(p); // now a dynamic object is instanciated on the heap

    p^.Init;

    p^.Push(3, ok);
    WriteLn(p^.IsEmpty);
    p^.Pop(value, ok);
    WriteLn(value);
    WriteLn(p^.IsEmpty);

    p^.Dispose;

    Dispose(p); // now the dynamic object is destroyed
END.



// using class Stack with STATIC object(s):

VAR
    s: Stack; // object "s" is created by the compiler
    ok: BOOLEAN;
    value: INTEGER;
BEGIN (* StackOOPTest *)
    s.Init;

    s.Push(3, ok);
    WriteLn(s.IsEmpty);
    s.Pop(value, ok);
    WriteLn(value);
    WriteLn(s.IsEmpty);

    s.Dispose;
END. (* StackOOPTest *)