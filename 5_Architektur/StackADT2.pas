UNIT StackADT2;


INTERFACE

TYPE
    Node = ^NodeRec;
    NodeRec = RECORD
        value: INTEGER;
        next: Node;
    END;
    List = Node;

    Stack = RECORD
        data: List;
    END;

// Initializes a Stack
// IN Stack
// Must be called before any other operation is called on a stack.
PROCEDURE InitStack(VAR s: Stack);

// Disposes a stack
// IN Stack
// Must be called as last operation when a stack is no longer needed. No further operations are allowed on a stack after this has been called.
PROCEDURE DisposeStack(VAR s: Stack);

// PUSHES a new value onto the stack.
// IN Stack
// IN value: Value to push onto the stack.
// OUT ok: TRUE if value has been pushed, FALSE if stack was full.
PROCEDURE Push(VAR s: Stack; value: INTEGER; VAR ok: BOOLEAN);

// Pops a value from the stack
// IN Stack
// OUT value: value popped from the stack. Value is undefined / must not be used when pop was not possible.
// OUT ok: TRUE if value has been popped, FALSE if stack was empty.
PROCEDURE Pop(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);

// Peaks a value from the stack
// IN Stack
// OUT value: value peaked from the stack. Value is undefined / must not be used when Peak was not possible.
// OUT ok: TRUE if value has been peaked, FALSE if stack was empty.
// Stack is not changed by calling Peak.
PROCEDURE Peak(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);

// IN Stack
// Checks if stack is empty.
// RETURNS TRUE if stack is empty, false otherwise.
FUNCTION IsEmpty(VAR s: Stack): BOOLEAN;

// IN Stack
// Clears the stack.
PROCEDURE Clear(VAR s: Stack);


IMPLEMENTATION


PROCEDURE InitStack(VAR s: Stack);
BEGIN
    s.data := NIL;
END;

PROCEDURE DisposeStack(VAR s: Stack);
VAR
    n, next: Node;
BEGIN 
    n := s.data;
    WHILE n <> NIL DO BEGIN
        next := n^.next;
        Dispose(n);
        n := next;
    END;
END;


PROCEDURE Push(VAR s: Stack; value: INTEGER; VAR ok: BOOLEAN);
VAR
    n: Node;
BEGIN 
    New(n);
    ok := n <> NIL;
    IF ok THEN BEGIN
        n^.value := value;
        n^.next := s.data;
        s.data := n;
    END;
END;

PROCEDURE Pop(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);
VAR
    next: Node;
BEGIN 
    ok := NOT IsEmpty(s);
    IF ok THEN BEGIN
        value := s.data^.value;
        next := s.data^.next;
        Dispose(s.data);
        s.data := next;
    END;
END;


PROCEDURE Peak(VAR s: Stack; VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
    ok := NOT IsEmpty(s);
    IF ok THEN BEGIN
        value := s.data^.value;
    END;
END;

FUNCTION IsEmpty(VAR s: Stack): BOOLEAN;
BEGIN 
    IsEmpty := s.data = NIL;
END;

PROCEDURE Clear(VAR s: Stack);
VAR
    n, next: Node;
BEGIN 
    n := s.data;
    WHILE n <> NIL DO BEGIN
        next := n^.next;
        Dispose(n);
        n := next;
    END;
    s.data := NIL;
END;

BEGIN
    
END.