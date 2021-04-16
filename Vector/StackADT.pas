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

// IN s: The stack.
// Checks if stack is empty.
// RETURNS TRUE if stack is empty, false otherwise.
FUNCTION IsEmpty(VAR s: Stack): BOOLEAN;


IMPLEMENTATION

USES
    VectorADT;


TYPE
    internalStackPtr = ^IntenralStack;

    IntenralStack = RECORD
        cache: Vector;
        top: INTEGER;
    END;


PROCEDURE InitStack(VAR s: Stack);
VAR
    ptr: internalStackPtr;
BEGIN
    New(ptr);
    ptr^.top:= 0;
    InitVector(ptr^.cache);
    s := ptr;
END;

PROCEDURE DisposeStack(VAR s: Stack);
VAR
    ptr: internalStackPtr;
BEGIN
    ptr := internalStackPtr(s);
    DisposeVector(ptr^.cache);
END;

PROCEDURE Push(VAR s: Stack; value: INTEGER; VAR ok: BOOLEAN);
VAR
    ptr: internalStackPtr;
BEGIN
    ptr := internalStackPtr(s);
    Add(ptr^.cache, value);
    Inc(ptr^.top);
    
    ok := true;
END;

PROCEDURE Pop(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);
VAR
    ptr: internalStackPtr;
BEGIN
    ptr := internalStackPtr(s);
    
    ok := NOT IsEmpty(s);
    IF ok THEN BEGIN
        GetElementAt(ptr^.cache, ptr^.top, value);
        RemoveElementAt(ptr^.cache, ptr^.top);
        Dec(ptr^.top);
    END;
END;

FUNCTION IsEmpty(VAR s: Stack): BOOLEAN;
VAR
    ptr: internalStackPtr;
BEGIN
    ptr := internalStackPtr(s);
    IsEmpty := ptr^.top = 0;
END;

BEGIN
    (* INIT HERE *)
END.