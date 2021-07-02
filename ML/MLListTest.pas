PROGRAM MLListeTest;

USES
    MLColl, MLListe, MLInt, MLStr, sysutils;

VAR
    list: MLList;
    iV: MLInteger;
    sVal: MLString;
    it: MLIterator;
    i: INTEGER;
    b: BOOLEAN;

PROCEDURE AssertEquals(expected: INTEGER; actual: INTEGER);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert error. expected: ', IntToStr(expected), ', actual: ', IntToStr(actual));
END;

PROCEDURE AssertEqualsString(expected: STRING; actual: STRING);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert error. expected: ', expected, ', actual: ', actual);
END;

PROCEDURE AssertTrue(actual: BOOLEAN);
BEGIN
    IF not actual THEN
        Writeln('Assert error. expected true');
END;

PROCEDURE TestInteger;
BEGIN
    // create new list object
    New(list, Init);
    
    // add three elements 
    New(iV, Init(1));
    list^.Add(iV);

    New(iV, Init(2));
    list^.Add(iV);

    New(iV, Init(3));
    list^.Add(iV);

    // append element at begin
    New(iV, Init(0));
    list^.Prepend(iV);

    // create iterator and check each added value
    it := list^.NewIterator;
    iV := MLInteger(it^.next);
    i := 0;
    WHILE iV <> NIL DO BEGIN
        AssertEquals(i, iV^.val);
        Inc(i);
        iV := MLInteger(it^.next);
    END;
    Dispose(it, Done);

    // check size
    AssertEquals(4, list^.Size);

    // get first element and check contains
    it := list^.NewIterator;
    iV := MLInteger(it^.next);
    Dispose(it, DONE);
    b := list^.contains(iV);
    AssertTrue(b);

    // remove element and check size
    iV := MLInteger(list^.Remove(iV));
    AssertEquals(3, list^.Size);
    AssertTrue(iV <> NIL);

    // clear list and check size
    list^.clear;
    AssertEquals(0, list^.Size);

    Dispose(list, DONE);
END;

PROCEDURE TestString;
BEGIN
    // create new list object
    New(list, Init);

    // add three elements 
    New(sVal, Init('1'));
    list^.Add(sVal);

    New(sVal, Init('2'));
    list^.Add(sVal);

    list^.Add(sVal);

    // append element at begin
    New(sVal, Init('0'));
    list^.Prepend(sVal);

    // create iterator and check each added value
    it:= list^.NewIterator;
    sVal:= MLString(it^.next);
    i := 0;
    WHILE sVal <> NIL DO BEGIN
        AssertEqualsString(IntToStr(i), sVal^.AsString);
        Inc(i);
        sVal := MlString(it^.next);
    END;
    Dispose(it, Done);

    // check size
    AssertEquals(4, list^.Size);

    // get first element and check contains
    it := list^.NewIterator;
    sVal := MlString(it^.next);
    Dispose(it, DONE);
    b := list^.contains(sVal);
    AssertTrue(b);

    // remove element and check size
    sVal := MLString(list^.Remove(sVal));
    AssertEquals(3, list^.Size);
    AssertTrue(sVal <> NIL);

    // clear list and check size
    list^.clear;
    AssertEquals(0, list^.Size);

    Dispose(list, DONE);
END;

BEGIN
    Writeln('-- starting testrun MLList --');
    Writeln('testing integer..');
    TestInteger;
    Writeln('testing string..');
    TestString;
    Writeln('-- finished testrun MLList --');
END.