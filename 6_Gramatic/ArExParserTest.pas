PROGRAM ArExParserTest;

USES
    ArExParser;

BEGIN
    WriteLn(Parse(ParamStr(1)));
END.