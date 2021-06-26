UNIT UCircle;

INTERFACE

USES UShape, MLObj;

TYPE
    Circle = ^CircleObj;
    CircleObj = OBJECT(ShapeObj)

        CONSTRUCTOR Init(x, y, radius: INTEGER);

        PROCEDURE Draw; VIRTUAL;
        PROCEDURE MoveBy(dx, dy: INTEGER); VIRTUAL;

        // FUNCTION GetX: INTEGER; (VIRTUAL;) ...
        PRIVATE
            _x, _y, _radius: INTEGER;
    END;

IMPLEMENTATION

CONSTRUCTOR CircleObj.Init(x, y, radius: INTEGER);
begin
    INHERITED Init; // AAAAAAAAAAALWAYS
    Register('Circle', 'Shape'); // ## required meta information for MiniLib
    SELF._x := x;
    SELF._y := y;
    SELF._radius := radius;
end;

PROCEDURE CircleObj.Draw; 
begin
    Writeln('CIRCLE ', SELF._x, ' ', SELF._y, ' ', SELF._radius);
end;

PROCEDURE CircleObj.MoveBy(dx, dy: INTEGER);
begin
    SELF._x := SELF._x + dx;
    SELF._y := SELF._y + dy;
end;

BEGIN
END.
