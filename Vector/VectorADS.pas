UNIT VectorADS;

INTERFACE

(* fügt den Wert val „hinten“ an, wobei zuvor ev. die Größe des Behälters angepasst wird. *)
PROCEDURE Add(val: INTEGER);

(* setzt an der Stelle pos den Wert val.*)
PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);

(* liefert den Wert val an der Stelle pos. *)
PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER);

(* entfernt den Wert an der Stelle pos, wobei die restlichen Elemente um eine Position nach 
„vorne“ verschoben werden, die Kapazität des Behälters aber unverändert bleibt. *)
PROCEDURE RemoveElementAt(pos: INTEGER);

(* liefert die aktuelle Anzahl der im Behälter gespeicherten Werte (zu Beginn 0). *)
FUNCTION Size: INTEGER;

(* liefert die Kapazität des Behälters, also die aktuelle Größe des dynamischen Felds. *)
FUNCTION Capacity: INTEGER;

IMPLEMENTATION

CONST
    defaultSize = 3;

TYPE
    IntArray = ARRAY [1..defaultSize] OF INTEGER;
    IntArrayPtr = ^IntArray;

VAR
    currentArraySize: INTEGER;
    currentElementCount: INTEGER;
    arrayPointer: IntArrayPtr;


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

PROCEDURE IncreaseSize(newSize: INTEGER);
VAR
    newArray: IntArrayPtr;
BEGIN
    Writeln('increasing size.');
    newArray := NIL;
    Writeln('1.');
    InitializeArray(newArray, newSize);
    Writeln('2.');
    Copy(arrayPointer, newArray, 1, currentArraySize);
    Writeln('3.');
    FreeMem(arrayPointer, currentArraySize * SizeOf(INTEGER));
    Writeln('4.');
    arrayPointer := newArray;
    currentArraySize := newSize;
    Writeln('size increased');
END;

(* fügt den Wert val „hinten“ an, wobei zuvor ev. die Größe des Behälters angepasst wird. *)
PROCEDURE Add(val: INTEGER);
BEGIN
    IF currentElementCount + 1 > currentArraySize THEN
        IncreaseSize(currentArraySize + 1);
    
    Inc(currentElementCount);
    Writeln('before add');
    (*$R-*)
    arrayPointer^[currentElementCount] := val;
    (*$R+*)
    Writeln('after add');
END;

(* setzt an der Stelle pos den Wert val.*)
PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);
BEGIN
    (*$R-*)
    arrayPointer^[pos] := val;
    (*$R+*)
END;

(* liefert den Wert val an der Stelle pos. *)
PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER);
BEGIN
    (*$R-*)
    val := arrayPointer^[pos];
    (*$R+*)
END;

(* entfernt den Wert an der Stelle pos, wobei die restlichen Elemente um eine Position nach 
„vorne“ verschoben werden, die Kapazität des Behälters aber unverändert bleibt. *)
PROCEDURE RemoveElementAt(pos: INTEGER);
VAR
    i: INTEGER;
BEGIN
    i := pos;
    (* only do this when there is a element to remove *)
    IF currentElementCount >= pos THEN 
    BEGIN
        WHILE i < currentElementCount DO BEGIN
            (*$R-*)
            arrayPointer^[i] := arrayPointer^[i+1];
            (*$R+*)
            Inc(i);
        END;
    END;
    Inc(currentElementCount);
END;

(* liefert die aktuelle Anzahl der im Behälter gespeicherten Werte (zu Beginn 0). *)
FUNCTION Size: INTEGER;
BEGIN
    Size := currentElementCount;
END;

(* liefert die Kapazität des Behälters, also die aktuelle Größe des dynamischen Felds. *)
FUNCTION Capacity: INTEGER;
BEGIN
    Capacity := currentArraySize;
END;

BEGIN
    InitializeArray(arrayPointer, defaultSize);
    currentElementCount := 0;
    currentArraySize := defaultSize;
END.