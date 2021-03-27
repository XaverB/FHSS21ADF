PROGRAM ExtendedPatternMatching;

(*
* IN s: 
* IN p:
* OUT pos: Position des gefundene Pattern in String s. Bei Missmatch = 0
*)
PROCEDURE BruteForce(s, p: String; VAR pos: BYTE);
CONST
    any = '?';
    ignore = '_';

VAR
    sLen, pLen: BYTE;
    i, j: INTEGER;
    (* we need to know how much we incremented our i due to the ignore sign to return a valid position in case of pattern found *)
    incrementDueToIgnore: INTEGER;
BEGIN
     sLen := Length(s);
     pLen := Length(p);

     i := 1;
     j := 1;
     incrementDueToIgnore := 0;

     WHILE (j <= pLen) AND (i <= sLen) DO BEGIN
        IF s[i] = ignore THEN BEGIN
            Inc(i);
            Inc(incrementDueToIgnore);
        END ELSE IF (s[i] = p[j]) OR (p[j] = any) THEN BEGIN
            Inc(i);
            Inc(j);
        END ELSE BEGIN
            i := i - (j - 1) + 1;
            j := 1;
        END; (* IF *)
     END; (* WHILE *)

    IF(j > pLen) and (pLen > 0) THEN
        pos := i - pLen - incrementDueToIgnore
    ELSE 
        pos := 0;
END;


VAR
    pos: BYTE;
BEGIN
    WriteLn('Testing BruteForce..');
    (* test cases from old brute force *)
    BruteForce('', '', pos); IF NOT (pos = 0) THEN WriteLn('1 FAILED') ELSE WriteLn('1 OK');
    BruteForce('asdf', '', pos); IF NOT (pos = 0) THEN WriteLn('2 FAILED') ELSE WriteLn('2 OK');
    BruteForce('', 'asdf', pos); IF NOT (pos = 0) THEN WriteLn('3 FAILED') ELSE WriteLn('3 OK');
    BruteForce('asdf', 'asdf', pos); IF NOT (pos = 1) THEN WriteLn('4 FAILED') ELSE WriteLn('4 OK');
    BruteForce('xxxx', 'xxxxxxx', pos); IF NOT (pos = 0) THEN WriteLn('5 FAILED') ELSE WriteLn('5 OK');
    BruteForce('abcdef', 'cde', pos); IF NOT (pos = 3) THEN WriteLn('6 FAILED') ELSE WriteLn('6 OK');
    BruteForce('abababcdef', 'abcde', pos); IF NOT (pos = 5) THEN WriteLn('7 FAILED') ELSE WriteLn('7 OK');
    BruteForce('abababcdef', 'ababcde', pos); IF NOT (pos = 3) THEN WriteLn('8 FAILED') ELSE WriteLn('8 OK');
    BruteForce('xabcdef', 'cde', pos); IF NOT (pos = 4) THEN WriteLn('9 FAILED') ELSE WriteLn('9 OK');
    BruteForce('hagenberg', 'berg', pos); IF NOT (pos = 6) THEN WriteLn('10 FAILED') ELSE WriteLn('10 OK');
    BruteForce('ababc', 'abc', pos); IF NOT (pos = 3) THEN WriteLn('12 FAILED') ELSE WriteLn('12 OK');
    BruteForce('abbca', 'abc', pos); IF NOT (pos = 0) THEN WriteLn('13 FAILED') ELSE WriteLn('13 OK');

    (* test cases for extended pattern matching*)
    BruteForce('Land der Berge', 'Berg', pos); IF NOT (pos = 10) THEN WriteLn('14 FAILED') ELSE WriteLn('14 OK');
    BruteForce('Land der Berge', 'Be?g', pos); IF NOT (pos = 10) THEN WriteLn('15 FAILED') ELSE WriteLn('15 OK');
    BruteForce('Land der Berge', 'B??g', pos); IF NOT (pos = 10) THEN WriteLn('16 FAILED') ELSE WriteLn('16 OK');
    BruteForce('Land der Berge', 'B??t', pos); IF NOT (pos = 0) THEN WriteLn('17 FAILED') ELSE WriteLn('17 OK');
    BruteForce('Land der Berge', '?er', pos); IF NOT (pos = 6) THEN WriteLn('18 FAILED') ELSE WriteLn('18 OK');
    BruteForce('var str_len: int', 'strlen', pos); IF NOT (pos = 5) THEN WriteLn('19 FAILED') ELSE WriteLn('19 OK');
    BruteForce('Die Politiker_innen', 'Politikerin', pos); IF NOT (pos = 5) THEN WriteLn('20 FAILED') ELSE WriteLn('20 OK');
    BruteForce('ab_de', 'ab?de', pos); IF NOT (pos = 0) THEN WriteLn('21 FAILED') ELSE WriteLn('21 OK');
    BruteForce('ab_cde', 'ab?de', pos); IF NOT (pos = 1) THEN WriteLn('22 FAILED') ELSE WriteLn('22 OK');

    BruteForce('abcd', '????', pos); IF NOT (pos = 1) THEN WriteLn('22 FAILED') ELSE WriteLn('22 OK');
    BruteForce('abcd_', '????', pos); IF NOT (pos = 1) THEN WriteLn('23 FAILED') ELSE WriteLn('23 OK');
    BruteForce('_', '', pos); IF NOT (pos = 0) THEN WriteLn('24 FAILED', pos) ELSE WriteLn('24 OK');
    BruteForce('a_', '?', pos); IF NOT (pos = 1) THEN WriteLn('25 FAILED') ELSE WriteLn('25 OK');
    BruteForce('_a', '?', pos); IF NOT (pos = 1) THEN WriteLn('26 FAILED') ELSE WriteLn('26 OK');
    BruteForce('_', '?', pos); IF NOT (pos = 0) THEN WriteLn('27 FAILED', pos) ELSE WriteLn('27 OK');
END.
