UNIT WordWriter;

INTERFACE

  (*
  * Opens a file for writing
  * IN fileName: full path to file
  * HALTs the applicaiton if the file does not exist
  *)
   PROCEDURE OpenFileToWrite(fileName: STRING);
  (*
  * Closes the previously opened file
  *)
   PROCEDURE CloseFileToWrite;
   (*
   * Writes a line to the opened file
   * IN lineToWrite: the string, which will be written to the line
   *)
   PROCEDURE WriteLine(lineToWrite: STRING);

IMPLEMENTATION

  USES
    WinCrt, sysutils;

  VAR
    txt: TEXT;          (*text file*)
    open: BOOLEAN;      (*file opened?*)

  PROCEDURE OpenFileToWrite(fileName: STRING);
  BEGIN
    IF open THEN
      CloseFileToWrite;
    Assign(txt, fileName);
    (*$I-*)
    Rewrite(txt);
    (*$I+*)
    IF IOResult <> 0 THEN BEGIN
      WriteLn('ERROR in WordWriter.OpenFileToWrite: file ', fileName, ' not found');
      HALT;
    END; (*IF*)
    open := TRUE;
  END; (*OpenFile*)

  (* CloseFile: closes text file                                 *)
  (*-------------------------------------------------------------*)
  PROCEDURE CloseFileToWrite;
  BEGIN
    IF open THEN BEGIN
      Close(txt);
      open := FALSE;
    END; (*IF*)
  END; (*CloseFile*)

  PROCEDURE WriteLine(lineToWrite: STRING);
  BEGIN (* WriteWord *)
    WriteLn(txt, lineToWrite);
  END; (* WriteWord *)


BEGIN (*WordWriter*)
  open := FALSE;
END. (*WordWriter*)