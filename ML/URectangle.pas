UNIT URectangle;

INTERFACE

USES UShape, MLObj;

TYPE
    Rectangle = ^RectangleObj;
    RectangleObj = OBJECT(ShapeObj)

        CONSTRUCTOR Init(x, y, width, height: INTEGER);

        PROCEDURE Draw; VIRTUAL;
        PROCEDURE MoveBy(dx, dy: INTEGER); VIRTUAL;

        // FUNCTION GetX: INTEGER; (VIRTUAL;) ...
        PRIVATE
            _x, _y, _width, _height: INTEGER;
    END;

IMPLEMENTATION

CONSTRUCTOR RectangleObj.Init(x, y, width, height: INTEGER);
begin
    INHERITED Init; // AAAAAAAAAAALWAYS
    Register('Rectangle', 'Shape'); // ## required meta information for MiniLib
    SELF._x := x;
    SELF._y := y;
    SELF._width := width;
    SELF._height := height;
end;

PROCEDURE RectangleObj.Draw; 
begin
    Writeln('RECTANGLE ', SELF._x, ' ', SELF._y, ' ', SELF._width, ' ', SELF._height);
end;

PROCEDURE RectangleObj.MoveBy(dx, dy: INTEGER);
begin
    SELF._x := SELF._x + dx;
    SELF._y := SELF._y + dy;
end;


BEGIN
END.
