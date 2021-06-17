PROGRAM VectorOOPTest;

USES
    VectorOOP, sysutils;

VAR
    value1: INTEGER;
    ok: BOOLEAN;
    v1: Vector;

PROCEDURE AssertEquals(expected: INTEGER; actual: INTEGER);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert failed! Expected: (', IntToStr(expected), '), Actual: (', IntToStr(actual),')');
END;

BEGIN
    Writeln('Starting testrun VectorADT...');
    v1.Init;

    // check init size
    AssertEquals(0, v1.Size);
    
    // add some values
    v1.Add(1);
    v1.Add(2);
    v1.Add(3);

    // check the added values
    v1.GetElementAt(1, value1, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');
    AssertEquals(1, value1);

    v1.GetElementAt(2, value1, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');
    AssertEquals(2, value1);
    
    v1.GetElementAt(3, value1, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');
    AssertEquals(3, value1);

    // insert element at middle, everything should shift to +1
    v1.InsertElementAt(2, -2, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');
    
    AssertEquals(4, v1.Size);

    // check inserted element
    v1.GetElementAt(2, value1, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');
    AssertEquals(-2, value1);

    // check the shift
    v1.GetElementAt(3, value1, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');
    AssertEquals(3, value1);

    // insert <= should insert at first index and shift everything
    v1.InsertElementAt(-1, -1, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');

    // check the insert 
    v1.GetElementAt(1, value1, ok);
    IF ok = FALSE THEN
        Writeln('Something went wrong');
    AssertEquals(-1, value1);

    // check clear
    v1.Clear;
    AssertEquals(0, v1.Size);

    // checkl capacity
    AssertEquals(MaxSize, v1.Capacity);

    // check not ok when inserting above capacity
    v1.InsertElementAt(MaxSize+1, 1, ok);
    IF ok = TRUE THEN
         Writeln('v1.InsertElementAt(MaxSize+1, 1, ok); TRUE, but should be FALSE');

    v1.GetElementAt(MaxSize+1, value1, ok);
    IF ok = TRUE THEN
         Writeln('v1.GetElementAt(MaxSize+1, value1, ok); TRUE, but should be FALSE');

    Writeln('Finished testrun VectorADT...')
END.

