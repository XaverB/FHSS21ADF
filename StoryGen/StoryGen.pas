PROGRAM StoryGen;

USES
    sysutils, WordReader, WordWriter, ReplacementCache;

CONST
    desiredParameterCount = 3;
    replacementPathArgumentIndex = 1;
    sourcePathArgumentIndex = 2;
    destinationPathArgumentIndex = 3;

VAR
    sourcePath: STRING;
    destinationPath: STRING;
    replacementPath: STRING;

PROCEDURE InitializeReplacementCache;
VAR
    sourceWord: STRING;
    destinationWord: STRING;
    success: BOOLEAN;
    
BEGIN
    success := FALSE;
    destinationWord := '';
    sourceWord := '';

    OpenFile(replacementPath);
    ReadReplacementDataFromNextLine(sourceWord, destinationWord, success);
    WHILE (success) DO BEGIN
        AddReplacement(sourceWord, destinationWord);
        ReadReplacementDataFromNextLine(sourceWord, destinationWord, success);
    END; (*WHILE*)
    CloseFile;
END;

FUNCTION Concat(line: STRING; wordToAdd: STRING) : STRING;
VAR
    result: STRING;
BEGIN
    IF (line = '') OR (line = ' ') THEN
        result := wordToAdd
    ELSE IF (wordToAdd = '') or (wordToAdd = ' ') THEN
        result := line
    ELSE
        result := line + ' ' + wordToAdd;
    
    Concat := result;
END;


FUNCTION ReplaceWord(sourceWord: STRING): STRING;
VAR
    currentWordDestination: STRING;
BEGIN
    currentWordDestination := '';
    currentWordDestination := GetReplacement(sourceWord);
    IF(currentWordDestination = '') THEN
        currentWordDestination := sourceWord;

    ReplaceWord := currentWordDestination;
END;

FUNCTION GetProcessedLine(sourceLine: STRING): STRING;
VAR
    destinationLine: STRING;
    currentWordSource: STRING;
    currentWordDestination: STRING;
    i: INTEGER;
    
BEGIN
    i := 1;
    destinationLine := '';
    currentWordSource := '';
    currentWordDestination := '';

    IF sourceLine <> '' THEN 
    BEGIN
        WHILE i <= Length(sourceLine) DO
        BEGIN
            (* current word end -> build replacement and add to line *)
            IF (sourceLine[i] = ' ') OR (sourceLine[i] = '.') OR (sourceLine[i] = '!') OR (sourceLine[i] = '?') OR (sourceLine[i] = ',') THEN
            BEGIN
                currentWordDestination := ReplaceWord(currentWordSource);
                destinationLine := Concat(destinationLine, currentWordDestination);
                // append punctuation if current character is one
                IF sourceLine[i] <> ' ' THEN
                    destinationLine := destinationLine + sourceLine[i];

                // new word
                currentWordSource := '';
            (* currente word not ending --> append currentWortSource *)
            END ELSE BEGIN
                // build current word. we could use Copy, but we are iterating through the characters anyway -> we save some memory
                currentWordSource := currentWordSource + sourceLine[i];

                (* special case: last word in this line -> build replacement and add to line or we would miss it *)
                IF i + 1 > Length(sourceLine) THEN
                BEGIN
                    currentWordDestination := ReplaceWord(currentWordSource);
                    destinationLine := Concat(destinationLine, currentWordDestination);
                END;
            END;
        Inc(i);
        END; (* END WHILE *)
    END; (* END IF *)

    GetProcessedLine := destinationLine;
END;

PROCEDURE Generate;
VAR
    line: STRING;
    destinationLine: STRING;
BEGIN
    Writeln('Starting generation process..');
    line := '';
    destinationLine := '';

    WriteLn('Source file: ', sourcePath);
    WriteLn('Destination file: ', destinationPath);
    OpenFile(sourcePath);
    OpenFileToWrite(destinationPath);

    ReadLine(line);
    WHILE (line <> EF) DO BEGIN
        destinationLine := GetProcessedLine(line);
        WriteLine(destinationLine);
        ReadLine(line);
    END; (*WHILE*)

  CloseFile;
  CloseFileToWrite;
  Writeln('Generation process finished..');
END;


BEGIN
    IF ParamCount <> desiredParameterCount THEN
    BEGIN
        Writeln('ParamCount: (', ParamCount ,'). Usage: StoryGen <ReplacementPath> <OldStoryPath> <NewStoryPath>');
    END ELSE BEGIN
        (* process cmd args *)
        replacementPath := ParamStr(replacementPathArgumentIndex);
        sourcePath := ParamStr(sourcePathArgumentIndex);
        destinationPath := ParamStr(destinationPathArgumentIndex);

        DeleteFile(destinationPath);

        InitializeReplacementCache;
        Generate;
    END;
END.