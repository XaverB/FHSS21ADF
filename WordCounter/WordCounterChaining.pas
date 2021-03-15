
Unit WordCounterChaining;

INTERFACE
    (*
    * Parameter WordRecord: The word to store in the cache
    *)
    PROCEDURE Add(WordRecord : STRING);
    (*
    * Returns the most often saved word. If there are multiple words with the same occurency frequency, they will be returned with a ; seperated in a random order.
    *)
    FUNCTION GetHighestFrequencyWord: STRING;
    (*
    * Returns the count of all words, which are stored more than once.
    *)
    FUNCTION GetMultiOccurencyCount: INTEGER;
    (*
    * Returns the amount of stored words.
    *)
    FUNCTION GetWordCount: INTEGER;


IMPLEMENTATION
    TYPE
        Hash = 0..200;
        WordRecordPtr = ^WordRecord;
            WordRecord = RECORD
                word: STRING;
                count: INTEGER;
                next: WordRecordPtr;
            END;

    CONST
        alphabetCount = 26;

    VAR
        wordCounter : INTEGER;
        hashTable: ARRAY[Hash] OF WordRecordPtr;

    FUNCTION ComputeHash(name: STRING) : Hash;
    VAR
        currentIndex: INTEGER;
    BEGIN
        IF Length(name) = 0 THEN
            ComputeHash := Low(Hash)
        ELSE
            FOR currentIndex := 1 TO Length(name) DO
                ComputeHash := (currentIndex * alphabetCount + Ord(name[currentIndex])) MOD (Ord((High(Hash)) - Ord(Low(Hash)) + 1) + Ord(Low(Hash))); 

    END;
    
    PROCEDURE Add(wordRecord : STRING);
    VAR
        key: Hash;
        node: WordRecordPtr;
    BEGIN
        wordRecord := LowerCase(wordRecord);
        key := ComputeHash(wordRecord);
        node := hashTable[key];
        

        WHILE (node <> NIL) AND (node^.word <> wordRecord) DO
            node := node^.next;

        IF node = NIL THEN
        BEGIN
            node := allocmem(sizeof(WordRecord));
            node^.word := wordRecord;
            node^.count := 1;
            node^.next := NIL;
            hashTable[key] := node;
        END ELSE
            Inc(node^.count);

        Inc(wordCounter);
    END; 


FUNCTION GetHighestFrequencyWord: STRING;
VAR 
    highestOccurency: INTEGER;
    currentIndex: INTEGER;
    node: WordRecordPtr;

BEGIN
    highestOccurency := 0;
    GetHighestFrequencyWord := '';

    FOR currentIndex := LOW(Hash) TO High(Hash) DO
    BEGIN
        node := hashTable[currentIndex];
        WHILE node <> NIL DO
        BEGIN
            IF node^.count > highestOccurency THEN
            BEGIN
                highestOccurency := node^.count;
                GetHighestFrequencyWord := node^.word;
            END ELSE IF node^.count = highestOccurency THEN
                GetHighestFrequencyWord := GetHighestFrequencyWord + ';' + node^.word;
            node := node^.next;
        END;
    END;
END;

PROCEDURE DeleteNodesWithCounterHigherThan(count: INTEGER);
VAR
    currentIndex: INTEGER;
    node: WordRecordPtr;
    nodePrevious: WordRecordPtr;
BEGIN
    FOR currentIndex := LOW(Hash) TO High(Hash) DO
    BEGIN
        node := hashTable[currentIndex];
        nodePrevious := NIL;

        WHILE node <> NIL DO
        BEGIN
            IF node^.count > count THEN
            BEGIN
                IF nodePrevious = NIL THEN
                BEGIN
                    hashTable[currentIndex] := node^.next;
                    Dispose(node);
                    node := hashTable[currentIndex];
                END ELSE BEGIN
                    nodePrevious^.next := node^.next;
                    Dispose(node);
                    node := nodePrevious^.next;
                END;     
            END ELSE BEGIN
                nodePrevious := node;
                node := node^.next;
            END;
            
        END; (* END WHILE *)
            
    END; (* END FOR *)
END; 

FUNCTION GetMultiOccurencyCount: INTEGER;
VAR
    currentIndex: INTEGER;
    node: WordRecordPtr;
    counter: INTEGER;
BEGIN
    counter := 0;
    DeleteNodesWithCounterHigherThan(1);
    FOR currentIndex := LOW(Hash) TO High(Hash) DO
    BEGIN
        node := hashTable[currentIndex];
        WHILE node <> NIL DO
        BEGIN
            Inc(counter);
            node := node^.next;
        END;
    END;
    
    GetMultiOccurencyCount := counter;
END;

FUNCTION GetWordCount: INTEGER;
BEGIN
    GetWordCount := wordCounter;
END;

PROCEDURE Init;
VAR
    currentIndex: hash;
BEGIN 
    wordCounter := 0;
    FOR currentIndex := Low(Hash) TO High(Hash) DO
        hashTable[currentIndex] := NIL;
END; 

BEGIN 
    Init;
END.