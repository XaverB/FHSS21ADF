(* WordCounter:                                  HDO, 2003-02-28 *)
(* -----------                                                   *)
(* Template for programs that count words in text files.         *)
(*===============================================================*)
PROGRAM WordCounter;

  USES
    WinCrt, Timer, WordReader, WordCounterChaining;

  VAR
    w: Word;
    n: LONGINT;

BEGIN (*WordCounter*)
  WriteLn('WordCounter:');
  OpenFile('Testfile_MultiOccurency.txt', toLower);
  StartTimer;
  n := 0;
  ReadWord(w);
  WHILE w <> '' DO BEGIN
    n := n + 1;
    (*insert word in data structure and count its occurence*)
    Add(w);
    ReadWord(w);
  END; (*WHILE*)
  StopTimer;
  CloseFile;
  WriteLn('number of words: ', n);
  WriteLn('elapsed time:    ', ElapsedTime);
  (*search in d
  ta structure for word with max. occurrence*)
  WriteLn('word count: ', GetWordCount);
  WriteLn('word count multiple occurencies: ', GetMultiOccurencyCount);
  WriteLn('word with highest count: ', GetHighestFrequencyWord);

END. (*WordCounter*)