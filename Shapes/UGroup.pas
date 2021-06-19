UNIT UGroup;

INTERFACE

USES UShape;

TYPE
    Group = ^GroupObj;
    GroupObj = OBJECT(ShapeObj)

        CONSTRUCTOR Init;
        destructor Done; VIRTUAL;
        PROCEDURE Draw; VIRTUAL;
        PROCEDURE MoveBy(dx, dy: INTEGER); VIRTUAL;

        PROCEDURE AddShape(s: Shape; VAR ok: BOOLEAN); VIRTUAL;
        PRIVATE
            _shapes: POINTER; // ShapeNodePointer
    END;

IMPLEMENTATION

TYPE
    ShapeNodePointer = ^ShapeNode;
    ShapeNode = RECORD
        s: Shape;
        next: ShapeNodePointer;
    END;

CONSTRUCTOR GroupObj.Init;
begin
    INHERITED Init; // AAAAAAAAAAALWAYS
    SELF._shapes := NIL;
end;

destructor GroupObj.Done;
VAR 
    n, next: ShapeNodePointer;
begin
    n := SELF._shapes;
    WHILE n <> NIL DO BEGIN
        next := n^.next;
        Dipose(n^.s, Done); // (just) this is added for STRONG AGGREGATION --> container now also kills the object (shapes)
        Dispose(n);
        n := next;
    END;
    INHERITED Done; // ALWAAAYS
end;

PROCEDURE GroupObj.Draw; 
VAR 
    n: ShapeNodePointer;
begin
    Writeln('BEGIN OF GROUP');
    n := SELF._shapes;
    WHILE n <> NIL DO BEGIN
        n^.s^.Draw;
        n := n^.next;
    END;
    Writeln('END OF GROUP');
end;

PROCEDURE GroupObj.MoveBy(dx, dy: INTEGER);
VAR 
    n: ShapeNodePointer;
begin
    n := SELF._shapes;
    WHILE n <> NIL DO BEGIN
        n^.s^.MoveBy(dx, dy);
        n := n^.next;
    END;

end;

PROCEDURE GroupObj.AddShape(s: SHape; VAR ok: BOOLEAN);
VAR
    n: ShapeNodePointer;
BEGIN
    New(n);
    ok := n <> NIL;
    IF ok THEN BEGIN
        n^.s := s;
        n^.next := SELF._shapes;
        SELF._shapes := n;
    END;
END;

BEGIN
END.
