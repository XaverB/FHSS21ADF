PROGRAM StringBuilderTest;

USES
    StringBuilders;

VAR
    strBuilder: StringBuilder;
    tabSStrBuilder: TabStringBuilder;
    stringJoiner: StringJoiner2;

PROCEDURE AssertEquals(expected: STRING; actual: STRING);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert error: expected (', expected, '), actual (', actual, ')')
END;

PROCEDURE TestStringBuilder;
BEGIN
    strBuilder.INIT;
    // check empty string on init
    AssertEquals('',strBuilder.AsString);

    strBuilder.AppendStr('Eins');
    AssertEquals('Eins',strBuilder.AsString);

    strBuilder.AppendStr('Zwei');
    AssertEquals('EinsZwei',strBuilder.AsString);

    strBuilder.AppendInt(3);
    AssertEquals('EinsZwei3',strBuilder.AsString);

    strBuilder.AppendBool(true);
    AssertEquals('EinsZwei3true',strBuilder.AsString);

    strBuilder.AppendBool(false);
    AssertEquals('EinsZwei3truefalse',strBuilder.AsString);

    strBuilder.AppendChar('!');
    AssertEquals('EinsZwei3truefalse!',strBuilder.AsString);
END;

PROCEDURE TestTabStringBuilder;
BEGIN
    tabSStrBuilder.INIT(1);
    // check empty string on init
    AssertEquals('',tabSStrBuilder.AsString);

    tabSStrBuilder.AppendStr('Eins');
    AssertEquals('Eins',tabSStrBuilder.AsString);

    tabSStrBuilder.AppendStr('Zwei');
    AssertEquals('Eins'+tab+'Zwei',tabSStrBuilder.AsString);

    tabSStrBuilder.AppendInt(3);
    AssertEquals('Eins'+tab+'Zwei'+tab+'3',tabSStrBuilder.AsString);

    tabSStrBuilder.AppendBool(true);
    AssertEquals('Eins'+tab+'Zwei'+tab+'3'+tab+'true',tabSStrBuilder.AsString);

    tabSStrBuilder.AppendBool(false);
    AssertEquals('Eins'+tab+'Zwei'+tab+'3'+tab+'true'+tab+'false',tabSStrBuilder.AsString);

    tabSStrBuilder.AppendChar('!');
    AssertEquals('Eins'+tab+'Zwei'+tab+'3'+tab+'true'+tab+'false'+tab+'!',tabSStrBuilder.AsString);
END;

PROCEDURE TestStringJoiner;
BEGIN
    stringJoiner.INIT(';');
    // check empty string on init
    AssertEquals('',stringJoiner.AsString);

    stringJoiner.Add('Eins');
    AssertEquals('Eins',stringJoiner.AsString);

    stringJoiner.Add('Zwei');
    AssertEquals('Eins;Zwei',stringJoiner.AsString);

    stringJoiner.Add('3');
    AssertEquals('Eins;Zwei;3',stringJoiner.AsString);

    stringJoiner.Add('true');
    AssertEquals('Eins;Zwei;3;true',stringJoiner.AsString);

    stringJoiner.Add('false');
    AssertEquals('Eins;Zwei;3;true;false',stringJoiner.AsString);

    stringJoiner.Add('!');
    AssertEquals('Eins;Zwei;3;true;false;!',stringJoiner.AsString);
END;

BEGIN
    Writeln('Started testrun StringBuilders...');
    TestStringBuilder;
    TestTabStringBuilder;
    TestStringJoiner;
    Writeln('Finished testrun StringBuilders...');
END.
