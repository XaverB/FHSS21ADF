PROGRAM IO;

VAR
    f: TEXT;


BEGIN
    Assign(f, 'test.txt');
    Rewrite(f);

    Write(f, 'asdf');

    Close(f);

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