UNIT StackOOP;

INTERFACE

CONST
    MaxSize = 100;

TYPE
    Stack = OBJECT
        data: ARRAY[1..MaxSize] OF INTEGER;
        top: 0..MaxSize;
        
        // Initializes a Stack
        // IN Stack
        // Must be called before any other operation is called on a stack.
        PROCEDURE Init;

        // Disposes a stack
        // IN Stack
        PROCEDURE Dispose;

        // PUSHES a new value onto the stack.
        // IN s: The stack.
        // IN value: Value to push onto the stack.
        // OUT ok: TRUE if value has been pushed, FALSE if stack was full.
        PROCEDURE Push(value: INTEGER; VAR ok: BOOLEAN);

        // Pops a value from the stack
        // IN s: The stack.
        // OUT value: value popped from the stack. Value is undefined / must not be used when pop was not possible.
        // OUT ok: TRUE if value has been popped, FALSE if stack was empty.
        PROCEDURE Pop(VAR value: INTEGER; VAR ok: BOOLEAN);

        PROCEDURE Peek(VAR value: INTEGER; VAR ok: BOOLEAN);

        // IN s: The stack.
        // Checks if stack is empty.
        // RETURNS TRUE if stack is empty, false otherwise.
        FUNCTION IsEmpty: BOOLEAN;

        PROCEDURE Clear;
    END;

IMPLEMENTATION


PROCEDURE Stack.Init;
BEGIN
    SELF.top := 0;
END;

PROCEDURE Stack.Dispose;
BEGIN
    // nothing to do
END;

PROCEDURE Stack.Push(value: INTEGER; VAR ok: BOOLEAN);
BEGIN
    IF SELF.top < MaxSize THEN BEGIN
        Inc(SELF.top);
        data[SELF.top] := value;
    END ELSE
        ok := FALSE;
END;

PROCEDURE Stack.Pop(VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN
    ok := NOT SELF.IsEmpty;
    IF ok THEN BEGIN
        value := SELF.data[SELF.top];
        Dec(SELF.top);
    END
END;

PROCEDURE Stack.Peek(VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN
    ok := NOT SELF.IsEmpty;
    IF ok THEN BEGIN
        value := SELF.data[SELF.top];
    END
END;

FUNCTION Stack.IsEmpty: BOOLEAN;
BEGIN
    IsEmpty:= SELF.top = 0;
END;

PROCEDURE Stack.Clear;
BEGIN
    SELF.top := 0;
END;

BEGIN
    (* INIT HERE *)
END.