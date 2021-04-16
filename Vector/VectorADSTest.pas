PROGRAM VectorADSTest;

USES
    VectorADS, sysutils;

VAR
    value: INTEGER;

PROCEDURE AssertEquals(expected: INTEGER; actual: INTEGER);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert failed! Expected: (', IntToStr(expected), '), Actual: (', IntToStr(actual),')');
END;

BEGIN
    Writeln('Starting testrun VectorADS...');
    (* no element at 1 available *)
    GetElementAt(1, value);
    AssertEquals(0, value);

    // Writeln('Element at 1:', value);
    (* element 19 is beyond the defaultSize *)
    GetElementAt(19, value);
    Writeln('Element at 19 (memory not yet occupied by us, let`s see what happens):', value);

    AssertEquals(3, Capacity);
    AssertEquals(0, Size);
    
    Add(1);
    Add(2);
    Add(3);
    AssertEquals(3, Capacity);
    AssertEquals(3, Size);
    
    GetElementAt(1, value);
    AssertEquals(1, value);
    
    GetElementAt(2, value);
    AssertEquals(2, value);
    
    GetElementAt(3, value);
    AssertEquals(3, value);

    (* this will increase the vectors capacity *)
    Add(4);
    GetElementAt(4, value);
    AssertEquals(4, value);
    
    Add(5);
    GetElementAt(5, value);
    AssertEquals(5, value);

    AssertEquals(5, capacity);
    AssertEquals(5, size);

    SetElementAt(2, -2);
    GetElementAt(2, value);
    AssertEquals(-2, value);

    AssertEquals(5, Size);
    (* this will shift all elements after the remove pos closer to 0 and reduces the size by 1*)
    RemoveElementAt(2);
    GetElementAt(2, value);
    AssertEquals(3, value);
    AssertEquals(4, Size);

    Writeln('Finished testrun VectorADS...');
END.
