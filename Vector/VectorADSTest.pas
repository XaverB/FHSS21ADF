PROGRAM VectorADSTest;

USES
    VectorADS;

VAR
    value: INTEGER;

BEGIN
    Writeln('Starting testrun VectorADS');
    (* no element at 1 available *)
    // GetElementAt(1, value);
    // Writeln('Element at 1:', value);
    (* element 4 is beyond the defaultSize *)
    // GetElementAt(4, value);
    // Writeln('Element at 4:', value);

    Writeln('Capacity: ', Capacity);
    Writeln('Size: ', Size);
    Add(1);
    Add(2);
    Add(3);
    Writeln('Capacity: ', Capacity);
    Writeln('Size: ', Size);
    GetElementAt(1, value);
    Writeln('Element at 1: ', value);
    GetElementAt(2, value);
    Writeln('Element at 2: ', value);
    GetElementAt(3, value);
    Writeln('Element at 3: ', value);
    Writeln('Capacity: ', Capacity);
    Writeln('Size: ', Size);


    (* this will increase the vectors capacity *)
    Add(4);
    GetElementAt(4, value);
    Writeln('Element at 4: ', value);
    Add(5);
    GetElementAt(5, value);
    Writeln('Element at 5: ', value);

    Writeln('Capacity: ', Capacity);
    Writeln('Size: ', Size);

    SetElementAt(2, -2);
    GetElementAt(2, value);
    Writeln('Element at 2 after SetElement: ', value);


    RemoveElementAt(2);
    GetElementAt(2, value);
    Writeln('Element at 2 after RemoveElementAt 2: ', value);
END.
