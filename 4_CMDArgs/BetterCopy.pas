PROGRAM BetterCopy;

CONST
    bufferSize = 1024 * 8;

VAR 
    source, destination: FILE OF BYTE;
    buffer: ARRAY[1..bufferSize] OF BYTE;
    result: INTEGER;
    bytesRead: LONGINT;
BEGIN
    IF ParamCount <> 2 THEN BEGIN
        Writeln('Usage: BetterCopy <sourceFile> <destinationFile>');
    END ELSE BEGIN
        AsSign(source, ParamStr(1));
        AsSign(destination, ParamStr(2));
        // disable pascal error checking
        (*$I-*) 
        Reset(source);
        (*$I+*)

        result := IOResult;
        IF result <> 0 THEN BEGIN
            Writeln('Runtime error ', IOResult);
            Halt;
        END;

        Rewrite(destination); (* implement I/O check here *)

        WHILE NOT EOF(source) DO BEGIN
            BlockRead(source, buffer, bufferSize ,bytesRead);
            BlockWrite(destination, buffer, bytesRead);
        END;
        Writeln('File copied.');

        Close(source);
        Close(destination);
    END;
END.