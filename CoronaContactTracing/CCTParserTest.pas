PROGRAM CCTParserTest;

USES CCTParser;

VAR
    inputFile: TEXT;
    ok: BOOLEAN;
    count: INTEGER;

BEGIN
    Writeln('-----------------------------------');
    Writeln('testing file: ', ParamStr(1));

    Assign(inputFile, ParamStr(1));
    Reset(inputFIle);
    Parse(inputFIle, ok, count);
    Close(inputFile);

    Writeln('ok: ', ok);
    Writeln('count: ', count);
    Writeln('-----------------------------------');
END.