UNIT StackADT;

INTERFACE

TYPE
    Stack = POINTER;

// Initializes a Stack
// IN Stack
// Must be called before any other operation is called on a stack.
PROCEDURE InitStack(VAR s: Stack);

// Disposes a stack
// IN Stack
PROCEDURE DisposeStack(VAR s: Stack);


// PUSHES a new value onto the stack.
// IN s: The stack.
// IN value: Value to push onto the stack.
// OUT ok: TRUE if value has been pushed, FALSE if stack was full.
PROCEDURE Push(VAR s: Stack; value: INTEGER; VAR ok: BOOLEAN);

// Pops a value from the stack
// IN s: The stack.
// OUT value: value popped from the stack. Value is undefined / must not be used when pop was not possible.
// OUT ok: TRUE if value has been popped, FALSE if stack was empty.
PROCEDURE Pop(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);

// Peaks a value from the stack
// IN s: The stack.
// OUT value: value peaked from the stack. Value is undefined / must not be used when Peak was not possible.
// OUT ok: TRUE if value has been peaked, FALSE if stack was empty.
// Stack is not changed by calling Peak.
PROCEDURE Peak(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);

// IN s: The stack.
// Checks if stack is empty.
// RETURNS TRUE if stack is empty, false otherwise.
FUNCTION IsEmpty(VAR s: Stack): BOOLEAN;

// IN s: The stack.
// Clears the stack.
PROCEDURE Clear(VAR s: Stack);



IMPLEMENTATION


CONST
    MaxSize = 10;

TYPE
    state = RECORD
        // state depends on implementation :-(
        data: ARRAY[0..MaxSize] OF INTEGER;
        top: 0..MaxSize;
    END;

PROCEDURE InitStack(VAR s: Stack);
VAR
    st: ^State;
BEGIN
    New(st);
    st^.top := 0;
    s := @st;
END;

PROCEDURE DisposeStack(VAR s: Stack);
BEGIN
    // nothing to do
END;

PROCEDURE Push(VAR s: Stack; value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
    ok := s.top < MaxSize;
    IF ok THEN
    BEGIN
        Inc(s.top);
        s.data[s.top] := value;
    END;
END;

PROCEDURE Pop(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
    ok := NOT IsEmpty(s);
    IF ok THEN BEGIN
        value := s.data[s.top];
        Dec(s.top);
    END;
END;


PROCEDURE Peak(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
    ok := NOT IsEmpty(s);
    IF ok THEN 
        value := s.data[s.top];
END;

FUNCTION IsEmpty(VAR s: Stack): BOOLEAN;
BEGIN 
    IsEmpty := s.top = 0;
END;

PROCEDURE Clear(VAR s: Stack);
BEGIN 
    s.top := 0;
END;

BEGIN
    (* INIT HERE *)
END.