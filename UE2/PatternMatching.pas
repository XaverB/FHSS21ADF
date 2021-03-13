PROGRAM PatternMatching;

(*
* IN s: 
* IN p:
* OUT pos: Position des gefundene Pattern in String s. Bei Missmatch = 0
*)
PROCEDURE BruteForce(s, p: String; VAR pos: BYTE);
VAR
    sLen, pLen: BYTE;
    i, j: INTEGER;
BEGIN
     sLen := Length(s);
     pLen := Length(p);

     i := 1;
     j := 1;

     WHILE (j <= pLen) AND (i <= sLen) DO BEGIN
        IF s[i] = p[j] THEN BEGIN
            Inc(i);
            Inc(j);
        END ELSE BEGIN
            i := i - (j - 1) + 1;
            j := 1;
        END; (* IF *)
     END; (* WHILE *)

    IF(j > pLen) THEN
        pos := i - pLen
    ELSE 
        pos := 0;
END;


PROCEDURE KnuthMorrisPratt(s, p: String; VAR pos: BYTE);
VAR
    next: ARRAY[1..255] OF BYTE;

    PROCEDURE  InitNext;
        VAR
            sLen (*, pLen*): BYTE;
            i, j: INTEGER;
    BEGIN 
        next[1] := 0;
        sLen := Length(p);
        //pLen := Length(p);

        i := 1;
        j := 0;

        WHILE (*(j <= pLen) AND *) (i <= sLen) DO BEGIN
            IF (j = 0) OR (p[i] = p[j]) THEN BEGIN
                Inc(i);
                Inc(j);
                IF p[i] = p[j] THEN
                    next[i] := j
                ELSE
                    next[i] := j;
            END ELSE BEGIN
                //i := i + 1; (* i := i - (j - 1) + 1; *)
                j := next[j];
            END; (* IF *)
        END;
    END;


VAR
    sLen, pLen: BYTE;
    i, j: INTEGER;
BEGIN
      InitNext();
     sLen := Length(s);
     pLen := Length(p);

     i := 1;
     j := 1;

     WHILE (j <= pLen) AND (i <= sLen) DO BEGIN
        IF (j = 0) OR (s[i] = p[j]) THEN BEGIN (* j = 0 falls next[j] = 0 *)
            Inc(i);
            Inc(j);
        END ELSE BEGIN
            //i := i + 1; (* i := i - (j - 1) + 1; *)
            j := next[j];
        END; (* IF *)
     END; (* WHILE *)

    IF(j > pLen) THEN
        pos := i - pLen
    ELSE 
        pos := 0;
END;


PROCEDURE BruteForce2(s, p: String; VAR pos: BYTE);
VAR
    sLen, pLen: BYTE;
    i, j: INTEGER;
BEGIN
     sLen := Length(s);
     pLen := Length(p);

     i := pLen;
     j := pLen;

     WHILE (j > 0) AND (i <= sLen) DO BEGIN
        IF s[i] = p[j] THEN BEGIN
            Dec(i);
            Dec(j);
        END ELSE BEGIN
            i := i + (pLen - j) + 1;
            j := pLen;
        END; (* IF *)
     END; (* WHILE *)

    IF(j = 0) THEN
        pos := i + 1
    ELSE 
        pos := 0; 
END;

PROCEDURE BooyerMoore(s, p: String; VAR pos: BYTE);
VAR
    skip: ARRAY[CHAR] of BYTE;

    PROCEDURE InitSkip;
    VAR
        c: CHAR;
        i: BYTE;
    BEGIN 
        FOR c := LOW(CHAR) TO High(CHAR) DO
            skip[c] := Length(p);
        FOR i := 1 TO Length(p) DO
            skip[p[i]] := Length(p) - i;
    END;
VAR
    sLen, pLen: BYTE;
    i, j: INTEGER;
BEGIN
    InitSkip;
     sLen := Length(s);
     pLen := Length(p);

     i := pLen;
     j := pLen;

     WHILE (j > 0) AND (i <= sLen) DO BEGIN
        IF s[i] = p[j] THEN BEGIN
            Dec(i);
            Dec(j);
        END ELSE BEGIN
            i := i + skip[s[i]]; (*+ (pLen - j) + 1*)
            j := pLen;
        END; (* IF *)
     END; (* WHILE *)

    IF(j = 0) THEN
        pos := i + 1
    ELSE 
        pos := 0; 
END;


VAR
    pos: BYTE;
BEGIN
    WriteLn('Testing BruteForce..');
    BruteForce('', '', pos); IF NOT (pos = 1) THEN WriteLn('1 FAILED') ELSE WriteLn('1 OK');
    BruteForce('asdf', '', pos); IF NOT (pos = 1) THEN WriteLn('2 FAILED') ELSE WriteLn('2 OK');
    BruteForce('', 'asdf', pos); IF NOT (pos = 0) THEN WriteLn('3 FAILED') ELSE WriteLn('3 OK');
    BruteForce('asdf', 'asdf', pos); IF NOT (pos = 1) THEN WriteLn('4 FAILED') ELSE WriteLn('4 OK');
    BruteForce('xxxx', 'xxxxxxx', pos); IF NOT (pos = 0) THEN WriteLn('5 FAILED') ELSE WriteLn('5 OK');
    BruteForce('abcdef', 'cde', pos); IF NOT (pos = 3) THEN WriteLn('6 FAILED') ELSE WriteLn('6 OK');
    BruteForce('abababcdef', 'abcde', pos); IF NOT (pos = 5) THEN WriteLn('7 FAILED') ELSE WriteLn('7 OK');
    BruteForce('abababcdef', 'ababcde', pos); IF NOT (pos = 3) THEN WriteLn('8 FAILED') ELSE WriteLn('8 OK');
    BruteForce('xabcdef', 'cde', pos); IF NOT (pos = 4) THEN WriteLn('9 FAILED') ELSE WriteLn('9 OK');
    BruteForce('hagenberg', 'berg', pos); IF NOT (pos = 6) THEN WriteLn('10 FAILED') ELSE WriteLn('10 OK');

    WriteLn('Testing BruteForce2..');
    BruteForce2('', '', pos); IF NOT (pos = 1) THEN WriteLn('1 FAILED') ELSE WriteLn('1 OK');
    BruteForce2('asdf', '', pos); IF NOT (pos = 1) THEN WriteLn('2 FAILED') ELSE WriteLn('2 OK');
    BruteForce2('', 'asdf', pos); IF NOT (pos = 0) THEN WriteLn('3 FAILED') ELSE WriteLn('3 OK');
    BruteForce2('asdf', 'asdf', pos); IF NOT (pos = 1) THEN WriteLn('4 FAILED') ELSE WriteLn('4 OK');
    BruteForce2('xxxx', 'xxxxxxx', pos); IF NOT (pos = 0) THEN WriteLn('5 FAILED') ELSE WriteLn('5 OK');
    BruteForce2('abcdef', 'cde', pos); IF NOT (pos = 3) THEN WriteLn('6 FAILED') ELSE WriteLn('6 OK');
    BruteForce2('abababcdef', 'abcde', pos); IF NOT (pos = 5) THEN WriteLn('7 FAILED') ELSE WriteLn('7 OK');
    BruteForce2('abababcdef', 'ababcde', pos); IF NOT (pos = 3) THEN WriteLn('8 FAILED') ELSE WriteLn('8 OK');
    BruteForce2('xabcdef', 'cde', pos); IF NOT (pos = 4) THEN WriteLn('9 FAILED') ELSE WriteLn('9 OK');
    BruteForce2('hagenberg', 'berg', pos); IF NOT (pos = 6) THEN WriteLn('10 FAILED') ELSE WriteLn('10 OK');

    WriteLn('Testing KnuthMorrisPratt..');
    KnuthMorrisPratt('', '', pos); IF NOT (pos = 1) THEN WriteLn('1 FAILED') ELSE WriteLn('1 OK');
    KnuthMorrisPratt('asdf', '', pos); IF NOT (pos = 1) THEN WriteLn('2 FAILED') ELSE WriteLn('2 OK');
    KnuthMorrisPratt('', 'asdf', pos); IF NOT (pos = 0) THEN WriteLn('3 FAILED') ELSE WriteLn('3 OK');
    KnuthMorrisPratt('asdf', 'asdf', pos); IF NOT (pos = 1) THEN WriteLn('4 FAILED') ELSE WriteLn('4 OK');
    KnuthMorrisPratt('xxxx', 'xxxxxxx', pos); IF NOT (pos = 0) THEN WriteLn('5 FAILED') ELSE WriteLn('5 OK');
    KnuthMorrisPratt('abcdef', 'cde', pos); IF NOT (pos = 3) THEN WriteLn('6 FAILED') ELSE WriteLn('6 OK');
    KnuthMorrisPratt('abababcdef', 'abcde', pos); IF NOT (pos = 5) THEN WriteLn('7 FAILED') ELSE WriteLn('7 OK');
    KnuthMorrisPratt('abababcdef', 'ababcde', pos); IF NOT (pos = 3) THEN WriteLn('8 FAILED') ELSE WriteLn('8 OK');
    KnuthMorrisPratt('xabcdef', 'cde', pos); IF NOT (pos = 4) THEN WriteLn('9 FAILED') ELSE WriteLn('9 OK');
    KnuthMorrisPratt('hagenberg', 'berg', pos); IF NOT (pos = 6) THEN WriteLn('10 FAILED') ELSE WriteLn('10 OK');

    WriteLn('Testing BoyerMoore..');
    BooyerMoore('', '', pos); IF NOT (pos = 1) THEN WriteLn('1 FAILED') ELSE WriteLn('1 OK');
    BooyerMoore('asdf', '', pos); IF NOT (pos = 1) THEN WriteLn('2 FAILED') ELSE WriteLn('2 OK');
    BooyerMoore('', 'asdf', pos); IF NOT (pos = 0) THEN WriteLn('3 FAILED') ELSE WriteLn('3 OK');
    BooyerMoore('asdf', 'asdf', pos); IF NOT (pos = 1) THEN WriteLn('4 FAILED') ELSE WriteLn('4 OK');
    BooyerMoore('xxxx', 'xxxxxxx', pos); IF NOT (pos = 0) THEN WriteLn('5 FAILED') ELSE WriteLn('5 OK');
    BooyerMoore('abcdef', 'cde', pos); IF NOT (pos = 3) THEN WriteLn('6 FAILED') ELSE WriteLn('6 OK');
    BooyerMoore('abababcdef', 'abcde', pos); IF NOT (pos = 5) THEN WriteLn('7 FAILED') ELSE WriteLn('7 OK');
    BooyerMoore('abababcdef', 'ababcde', pos); IF NOT (pos = 3) THEN WriteLn('8 FAILED') ELSE WriteLn('8 OK');
    BooyerMoore('xabcdef', 'cde', pos); IF NOT (pos = 4) THEN WriteLn('9 FAILED') ELSE WriteLn('9 OK');
    BooyerMoore('hagenberg', 'berg', pos); IF NOT (pos = 6) THEN WriteLn('10 FAILED') ELSE WriteLn('10 OK');
    BooyerMoore('accdcd', 'cdcd', pos); IF NOT (pos = 3) THEN WriteLn('11 FAILED') ELSE WriteLn('11 OK');
END.
