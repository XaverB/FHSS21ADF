PROGRAM FH;

TYPE
    Person = OBJECT
            PROCEDURE Init(name: STRING);
            PROCEDURE Done;

            FUNCTION GetName: STRING;
            FUNCTION HasAccessTo(room: STRING): BOOLEAN;
        PRIVATE
            _name: STRING;
    END;
    Student = OBJECT(Person)
            PROCEDURE Init(name, code: STRING); // overridden method (can have different parameters)

            FUNCTION HasAccessTo(room: STRING): BOOLEAN;
            FUNCTION GetCode: STRING; // new method
        PRIVATE
            _code: STRING; // new member
    END;
    Teacher = OBJECT(Person)
            FUNCTION HasAccessTo(room: STRING): BOOLEAN;
    END;

PROCEDURE Person.Init(name: STRING);
BEGIN
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

PROCEDURE Student.Init(name, code: STRING);
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