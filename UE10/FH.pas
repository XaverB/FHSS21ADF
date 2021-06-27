PROGRAM FH;

TYPE
    Person = OBJECT
            CONSTRUCTOR Init(name: STRING);
            PROCEDURE Done;

            FUNCTION GetName: STRING;
            FUNCTION HasAccessTo(room: STRING): BOOLEAN; VIRTUAL;
        PRIVATE
            _name: STRING;
  
    END;
    Student = OBJECT(Person)
            CONSTRUCTOR Init(name, code: STRING); // overridden method (can have different parameters)
            FUNCTION HasAccessTo(room: STRING): BOOLEAN; VIRTUAL;
            FUNCTION GetCode: STRING; VIRTUAL; // new method
        PRIVATE
            _code: STRING; // new member
    END;
    Teacher = OBJECT(Person)
            FUNCTION HasAccessTo(room: STRING): BOOLEAN; VIRTUAL;
    END;

CONSTRUCTOR Person.Init(name: STRING);
BEGIN
    // TODO some magice code that initializes the magic pointer (virtual method table pointer, VMT pointer)
    // ---> compile should do something like this for us: "Self:RunMAgicCodeToInitializeVMTPointer"
    // happens thanks to constructor keyword
    SELF._name := name;
END;

PROCEDURE Person.Done;
BEGIN
END;

FUNCTION Person.GetName: STRING;
BEGIN
    GetName := SELF._name;
END;

FUNCTION Person.HasAccessTo(room: STRING): BOOLEAN;
BEGIN
    HasAccessTo := room = 'Lobby';
END;

CONSTRUCTOR Student.Init(name, code: STRING);
BEGIN
    INHERITED Init(name); // _alsways_ call inherited Init in first place !!!
    SELF._code := code;
END;

FUNCTION Student.HasAccessTo(room: STRING): BOOLEAN;
BEGIN
    HasAccessTo := INHERITED HasAccessTo(room) OR (room = 'Lab');
END;

FUNCTION Student.GetCode: STRING;
BEGIN
    GetCode := SELF._code;
END;

FUNCTION Teacher.HasAccessTo(room: STRING): BOOLEAN;
BEGIN
    HasAccessTo := TRUE;
END;

TYPE
    PersonPointer = ^Person;

PROCEDURE PrintInfo(p: PersonPointer);
BEGIN
    WriteLn(p^.GetName);
    WriteLn('Lobby: ,', p^.HasAccessTo('Lobby'));
    WriteLn('Lab: ', p^.HasAccessTo('Lab'));
    WriteLn('Staff Room: ', p^.HasAccessTo('Staff Room'));
END;


VAR 
    s: Student;
    t: Teacher;
BEGIN
    s.Init('Student A', '12345');
    t.Init('Teacher B');

    PrintInfo(@s);
    PrintInfo(@t);

    s.Done;
    t.Done;
END.

VAR
    s: Student;
    p: Person;

BEGIN
    s.Init('Teacher 1', '12345');

    WriteLn(s.GetName, s.HasAccessTo('Lab')); // TRUE
    WriteLn(s.GetName, s.HasAccessTo('Staff Room')); // FALSE

    p := s;
    WriteLn(p.GetName);
    WriteLn(p.GetName, p.HasAccessTo('Lab'));
    WriteLn(p.GetName, p.HasAccessTo('Staff Room'));

    //t.Done; ... 

END.





VAR
    p: ^Person;
    s: ^Student;
    t: ^Teacher;
BEGIN
    New(p);
    p^.Init('Some person');

    WriteLn(p^.GetName, ' has access to "Lobby": ', p^.HasAccessTo('Lobby'));
    WriteLn(p^.GetName, ' has access to "Lab": ', p^.HasAccessTo('Lab'));
    WriteLn(p^.GetName, ' has access to "Staff Room": ', p^.HasAccessTo('Staff Room'));

    p^.Done;
    Dispose(p);


    New(s);
    s^.Init('Some student', '12345');

    s^.Done;
    Dispose(s);

    New(t);
    t^.Init('Some teacher');

    WriteLn(t^.GetName, ' has access to "Lobby": ', t^.HasAccessTo('Lobby'));
    WriteLn(t^.GetName, ' has access to "Lab": ', t^.HasAccessTo('Lab'));
    WriteLn(t^.GetName, ' has access to "Staff Room": ', t^.HasAccessTo('Staff Room'));
    Dispose(t);

END.

VAR
    p: Person;
    s: Student;
    t: Teacher;
BEGIN
    p.Init('Some person');

    WriteLn(p.GetName, ' has access to "Lobby": ', p.HasAccessTo('Lobby'));
    WriteLn(p.GetName, ' has access to "Lab": ', p.HasAccessTo('Lab'));
    WriteLn(p.GetName, ' has access to "Staff Room": ', p.HasAccessTo('Staff Room'));

    p.Done;


    s.Init('Some student', '12345');

    WriteLn(s.GetName, ' ', s.GetCode, ' has access to "Lobby": ', s.HasAccessTo('Lobby'));
    WriteLn(s.GetName, ' ', s.GetCode, ' has access to "Lab": ', s.HasAccessTo('Lab'));
    WriteLn(s.GetName, ' ', s.GetCode, ' has access to "Staff Room": ', s.HasAccessTo('Staff Room'));

    s.Done;


    t.Init('Some teacher');

    WriteLn(t.GetName, ' has access to "Lobby": ', t.HasAccessTo('Lobby'));
    WriteLn(t.GetName, ' has access to "Lab": ', t.HasAccessTo('Lab'));
    WriteLn(t.GetName, ' has access to "Staff Room": ', t.HasAccessTo('Staff Room'));

    t.Done;
END.