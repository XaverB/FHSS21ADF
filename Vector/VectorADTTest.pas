PROGRAM VectorADTTest;

USES
    VectorADT, sysutils;

VAR
    value1: INTEGER;
    value2: INTEGER;
    v1: Vector;
    v2: Vector;

PROCEDURE AssertEquals(expected: INTEGER; actual: INTEGER);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert failed! Expected: (', IntToStr(expected), '), Actual: (', IntToStr(actual),')');
END;

BEGIN
    Writeln('Starting testrun VectorADT...');
    InitVector(v1);
    InitVector(v2);

    (* we wil add some entries to v2 and look after the v1 tests, if v2 did not change (should not) *)
    AssertEquals(3, Capacity(v2));
    AssertEquals(0, Size(v2));
    
    Add(v2, 1);
    Add(v2, 2);
    Add(v2, 3);
    
    (* basic v2 tests *)
    AssertEquals(3, Capacity(v2));
    AssertEquals(3, Size(v2));
    
    GetElementAt(v2, 1, value2);
    AssertEquals(1, value2);
    
    GetElementAt(v2, 2, value2);
    AssertEquals(2, value2);
    
    GetElementAt(v2, 3, value2);
    AssertEquals(3, value2);

    (* start with v1 tests *)

    (* no element at 1 available *)
    GetElementAt(v1, 1, value1);
    AssertEquals(0, value1);

    (* basic tests for v1 *)
    AssertEquals(3, Capacity(v1));
    AssertEquals(0, Size(v1));
    
    Add(v1, 1);
    Add(v1, 2);
    Add(v1, 3);

    AssertEquals(3, Capacity(v1));
    AssertEquals(3, Size(v1));
    
    GetElementAt(v1, 1, value1);
    AssertEquals(1, value1);
    
    GetElementAt(v1, 2, value1);
    AssertEquals(2, value1);
    
    GetElementAt(v1, 3, value1);
    AssertEquals(3, value1);
    
    (* this will increase the vectors capacity *)
    Add(v1, 4);
    AssertEquals(4, Capacity(v1));
    AssertEquals(4, Size(v1));

    GetElementAt(v1, 4, value1);
    AssertEquals(4, value1);
    
    Add(v1, 5);
    GetElementAt(v1, 5, value1);
    AssertEquals(5, value1);
    
    AssertEquals(5, Capacity(v1));
    AssertEquals(5, Size(v1));

    (* overwrite existing element -> should change value and not change size *)
    SetElementAt(v1, 2, -2);
    GetElementAt(v1, 2, value1);
    AssertEquals(-2, value1);
    AssertEquals(5, Size(v1));

    (* remove will shift all elements after the remove pos closer to 0 and reduces the size by 1 *)
    RemoveElementAt(v1, 2);
    GetElementAt(v1, 1, value1);
    AssertEquals(1, value1);

    GetElementAt(v1, 2, value1);
    AssertEquals(3, value1); 
    AssertEquals(4, Size(v1));

    (* removing the first element *)
    RemoveElementAt(v1, 1);
    GetElementAt(v1, 1, value1);
    AssertEquals(3, value1);
    AssertEquals(3, Size(v1));
    
    (* removing the last element *)
    RemoveElementAt(v1, 3);
    AssertEquals(2, Size(v1));

    (* removing a element, which does not exist -> should not change size *)
    RemoveElementAt(v1, 5);
    AssertEquals(2, Size(v1));

    (* same tests for v2 as in the beginning -> we did not touch v2 after the basic tests *)
    AssertEquals(3, Capacity(v2));
    AssertEquals(3, Size(v2));
    
    GetElementAt(v2, 1, value2);
    AssertEquals(1, value2);
    
    GetElementAt(v2, 2, value2);
    AssertEquals(2, value2);
    
    GetElementAt(v2, 3, value2);
    AssertEquals(3, value2);


    DisposeVector(v1);
    DisposeVector(v2);
    Writeln('Finished testrun VectorADT...')
END.

