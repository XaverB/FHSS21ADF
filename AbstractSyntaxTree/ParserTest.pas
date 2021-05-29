PROGRAM ParserTest;

USES
    Parser, sysutils;

VAR
    ok: BOOLEAN;
    value: INTEGER;
    expression: STRING;

PROCEDURE AssertEquals(expected: INTEGER; actual: INTEGER);
BEGIN
    IF expected <> actual THEN
        Writeln('Assert failed! Expected: (', IntToStr(expected), '), Actual: (', IntToStr(actual),')');
END;

PROCEDURE AssertTrue(actual: BOOLEAN; expression: STRING);
BEGIN
    IF actual <> TRUE THEN
        Writeln('Expression not true. Expression: ', expression);
END;

PROCEDURE AssertFalse(actual: BOOLEAN; expression: STRING);
BEGIN
    IF actual <> FALSE THEN
        Writeln('Expression not false. Expression: ', expression);
END;

BEGIN

    (* simple addition *)
    expression := '1+1';
    ok := Parse(expression, value);
    AssertTrue(ok, expression);
    AssertEquals(2 ,value);

    (* 1*2 must be evaluated first *)
    expression := '1+1*2';
    ok := Parse(expression, value);
    AssertTrue(ok, expression);
    AssertEquals(3 ,value);

    (* 1+1 must be evaluated first *)
    expression := '(1+1)*2';
    ok := Parse(expression, value);
    AssertTrue(ok, expression);
    AssertEquals(4 ,value);

    (* 1*2 must be evaluated first *)
    expression := '1+(1*2)';
    ok := Parse(expression, value);
    AssertTrue(ok, expression);
    AssertEquals(3 ,value);

    (* more advanced expression. 1*2 must be evaluated first *)
    expression := '1+(1*2)+1';
    ok := Parse(expression, value);
    AssertTrue(ok, expression);
    AssertEquals(4 ,value);

    (* more advanced expression. 1*2 must be evaluated first, followed by 1*2 *)
    expression := '1+(1*2)+1*2';
    ok := Parse(expression, value);
    AssertTrue(ok, expression);
    AssertEquals(5 ,value);

    (* more advanced expression, including multiple parathesis and a division *)
    expression := '(1+(1*2)+1*2)/5';
    ok := Parse(expression, value);
    AssertTrue(ok, expression);
    AssertEquals(1 ,value);

    (* ok must be false because this expression is not valid - missing ) *)
    expression := '1+(1*2';
    ok := Parse(expression, value);
    AssertFalse(ok, expression);

    (* program will halt and an error message will be displayed *)
    expression := '1+0';
    ok := Parse(expression, value);
END.