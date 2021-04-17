UNIT VectorADS;

INTERFACE

(* fügt den Wert val „hinten“ an, wobei zuvor ev. die Größe des Behälters angepasst wird. *)
PROCEDURE Add(val: INTEGER);

(* setzt an der Stelle pos den Wert val.
* Der Aufrufer hat dafür zu sorgen, dass die pos nicht ausserhalb der Feldgröße liegt.
*)
PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);

(* liefert den Wert val an der Stelle pos.
* Der Aufrufer hat dafür zu sorgen, dass die pos nicht ausserhalb der Feldgröße liegt.
*)
PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER);

(* entfernt den Wert an der Stelle pos, wobei die restlichen Elemente um eine Position nach 
„vorne“ verschoben werden, die Kapazität des Behälters aber unverändert bleibt. 
* Der Aufrufer hat dafür zu sorgen, dass die pos nicht ausserhalb der Feldgröße liegt.
*)
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
BEGIN;
    newArray := NIL;
    InitializeArray(newArray, newSize);
    Copy(arrayPointer, newArray, 1, currentArraySize);
    FreeMem(arrayPointer, currentArraySize * SizeOf(INTEGER));
    arrayPointer := newArray;
    currentArraySize := newSize;
END;

(* fügt den Wert val „hinten“ an, wobei zuvor ev. die Größe des Behälters angepasst wird. *)
PROCEDURE Add(val: INTEGER);
BEGIN
    IF currentElementCount + 1 > currentArraySize THEN
        IncreaseSize(currentArraySize + 1);
    
    Inc(currentElementCount);
    (*$R-*)
    arrayPointer^[currentElementCount] := val;
    (*$R+*)
END;

(* setzt an der Stelle pos den Wert val.
* Der Aufrufer hat dafür zu sorgen, dass die pos nicht ausserhalb der Feldgröße liegt.
*)
PROCEDURE SetElementAt(pos: INTEGER; val: INTEGER);
BEGIN
    (*$R-*)
    arrayPointer^[pos] := val;
    (*$R+*)
END;

(* liefert den Wert val an der Stelle pos.
* Der Aufrufer hat dafür zu sorgen, dass die pos nicht ausserhalb der Feldgröße liegt.
*)
PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER);
BEGIN
    (*$R-*)
    val := arrayPointer^[pos];
    (*$R+*)
END;

(* entfernt den Wert an der Stelle pos, wobei die restlichen Elemente um eine Position nach 
„vorne“ verschoben werden, die Kapazität des Behälters aber unverändert bleibt. 
* Der Aufrufer hat dafür zu sorgen, dass die pos nicht ausserhalb der Feldgröße liegt.
*)
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
        Dec(currentElementCount);
    END;
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