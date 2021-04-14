
Unit ReplacementCache;

INTERFACE
    (*
    * Adds a replacement entry to the in memory cache
    * IN sourceWord: the key
    * IN destinationWord: the replacement entry
    *)
    FUNCTION AddReplacement(sourceWord: STRING; destinationWord: STRING): BOOLEAN;
    (*
    * Returns a replacement entry for a specific key
    * IN sourceWord: the key for looking up the replacement entry
    * Will return an empty string, if no entry was found for sourceWord
    *)
    FUNCTION GetReplacement(sourceWord: STRING) : STRING;

IMPLEMENTATION
USES
    sysutils;

    TYPE
        Hash = 0..200;
        WordRecordPtr = ^WordRecord;
            WordRecord = RECORD
                source: STRING;
                destination: STRING;
                next: WordRecordPtr;
            END;

    CONST
        asciiCount = 256;

    VAR
        hashTable: ARRAY[Hash] OF WordRecordPtr;


    FUNCTION ComputeHash(name: STRING) : Hash;
    VAR
        currentIndex: LONGINT;
        h: LONGINT;
    BEGIN
        h := 0;
        IF Length(name) = 0 THEN
            ComputeHash := Low(Hash)
        ELSE
            FOR currentIndex := 1 TO Length(name) DO
                h := (h * asciiCount + Ord(name[currentIndex])) MOD (Ord((High(Hash)) - Ord(Low(Hash)) + 1) + Ord(Low(Hash))); 
        ComputeHash := h;
    END;
    
    FUNCTION NewNode(source: STRING; destination: STRING): WordRecordPtr;
       VAR 
        n: WordRecordPtr;
    BEGIN 
        New(n);
        n^.source := source;
        n^.destination := destination;
        n^.next := NIL;
        NewNode := n;
    END; 

    FUNCTION AddReplacement(sourceWord: STRING; destinationWord: STRING): BOOLEAN;
    VAR
        key: Hash;
        node: WordRecordPtr;
    BEGIN
        sourceWord := sourceWord;
        key := ComputeHash(sourceWord);
        
        IF hashTable[key] = NIL THEN
        BEGIN
            hashTable[key] := NewNode(sourceWord, destinationWord);
        END ELSE BEGIN
            node := hashTable[key];
            WHILE (node^.next <> NIL) AND (node^.source <> sourceWord) DO
                node := node^.next;

            IF node^.source <> sourceWord THEN 
                node^.next := NewNode(sourceWord, destinationWord)
        END;

        AddReplacement := TRUE;
    END; 

    FUNCTION GetReplacement(sourceWord: STRING): STRING;
    VAR 
        node: WordRecordPtr;
        destinationWord: STRING;
        hash: INTEGER;
    BEGIN
        hash := ComputeHash(sourceWord);
        destinationWord := '';
        

        node := hashTable[hash];
        WHILE (node <> NIL) AND (destinationWord = '') DO
        BEGIN
            IF node^.source = sourceWord THEN
                destinationWord := node^.destination;
            node := node^.next;
        END;

        GetReplacement := destinationWord;
    END;



    PROCEDURE Init;
    VAR
        currentIndex: hash;
    BEGIN 
        FOR currentIndex := Low(Hash) TO High(Hash) DO
            hashTable[currentIndex] := NIL;
    END;
    BEGIN 
        Init;
    END.