PROGRAM IO;



VAR
    f1, f2: FILE OF BYTE;
    b: BYTE;
    source, destination: STRING;
BEGIN
    Readln(source);
    Readln(destination);

    Assign(f1, source);
    Assign(f2, destination);
    

    Reset(f1); // read
    Rewrite(f2); // ersetzen

    WHILE NOT EOF(f1) DO BEGIN
        Read(f1, b);
        Write(f2, b);
    END;

    
    Close(f1);
    Close(f2);
END.








TYPE
    x = RECORD
            a: INTEGER;
            b: REAL;
            c: STRING;
        END;

VAR
    f: FILE OF X;
    foo: X
BEGIN
    Assign(f, 'out.txt');
    Rewrite(f);
    foo := A;
    Write(f, 'hallo', ' ', 123, 123);
    Close(f);
END.





VAR
    f1, f2: TEXT;
    c: CHAR;
    source, destination: STRING;
BEGIN
    Readln(source);
    Readln(destination);

    Assign(f1, source);
    Assign(f2, destination);
    

    Reset(f1); // read
    Rewrite(f2); // ersetzen

    WHILE NOT EOF(f1) DO BEGIN
        Read(f1, c);
        Write(f2, c);
    END;

    
    Close(f1);
    Close(f2);
END.












VAR
    s: STRING;
BEGIN
    Writeln(StdErr, 'Reading..');
    Readln(Input, s);
    Writeln(StdErr, 'Done!');
    Writeln(Output, s);
    Writeln(StdErr, 'Done!');

    Close(Output);

END.