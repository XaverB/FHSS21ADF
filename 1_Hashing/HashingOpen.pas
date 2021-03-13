UNIT HashingOpen;

INTERFACE

PROCEDURE AddPerson(name: STRING; VAR ok: BOOLEAN);
FUNCTION ContainsPerson(name: STRING): BOOLEAN;
PROCEDURE Dispaly;

IMPLEMENTATION

TYPE 
    Hash = 0..9;

FUNCTION ComputeHash(name: STRING) : Hash;
BEGIN
    IF Length(name) = 0 THEN
        ComputeHash := Low(Hash)
    ELSE
        ComputeHash := Ord(name[1]) MOD (Ord((High(Hash)) - Ord(Low(Hash)) + 1) + Ord(Low(Hash)))
    
END;

TYPE
    PersonPtr = ^Person;
        Person = RECORD
            name: STRING;
            next: PersonPtr; (* NEW *)
        END;

VAR
    data: ARRAY[Hash] OF PersonPtr;


PROCEDURE AddPerson(name: STRING; VAR ok: BOOLEAN);
VAR
    h: Hash;
    n: PersonPtr;
BEGIN

    h := ComputeHash(name);
    New(n);
    IF n = NIL THEN
        ok := FALSE
    ELSE BEGIN 
        n^.name := name;
        n^.next := data[h]; (* NEW *)
        data[h] := n;
        ok := TRUE;
    END;
END;

FUNCTION ContainsPerson(name: STRING): BOOLEAN;
VAR
    h: Hash;
    n: PersonPtr;
BEGIN
    h := ComputeHash(name);
    n := data[h];
    WHILE (n <> NIL) and (n^.name <> name) DO
        n := n^.next;
    
    ContainsPerson := n <> NIL;
END;

PROCEDURE Dispaly;
VAR
    h: hash;
    n: PersonPtr;
BEGIN
    FOR h := Low(Hash) TO High(Hash) DO BEGIN
        Write(h);
        n := data[h];
        WHILE n <> NIL DO BEGIN
            Write(' ', n^.name);
            n := n^.next;
        END;
        WriteLn;
    END;
END;

VAR
    h: Hash;
BEGIN 
    FOR h := Low(Hash) TO High(hash) DO
        data[h] := NIL;
END.