PROGRAM Containers;

TYPE
    Vector = OBJECT
            PROCEDURE Init;
            PROCEDURE Done;

            PROCEDURE Add(value: INTEGER);
            PROCEDURE InsertAt(pos: INTEGER; value: INTEGER);
            PROCEDURE RemoveAt(pos: INTEGER; VAR value: INTEGER);
            PROCEDURE Clear;
        PRIVATE
            // ...
    END;
    Stack = OBJECT
            PROCEDURE Init;
            PROCEDURE Done;

            PROCEDURE Push(value: INTEGER);
            PROCEDURE Pop(VAR value: INTEGER);
            PROCEDURE Clear;
        PRIVATE
            _vector: Vector;
    END;

PROCEDURE Stack.Init;
BEGIN
    SELF._vector.Init;
END;

PROCEDURE Stack.Push(value: INTEGER);
BEGIN
    SELF._vector.InsertAt(0, value);
END;

PROCEDURE Stack.Pop(VAR value: INTEGER);
BEGIN
    SELF._vector.RemoveAt(0, value);
END;

BEGIN
END.