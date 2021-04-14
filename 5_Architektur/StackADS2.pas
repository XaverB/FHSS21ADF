UNIT StackADS2;

INTERFACE

// PUSHES a new value onto the stack.
// IN value: Value to push onto the stack.
// OUT ok: TRUE if value has been pushed, FALSE if stack was full.
PROCEDURE Push(value: INTEGER; VAR ok: BOOLEAN);

// Pops a value from the stack
// OUT value: value popped from the stack. Value is undefined / must not be used when pop was not possible.
// OUT ok: TRUE if value has been popped, FALSE if stack was empty.
PROCEDURE Pop(VAR value: INTEGER; VAR ok: BOOLEAN);

// Peaks a value from the stack
// OUT value: value peaked from the stack. Value is undefined / must not be used when Peak was not possible.
// OUT ok: TRUE if value has been peaked, FALSE if stack was empty.
// Stack is not changed by calling Peak.
PROCEDURE Peak(VAR value: INTEGER; VAR ok: BOOLEAN);

// Checks if stack is empty.
// RETURNS TRUE if stack is empty, false otherwise.
FUNCTION IsEmpty: BOOLEAN;

// Clears the stack.
PROCEDURE Clear;

IMPLEMENTATION

CONST
    MaxSize = 10;

TYPE
    Node = ^NodeRec;
    NodeRec = RECORD
        value: INTEGER;
        next: Node;
    END;
    List = Node;

VAR
    data: List;


PROCEDURE Push(value: INTEGER; VAR ok: BOOLEAN);
VAR
    n: Node;
BEGIN 
    New(n);
    ok := n <> NIL;
    IF ok THEN BEGIN
        n^.value := value;
        n^.next := data;
        data := n;
    END;
END;

PROCEDURE Pop(VAR value: INTEGER; VAR ok: BOOLEAN);
VAR
    next: Node;
BEGIN 
    ok := NOT IsEmpty;
    IF ok THEN BEGIN
        value := data^.value;
        next := data^.next;
        Dispose(data);
        data := next;
    END;
END;


PROCEDURE Peak(VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
    ok := NOT IsEmpty;
    IF ok THEN BEGIN
        value := data^.value;
    END;
END;

FUNCTION IsEmpty: BOOLEAN;
BEGIN 
    IsEmpty := data = NIL;
END;

PROCEDURE Clear;
VAR
    n, next: Node;
BEGIN 
    n := data;
    WHILE n <> NIL DO BEGIN
        next := n^.next;
        Dispose(n);
        n := next;
    END;
    data := NIL;
END;

BEGIN
    data := NIL;
END.