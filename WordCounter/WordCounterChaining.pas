
Unit WordCounterChaining;

INTERFACE
    (*
    * Parameter WordRecord: The word to store in the cache
    *)
    FUNCTION Add(wordToAdd: STRING): BOOLEAN;
    (*
    * Returns the most often saved word. If there are multiple words with the same occurency frequency, they will be returned with a ; seperated in a random order.
    *)
    FUNCTION GetHighestFrequencyWord: STRING;
    (*
    * Returns the count of all words, which are stored more than once.
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
        Hash = 0..200; (* Change to change Cache size. must be a odd number*)
        WordRecordPtr = ^WordRecord;
            WordRecord = RECORD
                value: STRING;
                count: INTEGER;
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
    
    FUNCTION NewNode(value: STRING): WordRecordPtr;
        VAR 
        n: WordRecordPtr;
    BEGIN 
        New(n);
        n^.value := value;
        n^.next := NIL;
        n^.count := 1;
        NewNode := n;
    END; 

    FUNCTION Add(wordToAdd: STRING): BOOLEAN;
    VAR
        key: Hash;
        node: WordRecordPtr;
    BEGIN
        wordToAdd := LowerCase(wordToAdd);
        key := ComputeHash(wordToAdd);
        
        IF hashTable[key] = NIL THEN
        BEGIN
            hashTable[key] := NewNode(wordToAdd);
        END ELSE BEGIN
            node := hashTable[key];
            WHILE (node^.next <> NIL) AND (node^.value <> wordToAdd) DO
                node := node^.next;

            IF node^.value <> wordToAdd THEN BEGIN
                node^.next := NewNode(wordToAdd);
            END ELSE BEGIN
                node^.count := node^.count + 1;
            END;
        END;

        Add := TRUE;
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
                    GetHighestFrequencyWord := node^.value;
                END ELSE IF node^.count = highestOccurency THEN
                    GetHighestFrequencyWord := GetHighestFrequencyWord + ';' + node^.value;
                node := node^.next;
            END;
        END;

        IF GetHighestFrequencyWord <> '' THEN
            GetHighestFrequencyWord := GetHighestFrequencyWord + ' ist der haeufigste String. Haeufigkeit: ' + IntToStr(highestOccurency);
    END;

    PROCEDURE DeleteNodesWithCountEqualTo(count: INTEGER);
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
                IF node^.count = count THEN
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


    FUNCTION GetMultiOccurencyCount: LONGINT;
    VAR
        currentIndex: INTEGER;
        node: WordRecordPtr;
        counter: LONGINT;
    BEGIN
        counter := 0;
        DeleteNodesWithCountEqualTo(1);
        FOR currentIndex := Low(Hash) TO High(Hash) DO
        BEGIN
            node := hashTable[currentIndex];
            WHILE node <> NIL DO
            BEGIN
                counter := counter + node^.count;
                node := node^.next;
            END;
        END;
        
        GetMultiOccurencyCount := counter;
    END;



    FUNCTION GetWordCount: LONGINT;
    VAR
        count: LONGINT;
        currentIndex: hash;
        node: WordRecordPtr;
        next: WordRecordPtr;
    BEGIN 
        count := 0;
        FOR currentIndex := LOW(Hash) TO High(Hash) DO
        BEGIN
            node := hashTable[currentIndex];
            next := NIL;

            WHILE node <> NIL DO
            BEGIN
                next := node^.next;
                count := count + node^.count;
                node := next;
            END; (* END WHILE *)
        END; 
        GetWordCount := count;
    END;

    PROCEDURE Clear;
    VAR
        currentIndex: hash;
        node: WordRecordPtr;
        next: WordRecordPtr;
    BEGIN 
        WriteLn('clearing cache');
        FOR currentIndex := LOW(Hash) TO High(Hash) DO
        BEGIN
            node := hashTable[currentIndex];
            next := NIL;

            WHILE node <> NIL DO
            BEGIN
                next := node^.next;
                Dispose(node);
                node := next;
            END; (* END WHILE *)
            hashTable[currentIndex] := NIL;
        END; 
    END; 

    PROCEDURE Init;
    VAR
        currentIndex: hash;
    BEGIN 
        WriteLn('Using chaining..');
        FOR currentIndex := Low(Hash) TO High(Hash) DO
            hashTable[currentIndex] := NIL;
    END; 

    BEGIN 
        Init;
    END.