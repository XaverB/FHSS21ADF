PROGRAM StackOOPTest;

USES StackOOP;

VAR 
s: Stack;
ok: BOOLEAN;
value: INTEGER;

BEGIN
s.Init;

s.Push(3, ok);
writeln(s.IsEmpty);
s.POP(value, ok);
writeln(value);
writeln(s.IsEmpty);

s.Dispose;

END.