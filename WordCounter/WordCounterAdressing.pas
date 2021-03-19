
Unit WordCounterAdressing;

INTERFACE
    (*
    * Parameter WordRecord: The word to store in the cache.
    * Returns: TRUE if the Add operation was successful. FALSE if the operation failed (Addressing: Most likely no more space in the HashMap).
    *)
    FUNCTION Add(wordToAdd: STRING): BOOLEAN;
    (*
    * Returns the most often saved word. If there are multiple words with the same occurency frequency, they will be returned with a ; seperated in a random order.
    *)
    FUNCTION GetHighestFrequencyWord: STRING;
    (*
    * Returns the count of all words, which are stored more than once.
    * Caution: Due to special requirements, words with a occurency frequency of 1 are deleted after this function call.
    *)
    FUNCTION GetMultiOccurencyCount: LONGINT;
    (*
    * Returns the amount of stored words.
    *)
    FUNCTION GetWordCount: LONGINT;
    (*
    * Clears the cache
    *)
    PROCEDURE Clear;


IMPLEMENTATION
USES
    sysutils;

    TYPE
        Hash = 0..100000; (* Change to change Cache size. must be a odd number*)
        WordRecordPtr = ^WordRecord;
            WordRecord = RECORD
                value: STRING;
                count: INTEGER;
            END;

    CONST
        asciiCount = 256;
        deletedNode: WordRecord = (value: ''; count: 0);
        deletedNodePtr: WordRecordPtr = @deletedNode;

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
    
    FUNCTION  KeyPos(wordToAdd: STRING): LONGINT;
        VAR 
        i: Hash;
        startHash: LONGINT;
        del: LONGINT; 
    BEGIN
        i := ComputeHash(wordToAdd); 
        del := -1;
        startHash := -1;

        while (hashTable[i] <> NIL) and (hashTable[i]^.value <> wordToAdd) and (startHash <> i)do 
        BEGIN
            If startHash = -1 THEN
                startHash := i;
                
            if(del < 0) and (hashTable[i] = deletedNodePtr) then
                del := i;

            i := (i + 1) mod (Ord((High(Hash)) - Ord(Low(Hash)) + 1) + Ord(Low(Hash))); 
        END;

        if (hashTable[i] <> NIL) and (del >= 0) then
            KeyPos := del
        else
            KeyPos := i;
    END;

    FUNCTION NewNode(value: STRING): WordRecordPtr;
        VAR 
        n: WordRecordPtr;
    BEGIN 
        New(n);
        n^.value := value;
        n^.count := 1;
        NewNode := n;
    END; 

    FUNCTION Add(wordToAdd: STRING): BOOLEAN;
    VAR
        i: LONGINT;
        node: WordRecordPtr;
    BEGIN
        wordToAdd := LowerCase(wordToAdd);
        i := KeyPos(wordToAdd);
        node := hashTable[i];

        if (node = NIL) or (node = deletedNodePtr) THEN
           hashTable[i] := NewNode(wordToAdd)
        ELSE
           hashTable[i]^.count := hashTable[i]^.count + 1;
         Add := TRUE;
    END; 


    FUNCTION GetHighestFrequencyWord: STRING;
    VAR 
        highestOccurency: LONGINT;
        currentIndex: LONGINT;
        node: WordRecordPtr;

    BEGIN
        highestOccurency := 0;
        GetHighestFrequencyWord := '';
        FOR currentIndex := LOW(Hash) TO High(Hash) DO
        BEGIN
            node := hashTable[currentIndex];
            if (node <> NIL) and (node <> deletedNodePtr) then
                IF node^.count > highestOccurency THEN
                BEGIN
                    highestOccurency := node^.count;
                    GetHighestFrequencyWord := node^.value;
                END ELSE IF node^.count = highestOccurency THEN
                    GetHighestFrequencyWord := GetHighestFrequencyWord + ';' + node^.value;
            END;

        IF GetHighestFrequencyWord <> '' THEN
            GetHighestFrequencyWord := GetHighestFrequencyWord + ' ist der haeufigste String. Haeufigkeit: ' + IntToStr(highestOccurency);
    END;

    PROCEDURE DeleteNodesWithCountEqualTo(count: INTEGER);
    VAR
        currentIndex: LONGINT;
        node: WordRecordPtr;
        deleteCounter: LONGINT;
    BEGIN
        deleteCounter := 0;
        FOR currentIndex := LOW(Hash) TO High(Hash) DO
        BEGIN
            node := hashTable[currentIndex];
                IF (node <> NIL) and (node <> deletedNodePtr) and (node^.count = count) THEN
                BEGIN
                    hashTable[currentIndex] := deletedNodePtr;
                    Dispose(node);
                    Inc(deleteCounter);
                END;
        END; (* END FOR *)
    END;


    FUNCTION GetMultiOccurencyCount: LONGINT;
    VAR
        currentIndex: LONGINT;
        counter: LONGINT;
    BEGIN
        counter := 0;
        DeleteNodesWithCountEqualTo(1);
        FOR currentIndex := Low(Hash) TO High(Hash) DO
        BEGIN
            IF ((hashTable[currentIndex] <> NIL) AND (hashTable[currentIndex] <> deletedNodePtr)) THEN
                counter := counter + hashTable[currentIndex]^.count;
        END;
        
        GetMultiOccurencyCount := counter;
    END;

    FUNCTION GetWordCount: LONGINT;
        VAR
        currentIndex: LONGINT;
        counter: LONGINT;
    BEGIN
        counter := 0;
        FOR currentIndex := Low(Hash) TO High(Hash) DO
        BEGIN
            IF ((hashTable[currentIndex] <> NIL) and (hashTable[currentIndex] <> deletedNodePtr)) THEN
                counter := counter + hashTable[currentIndex]^.count;
        END;
        GetWordCount := counter;
    END;

    PROCEDURE Clear;
    VAR
        currentIndex: hash;
        node: WordRecordPtr;
    BEGIN 
        WriteLn('clearing cache');
        FOR currentIndex := Low(Hash) TO High(Hash) DO
        BEGIN
            node := hashTable[currentIndex];
            IF node <> NIL THEN
            BEGIN
                
                hashTable[currentIndex] := NIL;    
            END;
        END;

    END; 

    PROCEDURE Init;
    VAR
        currentIndex: hash;
    BEGIN 
        WriteLn('Using adressing..');
        FOR currentIndex := Low(Hash) TO High(Hash) DO
            hashTable[currentIndex] := NIL;
    END; 

    BEGIN 
        Init;
    END.