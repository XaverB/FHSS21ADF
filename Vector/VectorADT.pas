UNIT VectorADT;

INTERFACE

TYPE
    Vector = POINTER;

// Initializes a vector
// IN vector
// Must be called before any other operation is called on a vector.
PROCEDURE InitVector(VAR v: Vector);

// Disposes a vector
// IN vector
PROCEDURE DisposeVector(VAR v: Vector);

(* fügt den Wert val „hinten“ an, wobei zuvor ev. die Größe des Behälters angepasst wird. *)
PROCEDURE Add(VAR v: Vector; val: INTEGER);

(* setzt an der Stelle pos den Wert val.*)
PROCEDURE SetElementAt(VAR v: Vector; pos: INTEGER; val: INTEGER);

(* liefert den Wert val an der Stelle pos. *)
PROCEDURE GetElementAt(v: Vector; pos: INTEGER; VAR val: INTEGER);

(* entfernt den Wert an der Stelle pos, wobei die restlichen Elemente um eine Position nach 
„vorne“ verschoben werden, die Kapazität des Behälters aber unverändert bleibt. *)
PROCEDURE RemoveElementAt(VAR v: Vector; pos: INTEGER);

(* liefert die aktuelle Anzahl der im Behälter gespeicherten Werte (zu Beginn 0). *)
FUNCTION Size(v: Vector): INTEGER;

(* liefert die Kapazität des Behälters, also die aktuelle Größe des dynamischen Felds. *)
FUNCTION Capacity(v: Vector): INTEGER;

IMPLEMENTATION


USES
    sysutils;

CONST
    defaultSize = 3;

TYPE
    IntArray = ARRAY [1..defaultSize] OF INTEGER;
    IntArrayPtr = ^IntArray;
    StatePtr = ^state;

    state = RECORD
        arrayPointer: IntArrayPtr;
        currentSize: INTEGER;
        currentElementCount: INTEGER;
    END;


PROCEDURE InitializeArray(VAR arrayToInitialize: IntArrayPtr; size: INTEGER);
VAR
    i: INTEGER;
BEGIN
    GetMem(arrayToInitialize, size * SizeOf(INTEGER));
    Initialize(arrayToInitialize);
    FOR i := 1 TO size DO BEGIN
    (*$R-*)
        arrayToInitialize^[i] := 0; 
    (*$R+*)
    END; (* FOR *)
END;

// Initializes a vector
// IN vector
// Must be called before any other operation is called on a vector.
PROCEDURE InitVector(VAR v: Vector);
VAR
    state: StatePtr;
BEGIN
    New(state);
    v := state;

    state^.currentElementCount := 0;
    state^.currentSize := defaultSize;
    InitializeArray(state^.arrayPointer, defaultSize);    
END;

// Disposes a vector
// IN vector
PROCEDURE DisposeVector(VAR v: Vector);
BEGIN
    FreeMem(StatePtr(v)^.arrayPointer);
    Dispose(StatePtr(v));
END;

PROCEDURE Copy(sourceArray: IntArrayPtr; VAR targetArray: IntArrayPtr; startIndex: INTEGER; endIndex: INTEGER);
VAR
    i: INTEGER;
BEGIN
    FOR i := startIndex to endIndex DO BEGIN
        (*$R-*)
        targetArray^[i] := sourceArray^[i];
        (*$R+*)
    END; (* FOR *) 
END;

PROCEDURE IncreaseSize(VAR v: Vector; newSize: INTEGER);
VAR
    newArray: IntArrayPtr;
    state: StatePtr;
BEGIN;
    state := StatePtr(v);

    newArray := NIL;
    InitializeArray(newArray, newSize);
    Copy(state^.arrayPointer, newArray, 1, state^.currentSize);
    FreeMem(state^.arrayPointer, state^.currentSize * SizeOf(INTEGER));
    state^.arrayPointer := newArray;
    state^.currentSize := newSize;
END;

(* fügt den Wert val „hinten“ an, wobei zuvor ev. die Größe des Behälters angepasst wird. *)
PROCEDURE Add(VAR v: Vector; val: INTEGER);
VAR
    state: StatePtr;
BEGIN
    state := StatePtr(v);
    IF state^.currentElementCount + 1 > state^.currentSize THEN BEGIN
        IncreaseSize(v, state^.currentSize + 1);
    END;
    

    Inc(state^.currentElementCount);
    (*$R-*)
    state^.arrayPointer^[state^.currentElementCount] := val;
    (*$R+*)
END;

(* setzt an der Stelle pos den Wert val.*)
PROCEDURE SetElementAt(VAR v: Vector; pos: INTEGER; val: INTEGER);
VAR
    state: StatePtr;
BEGIN
    state := StatePtr(v);
    (*$R-*)
    state^.arrayPointer^[pos] := val;
    (*$R+*)
END;

(* liefert den Wert val an der Stelle pos. *)
PROCEDURE GetElementAt(v: Vector; pos: INTEGER; VAR val: INTEGER);
VAR
    state: StatePtr;
BEGIN
    state := StatePtr(v);
    (*$R-*)
    val := state^.arrayPointer^[pos];
    (*$R+*)
END;

(* entfernt den Wert an der Stelle pos, wobei die restlichen Elemente um eine Position nach 
„vorne“ verschoben werden, die Kapazität des Behälters aber unverändert bleibt. *)
PROCEDURE RemoveElementAt(VAR v: Vector; pos: INTEGER);
VAR
    state: StatePtr;
    i: INTEGER;
BEGIN
    state := StatePtr(v);
    i := pos;
    (* only do this when there is a element to remove *)
    IF state^.currentElementCount >= pos THEN 
    BEGIN
        WHILE i < state^.currentElementCount DO BEGIN
            (*$R-*)
            state^.arrayPointer^[i] := state^.arrayPointer^[i+1];
            (*$R+*)
            Inc(i);
        END;
        Dec(state^.currentElementCount);
    END;
END;

(* liefert die aktuelle Anzahl der im Behälter gespeicherten Werte (zu Beginn 0). *)
FUNCTION Size(v: Vector): INTEGER;
VAR
    state: StatePtr;
BEGIN
    state := StatePtr(v);
    Size := state^.currentElementCount;
END;

(* liefert die Kapazität des Behälters, also die aktuelle Größe des dynamischen Felds. *)
FUNCTION Capacity(v: Vector): INTEGER;
VAR
    state: StatePtr;
BEGIN
    state := StatePtr(v);
    Capacity := state^.currentSize;
END;

BEGIN
END.