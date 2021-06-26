UNIT UGroup;

INTERFACE

USES UShape, MLObj, MLColl, MLVect;

TYPE
    Group = ^GroupObj;
    GroupObj = OBJECT(ShapeObj)

        CONSTRUCTOR Init;
        destructor Done; VIRTUAL;
        PROCEDURE Draw; VIRTUAL;
        PROCEDURE MoveBy(dx, dy: INTEGER); VIRTUAL;

        PROCEDURE AddShape(s: Shape; VAR ok: BOOLEAN); VIRTUAL;
    PRIVATE
        _shapes: MLVector;
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
    Register('Group', 'Shape'); // ## required meta information for MiniLib
    New(SELF._shapes, Init);
end;

destructor GroupObj.Done;
VAR
    it: MLIterator;
    o: MLObject;
begin
    // for STORNG aggregation: also destroy the owned objects
    it := SELF._shapes^.NewIterator;
    o := it^.next;
    WHILE o <> NIL DO BEGIN
        Dispose(o, DONE);
        o := it^.next;
    END;


    Dispose(SELF._shapes, DONE);
    INHERITED Done; // ALWAAAYS
end;

PROCEDURE GroupObj.Draw; 
VAR
    it: MLIterator;
    o: MLObject;
begin
    Writeln('BEGIN GROUP');
    it := SELF._shapes^.NewIterator;
    o := it^.next;
    WHILE o <> NIL DO BEGIN
        Shape(o)^.Draw;
        o := it^.next;
    END;
    Writeln('END GROUP');
end;

PROCEDURE GroupObj.MoveBy(dx, dy: INTEGER);
VAR
    it: MLIterator;
    o: MLObject;
begin
    it := SELF._shapes^.NewIterator;
    o := it^.next;
    WHILE o <> NIL DO BEGIN
        Shape(o)^.MoveBy(dx, dy);
        o := it^.next;
    END;
end;

PROCEDURE GroupObj.AddShape(s: SHape; VAR ok: BOOLEAN);
BEGIN
    SELF._shapes^.Add(s);
END;

BEGIN
END.
