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
    canInsert: BOOLEAN;


PROCEDURE RunTest(filename: STRING);
BEGIN
  canInsert := TRUE;
  WriteLn('-------------------');
  WriteLn('Testing file:', filename);
  WriteLn('-------------------');
  WriteLn('WordCounter:');
  OpenFile(filename, toLower);
  StartTimer;

  n := 0;
  ReadWord(w);
  WHILE (w <> '') and (canInsert) DO BEGIN
    n := n + 1;
    canInsert := Add(w);
    ReadWord(w);
  END; (*WHILE*)
  CloseFile;

  WriteLn('number of words read: ', n);
  WriteLn('word count in hashtable: ', GetWordCount);
  WriteLn('word with highest count: ', GetHighestFrequencyWord);
  WriteLn('word count multiple occurencies: ', GetMultiOccurencyCount);
  StopTimer;
  WriteLn('elapsed time:    ', ElapsedTime);
END;

BEGIN (*WordCounter*)
  RunTest('Kafka.txt');
  Clear;
  
  RunTest('Testfile_MultiOccurency.txt');
  Clear;

  RunTest('Testfile_SingleWordsOnly.txt');
  Clear;

  RunTest('Testfile_OneDuplicatedWord.txt');
  Clear;

  RunTest('Testfile_empty.txt');
  Clear;
END. (*WordCounter*)