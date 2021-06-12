UNIT VectorOOP;

INTERFACE

CONST
    MaxSize = 5;

TYPE
    Vector = OBJECT
        
        // initialisiert den Vektor
        PROCEDURE Init;

        // fügt den Wert val „hinten“ an.
        PROCEDURE Add(val: INTEGER);

        // Fügt den Wert val an der Stelle pos ein, wobei die Werte ab dieser Stelle nach hinten verschoben werden. 
        // Ist pos ≤ 0, wird val „vorne“ eingefügt; ist pos > Size (s. u.) wird val „hinten“ angefügt. 
        // Der Ausgangsparameter ok liefert nur dann FALSE, wenn für pos ein Wert über 
        // der Obergrenze des Vektors (Capacity) angegeben wurde.
        PROCEDURE InsertElementAt(pos: INTEGER; val: INTEGER; VAR ok: BOOLEAN);

        // liefert den Wert val an der Stelle pos. Der Ausgangsparameter ok liefert nur dann FALSE, 
        // wenn für pos ein ungültiger Wert angegeben wurde.
        PROCEDURE GetElementAt(pos: INTEGER; VAR val: INTEGER; VAR ok: BOOLEAN);

        // liefert die aktuelle Anzahl der Elemente
        FUNCTION Size: INTEGER;

        // leert den Behälter
        PROCEDURE Clear;

        // liefert die maximale Kapazität des Behälters
        FUNCTION Capacity: INTEGER;

        PRIVATE 
        top: 0..MaxSize;
        data: ARRAY[1..MaxSize] OF INTEGER;

        // shift all values from their index to index + 1
        // does not check for MaxSize
        PROCEDURE ShiftValues(startPosition: INTEGER);
    END;

IMPLEMENTATION

USES sysutils;

PROCEDURE Vector.Init;
BEGIN
    top := 0;
END;

PROCEDURE Vector.Add(val: INTEGER);
BEGIN
    IF SELF.top < MaxSize THEN BEGIN
        Inc(SELF.top);
        data[SELF.top] := val;
    END;
END;

PROCEDURE Vector.InsertElementAt(pos: INTEGER; val: INTEGER; VAR ok: BOOLEAN);
BEGIN
        // pos ausserhalb der capacity oder vector bereits voll
    	IF (pos > MaxSize) OR (SELF.top >= MaxSize) THEN
            ok := false
        ELSE BEGIN
            ok := true;
            Inc(SELF.top);
            // vorne anfügen
            IF pos <= 0 THEN BEGIN
                SELF.ShiftValues(1);
                SELF.data[1] := val;
                // vorne
            // hinten anfügen
            END ELSE IF pos > SELF.Size THEN BEGIN
                SELF.Add(val);
            // an position anfügen
            END ELSE BEGIN
                SELF.ShiftValues(pos);
                SELF.data[pos] := val;
            END;
        END;
END;

PROCEDURE Vector.ShiftValues(startPosition: INTEGER);
VAR
    i: INTEGER;
BEGIN
    
    // maybe condition wring
    FOR i := SELF.top TO startPosition DO BEGIN
        Writeln('shifting SELF.data[i-1] := SELF.data[i]; - ', IntToStr(SELF.data[i-1]), ' := ',  IntToStr(SELF.data[i]));
        SELF.data[i-1] := SELF.data[i];
        Dec(i);
    END;
END;

PROCEDURE Vector.GetElementAt(pos: INTEGER; VAR val: INTEGER; VAR ok: BOOLEAN);
BEGIN
    IF (pos <= SELF.top) AND (pos > 0) THEN BEGIN
        val := SELF.data[pos];
        ok := true;
    END ELSE 
        ok := false;
END;

FUNCTION Vector.Size: INTEGER;
BEGIN
    Size := SELF.top;
END;

FUNCTION Vector.Capacity: INTEGER;
BEGIN
    Capacity := MaxSize;
END;

PROCEDURE Vector.Clear;
BEGIN
    SELF.top := 0;
END;

BEGIN
END.