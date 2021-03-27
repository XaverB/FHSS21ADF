UNIT StackADS;

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
    MaxSize = 100;

VAR
    data: ARRAY[0..MaxSize] OF INTEGER;
    top: 0..MaxSize;


PROCEDURE Push(value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
END.

PROCEDURE Pop(VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
END.


PROCEDURE Peak(VAR value: INTEGER; VAR ok: BOOLEAN);
BEGIN 
END.

FUNCTION IsEmpty: BOOLEAN;
BEGIN 
END.

PROCEDURE Clear;
BEGIN 
END.

BEGIN
    (* INIT HERE *)
END.