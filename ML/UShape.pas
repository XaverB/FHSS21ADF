UNIT UShape;

INTERFACE

TYPE
    Shape = ^ShapeObj;
    ShapeObj = OBJECT // ABSTRACT 
            CONSTRUCTOR Init;
            destructor DONE; VIRTUAL;

            PROCEDURE Draw; VIRTUAL; // ABSTRACT
            PROCEDURE MoveBy(dx, dy: INTEGER); VIRTUAL; // ABSTRACT
        PRIVATE
    END;

    
IMPLEMENTATION

CONSTRUCTOR ShapeObj.Init;
begin
end;

destructor ShapeObj.DONE;
begin
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