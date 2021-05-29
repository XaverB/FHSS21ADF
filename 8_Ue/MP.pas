PROGRAM MP;

USES MPParser;

VAR
    inputFile: TEXT;
    ok: BOOLEAN;

BEGIN
Assign(inputFile, ParamStr(1));
Reset(inputFIle);
Parse(inputFIle, ok);

Writeln(ok);

Close(inputFile);


END.