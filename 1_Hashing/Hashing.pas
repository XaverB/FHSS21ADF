UNIT Hashing;

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
        END;

VAR
    data: ARRAY[Hash] OF PersonPtr;


PROCEDURE AddPerson(name: STRING; VAR ok: BOOLEAN);
VAR
    h: Hash;
    n: PersonPtr;
BEGIN

    h := ComputeHash(name);
    IF (data[h] <> NIL) THEN
        ok := FALSE
    ELSE BEGIN
        New(n);
        IF n = NIL THEN
            ok := FALSE
        ELSE BEGIN 
            n^.name := name;
            data[h] := n;
            ok := TRUE;
        END;
    END;
END;

FUNCTION ContainsPerson(name: STRING): BOOLEAN;
VAR
    h: Hash;

BEGIN
    h := ComputeHash(name);
    ContainsPerson := (data[h] <> NIL) AND (data[h]^.name = name);
END;

PROCEDURE Dispaly;
VAR
    h: hash;
BEGIN
    FOR h := Low(Hash) TO High(Hash) DO BEGIN
        Write(h, '  ');
        IF(data[h] = NIL) THEN
            WriteLn('---')
        ELSE
            WriteLn(data[h]^.name);
            
    END;
END;

VAR
    h: Hash;
BEGIN 
    FOR h := Low(Hash) TO High(hash) DO
        data[h] := NIL;
END.