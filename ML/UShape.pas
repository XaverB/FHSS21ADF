UNIT UShape;

INTERFACE

USES
    MLObj;

TYPE
    Shape = ^ShapeObj;
    ShapeObj = OBJECT(MLObjectObj) // ABSTRACT // ### added base class MLObject
            CONSTRUCTOR Init;

            PROCEDURE Draw; VIRTUAL; // ABSTRACT
            PROCEDURE MoveBy(dx, dy: INTEGER); VIRTUAL; // ABSTRACT
        PRIVATE
    END;

    
IMPLEMENTATION

CONSTRUCTOR ShapeObj.Init;
begin
    INHERITED Init;
    Register('Shape', 'MLObject'); // ## required meta information for MiniLib
end;

PROCEDURE ShapeObj.Draw; // ABSTRACT
begin
    Writeln('ABSTRACT - SHOULD NEVER BE CALLED.');
    Halt;
end;

PROCEDURE ShapeObj.MoveBy(dx, dy: INTEGER); // ABSTRACT
begin
    Writeln('ABSTRACT - SHOULD NEVER BE CALLED.');
    Halt;
end;

BEGIN
end.