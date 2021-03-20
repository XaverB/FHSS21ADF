(* WordCounter:                                  HDO, 2003-02-28 *)
(* -----------                                                   *)
(* Template for programs that count words in text files.         *)
(*===============================================================*)
PROGRAM WordCounter;

  USES
    WinCrt;

FUNCTION FindLongestMatch(s1: STRING; s2: STRING; VAR sub: STRING; VAR start1: INTEGER; start2: INTEGER): STRING;
  VAR
    L: array[0..7, 0..4] of INTEGER; // length of s1 / s2
    z: INTEGER;
    i: INTEGER;
    j: INTEGER;
BEGIN
  z := 0;

  FOR i := 1 TO length(s1) DO
  BEGIN (* FOR *)
    FOR j := 1 TO length(s2) DO
    BEGIN (* FOR *)
      IF s1[i] = s2[j] THEN
      BEGIN
        IF (i = 1) or (j = 1) THEN
          L[i, j] := 1
        ELSE
          L[i, j] := L[i-1, j-1] + 1;
        IF L[i, j] > z THEN
        BEGIN
          z := L[i, j];
          FindLongestMatch := copy(s1, i-z, i); (* s1[i-z+1..i]; *)
        END
        ELSE IF L[i, j] = z THEN
          FindLongestMatch := copy(s1, i-z, i); (* ret := ret ∪ {S[i − z + 1..i]} *)
      END ELSE BEGIN
        L[i, j] := 0;
      END; 
    END;
  END;
END;

VAR 
  start: INTEGER;
  ende: INTEGER;
  sub: STRING;

BEGIN
  start := 0;
  ende := 0;

  Writeln('Longest string:', FindLongestMatch('abcdefg', 'adeb',sub, start, ende));
END.