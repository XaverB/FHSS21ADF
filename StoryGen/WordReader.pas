(* WordReader:                                     HDO, 03-02-27 *)
(*                                         Modified BX, 02.04.21 *)
(* ----------                                                    *)
(* Reads a text file word (= seq. of characters) by line.        *)
(* Sepcial Procedures for Replacement cache initializiation      *)
(*===============================================================*)
UNIT WordReader;

INTERFACE
  CONST
    EF = CHR(0);

  (*
  * Opens a file for reading
  * IN fileName: full path to file
  * HALTs the applicaiton if the file does not exist
  *)
   PROCEDURE OpenFile(fileName: STRING);
   (*
   * Closes the previously opened file
   *)
   PROCEDURE CloseFile;
   (*
   * Reads a line from the opened file
   * OUT lineFromFile: the read line. EF if there are no more lines to read
   * 
   *)
   PROCEDURE ReadLine(var lineFromFile: STRING);
   (*
   * Reads a line from the opened file. The file content must be as following per line: <Word Word>
   * OUT sourceWord: the first word in the current line
   * OUT destinationWord: the second word in the current line 
   * success: 
   *)
   PROCEDURE ReadReplacementDataFromNextLine(var sourceWord: STRING; var destinationWord: STRING; var success: BOOLEAN);

IMPLEMENTATION

  USES
    WinCrt, sysutils;

  VAR
    txt: TEXT;          (*text file*)
    open: BOOLEAN;      (*file opened?*)

  
  (* OpenFile: opens text file named fileName                    *)
  (*-------------------------------------------------------------*)
  PROCEDURE OpenFile(fileName: STRING);
  BEGIN
    IF open THEN
      CloseFile;
    Assign(txt, fileName);
    (*$I-*)
    Reset(txt);
    (*$I+*)
    IF IOResult <> 0 THEN BEGIN
      WriteLn('ERROR in WordReader.OpenFile: file ', fileName, ' not found');
      HALT;
    END; (*IF*)
    open := TRUE;
  END; (*OpenFile*)


  (* CloseFile: closes text file                                 *)
  (*-------------------------------------------------------------*)
  PROCEDURE CloseFile;
  BEGIN
    IF open THEN BEGIN
      Close(txt);
      open := FALSE;
    END; (*IF*)
  END; (*CloseFile*)

  PROCEDURE ReadLine(var lineFromFile: STRING);
  BEGIN
    lineFromFile := '';
    IF NOT EOF(txt) THEN
      readln(txt, lineFromFile)
    ELSE
      lineFromFile := EF;
  END;

  PROCEDURE ReadReplacementDataFromNextLine(var sourceWord: STRING; var destinationWord: STRING; var success: BOOLEAN);
  VAR
    lineFromFile: STRING;
    i: INTEGER;
    spacePosition: INTEGER;
  BEGIN
    sourceWord := '';
    destinationWord := '';
    success := FALSE;
    spacePosition := -1;
    i := 0;
    ReadLine(lineFromFile);

    IF lineFromFile <> EF THEN
    BEGIN
      (* let's look for the space *)
      REPEAT
      BEGIN
        IF (lineFromFile[i] = ' ') OR (lineFromFile[i] = '.') OR (lineFromFile[i] = '!') OR (lineFromFile[i] = '?') OR (lineFromFile[i] = ',') THEN BEGIN
          spacePosition := i;
        END; (* IF *)
        Inc(i);
      END; (* END WHILE *)
      UNTIL (i < Length(lineFromFile)) AND (spacePosition <> -1);

      (* index of space found *)
      IF spacePosition <> -1 THEN 
      BEGIN
        sourceWord := Copy(lineFromFile, 0, spacePosition-1);
        destinationWord := Copy(lineFromFile, spacePosition+1, Length(lineFromFile) - spacePosition + 1);
        success := TRUE;
      (* no space available -> error in file structure *)
      END ELSE BEGIN
        success := FALSE;
      END; (* IF *)
    END; (*IF *)
  END;



BEGIN (*WordReader*)
  open := FALSE;
END. (*WordReader*)