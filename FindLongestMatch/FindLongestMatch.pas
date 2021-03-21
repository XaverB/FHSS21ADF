(* FildLongestMatch:                 Xaver Buttinger, 21.03.2021 *)
(* -----------                                                   *)
(* Find Longest subsequence in two string and set subs / position*)
(*===============================================================*)
PROGRAM WordCounter;

  USES
    WinCrt, sysutils;

(*
* Find the longest common subsequence in two strings. If there are multiple subsequences with equal length, the first one will be processed.
* s1 IN: String1 for matching
* s2 IN: String2 for matching
* sub OUT: longest common subsequence. '' if there are no matches
* Start1 OUT: start position of longest common subsequence in s1
* Start2 OUT: start position of longest common subsequence in s2
*)
PROCEDURE FindLongestMatch(s1: STRING; s2: STRING; VAR sub: STRING; VAR start1: INTEGER; VAR start2: INTEGER);
  CONST
    maxStringLength = 50;

  VAR
    (* table for storing lengths of common substrings
     * lengthMatrix [i][j] = length of s1[i-1] and s2[j-1]
    *)
    lengthMatrix : array[0..maxStringLength+1, 0..maxStringLength+1] of INTEGER;
    lenghtOfLongestMatch: INTEGER;
    lengthString2: INTEGER;
    lengthString1: INTEGER;
    i,j : INTEGER;
    

BEGIN
  lengthString1 := Length(s1) + 1;
  lengthString2 := Length(s2) + 1;
  lenghtOfLongestMatch := 0;
  sub := '';

  i := 0;
  WHILE i <= lengthString1 DO BEGIN
    j := 0;
    WHILE j <= lengthString2 DO BEGIN
      IF (i = 0) OR (j = 0) THEN BEGIN
        (* just init our first row / column with 0 *)
        lengthMatrix[i,j] := 0;
      END (* IF *)
      ELSE IF s1[i-1] = s2[j-1] THEN BEGIN
        (* get value from last iteration and +1 *)
        lengthMatrix[i, j] := lengthMatrix[i - 1, j - 1] + 1;

        (* new longest match => set out values *)
        IF lenghtOfLongestMatch < lengthMatrix[i,j] THEN BEGIN
          lenghtOfLongestMatch := lengthMatrix[i,j];
          start1 := i-lenghtOfLongestMatch;
          start2 := j-lenghtOfLongestMatch;
          sub := copy(s1, start1, lenghtOfLongestMatch);
        END;
      END ELSE BEGIN
        lengthMatrix[i, j] := 0;
      END;
      Inc(j);
    END; (* END WHILE j <= n *)
    Inc(i);
  END; (* END WHILE i <= m *)
END;


PROCEDURE TestRun(string1: STRING; string2: STRING; expectedSubstring: STRING; expectedStart1: INTEGER; expectedStart2: INTEGER);
VAR
  start1: INTEGER;
  start2: INTEGER;
  sub: STRING;
BEGIN
  sub := '';
  start1 := 0;
  start2 := 0;
  Writeln('Running test with string1: (' + string1 + '), string2: (' + string2 +'), expectedSubstring: (' + expectedSubstring + '), expectedStart1: (' + IntToStr(expectedStart1) + '), expectedStart2: (' , IntToStr(expectedStart2) + ')');  
  FindLongestMatch(string1, string2, sub, start1, start2);

  IF (expectedSubstring <> sub) OR (expectedStart1 <> start1) OR (expectedStart2 <> start2) THEN BEGIN;
    Writeln('Test run failed! Sub: (' + sub + '), start1: (' + IntToStr(start1) + '), start2: (' + IntToStr(start2) + ')');
  END;

  Writeln();
END;

BEGIN
  Writeln('--------------------------');
  Writeln('--- Starting testsuite ---');
  Writeln('--------------------------');
  Writeln();

  TestRun('', '', '', 0, 0);
  TestRun('Hagenberg', 'Hagenberg', 'Hagenberg', 0, 0);
  TestRun('abcdefg', 'adeb', 'de', 4, 2);
  TestRun('adeb', 'abcdefg', 'de', 2, 4);
  TestRun('Hagenberg', 'berg', 'berg', 6, 1);
  TestRun('berg', 'Hagenberg', 'berg', 1, 6);
  TestRun('a', 'ab', 'a', 1, 1);
  TestRun('a', 'ba', 'a', 1, 2);
  TestRun('ab', 'a', 'a', 1, 1);
  TestRun('ba', 'a', 'a', 2, 1);
  TestRun('a', '', '', 0, 0);
  TestRun('', 'a', '', 0, 0);
  TestRun('Das ist ein super Text.', 'Der hier ist auch ein super Text.', ' ein super Text.', 8, 18);

  Writeln('--------------------------');
  Writeln('--- Finished testsuite ---');
  Writeln('--------------------------');
END.