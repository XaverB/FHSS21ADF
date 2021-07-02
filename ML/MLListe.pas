(*MLList:                                             
  ------
  Classes MLList and MLListIterator.
========================================================================*)
UNIT MLListe;

INTERFACE

  USES
    MLObj, MLColl;

  TYPE
    MLListNodePtr = ^MLListNode;
    MLListNode = RECORD
        value: MLObject;
        next: MLListNodePtr;
    END;

    MLListIterator = ^MLListIteratorObj;  (*full declaration below MLList*)


(*=== class MLVector ===*)

    MLList = ^MLListObj;
    MLListObj = OBJECT(MLCollectionObj)
      CONSTRUCTOR Init;
      DESTRUCTOR Done; VIRTUAL;

(*--- overridden "abstract" methods ---*)

      FUNCTION Size: INTEGER; VIRTUAL;
      (*returns number of elements in collection*)

      PROCEDURE Add(o: MLObject); VIRTUAL;
      (*adds element at right end*)

      PROCEDURE Prepend(o: MLObject);
      (*adds element at start*)

      FUNCTION Remove(o: MLObject): MLObject; VIRTUAL;
      (*removes first element = o, shifts rest to the left
        and returns removed element*)

      FUNCTION Contains(o: MLObject): BOOLEAN; VIRTUAL;
      (*returns whether collection contains an element = o*)

      PROCEDURE Clear; VIRTUAL;
      (*removes all elements WITHOUT disposing them*)

      FUNCTION NewIterator: MLIterator; VIRTUAL;
      (*returns a vector iterator which has to be disposed after usage*)

    PRIVATE
      curSize:  INTEGER;   
      node: MLListNodePtr; 

    END; (*OBJECT*)


(*=== class MLListIterator ===*)

 (*see declaration above*)
    MLListIteratorObj = OBJECT(MLIteratorObj)

      node:      MLListNodePtr; (*vector to iterate over*)

      CONSTRUCTOR Init(firstNode: MLListNodePtr);
      DESTRUCTOR Done; VIRTUAL;

(*--- implementation of "abstract" method ---*)

      FUNCTION Next: MLObject; VIRTUAL;
      (*returns next element or NIL if "end of" collection reached*)

    END; (*OBJECT*)


  FUNCTION NewMLList: MLList;


(*======================================================================*)
IMPLEMENTATION

  USES
    MetaInfo;



  FUNCTION NewMLList: MLList;
    VAR
      v: MLList;
  BEGIN
    New(v, Init);
    NewMLList := v;
  END; (*NewMLVector*)


(*=== class MLList ===*)

  CONSTRUCTOR MLListObj.Init;
  BEGIN
    INHERITED Init;
    Register('MLList', 'MLCollection');
    SELF.curSize :=  0;
    New(SELF.node);

    Self.node^.value := NIL;
    Self.node^.next := NIL;
  END; (*MLListObj.Init*)

  DESTRUCTOR MLListObj.Done;
  VAR
    next: MLListNodePtr;
  BEGIN
    WHILE SELF.node <> NIL DO BEGIN
      next := SELF.node^.next;
      Dispose(SELF.node);
      SELF.node := next;
    END;
    INHERITED Done;
  END; (*MLListObj.Done*)


  (*--- implementations of "abstract" mehtods ---*)

  FUNCTION MLListObj.Size: INTEGER;
  BEGIN
    Size := SELF.curSize;
  END; (*MLListObj.Size*)

  PROCEDURE MLListObj.Add(o: MLObject);
  VAR 
    newNode: MLListNodePtr;
    currentNode: MLListNodePtr;
  BEGIN
    SELF.curSize := SELF.curSize + 1;

    // create new node
    New(newNode);
    newNode^.next := NIL;
    newNode^.value := o;

    // empty list
    IF SELF.node = NIL THEN
      SELF.node := newNode
    // find last element and append on the end
    ELSE BEGIN
      currentNode := SELF.node;
      WHILE currentNode^.next <> NIL DO BEGIN
        currentNode := currentNode^.next;
      END;
      currentNode^.next := newNode;
    END;
  END; (*MLListObj.Add*)

  PROCEDURE MLListObj.Prepend(o: MLObject);
  VAR
      newNode: MLListNodePtr;
  BEGIN
    New(newNode);
    newNode^.value := o;
    newNode^.next := SELF.node;
    Self.node := newNode;
    Inc(SELF.curSize);
  END;

  FUNCTION MLListObj.Remove(o: MLObject): MLObject;
  VAR 
    currentNode: MLListNodePtr;
    prevNode:  MLListNodePtr;
  BEGIN
    currentNode := SELF.node;
    prevNode := NIL;
    Remove := NIL;
    // first element
    IF SELF.node^.value^.IsEqualTo(o) THEN BEGIN
      currentNode := SELF.node;
      SELF.node := SELF.node^.next;
      Remove := currentNode^.value;
      Dispose(currentNode);
      Dec(SELF.curSize);
    END ELSE BEGIN
      // search for node
      WHILE (currentNode <> NIL) AND (NOT currentNode^.value^.IsEqualTo(o)) DO BEGIN
        prevNode := currentNode;
        currentNode := currentNode^.next;
        Dec(SELF.curSize);
      END;
      // if found -> delete
      IF currentNode^.value^.IsEqualTo(o) THEN BEGIN
        prevNode^.next := currentNode^.next;
        Remove := currentNode^.value;
        Dispose(currentNode);
        Dec(SELF.curSize);
      END;
    END;
  END; (*MLListObj.Remove*)

  FUNCTION MLListObj.Contains(o: MLObject): BOOLEAN;
  VAR 
    currentNode: MLListNodePtr;
  BEGIN
    Contains := FALSE;
    IF o <> NIL THEN BEGIN
      currentNode := SELF.node;
      WHILE currentNode <> NIL DO BEGIN
        IF currentNode^.value^.IsEqualTo(o) THEN BEGIN
          Contains := true;
          currentNode := NIL;
        END (*IF*) ELSE BEGIN
          currentNode := currentNode^.next;
        END; (*ELSE*)
      END;(*WHILE*) 
    END; (*IF*)
  END; (*MLListObj.Contains*)

  PROCEDURE MLListObj.Clear;
   VAR 
    currentNode: MLListNodePtr;
    prevNode: MLListNodePtr;
  BEGIN
    currentNode := SELF.node;
    WHILE (currentNode <> NIL) DO BEGIN
      prevNode := currentNode;
      currentNode := currentNode^.next;
      Dispose(prevNode);
    END;
    SELF.node := NIL;
    SELF.curSize := 0;
  END; (*MLListObj.Clear*)

  FUNCTION MLListObj.NewIterator: MLIterator;
    VAR
      it: MLListIterator;
  BEGIN
    New(it, Init(SELF.node));
    NewIterator := it;
  END; (*MLListObj.NewIterator*)


 (*=== MLVectorIterator ===*)
 

  CONSTRUCTOR MLListIteratorObj.Init(firstNode: MLListNodePtr);
  BEGIN
    INHERITED Init;
    Register('MLListIterator', 'MLIterator');
    SELF.node := firstNode;
  END; (*MLVectorIteratorObj.Init*)

  DESTRUCTOR MLListIteratorObj.Done;
  BEGIN
    SELF.node := NIL;
    INHERITED Done;
  END; (*MLVectorIteratorObj.Done*)


(*--- implementation of "abstract" method ---*)

  FUNCTION MLListIteratorObj.Next: MLObject;
    VAR
      o: MLObject;
  BEGIN
    IF node <> NIL THEN BEGIN
      o := node^.value;
      node := node^.next;
    END ELSE
      o := NIL;

    Next := o;
  END; (*MLVectorIteratorObj.Next*)
END. (*MLVect*)


 

