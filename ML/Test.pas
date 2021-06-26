PROGRAM Test;

USES 
    MLVect, MLInt, MLStr, MLColl, MLObj;

VAR
    v: MLVector;
    i: MLInteger;
    s: MLString;
    it: MLIterator;
    o: MLObject;
BEGIN
    New(v, Init);

    New(i, Init(3));
    v^.Add(i);

    New(s, Init('Hello World'));
    v^.Add(s);

    it := v^.NewIterator;
    o := it^.next;
    WHILE o <> NIL DO BEGIN 
        Writeln(o^.AsString);
        o := it^.Next;
    END;

    Dispose(it, Done);

    Dispose(i, DONE);
    Dispose(s, DONE);

    Dispose(v, DONE);

END.