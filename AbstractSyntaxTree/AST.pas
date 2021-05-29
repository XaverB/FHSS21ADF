UNIT AST;

INTERFACE

TYPE
    NodePtr = ^Node;
    Node = RECORD
        left, right: NodePtr;
        val: STRING; (* operator or operand as string *)
        END; (* Node *)
    TreePtr = NodePtr;

(* 
* Creates a new node
* IN left: left node
* IN value: value for the node
* IN right: right node
* RETURN: the created node
*)
FUNCTION CreateNode(left: NodePtr; value: string; right: NodePtr): NodePtr;

(*
* Prints the node and all subnodes in pre order traversal
* IN node
*)
PROCEDURE PrintPreOrder(node: NodePtr);
(*
* Prints the node and all subnodes in in order traversal
* IN node
*)
PROCEDURE PrintInOrder(node: NodePtr);
(*
* Prints the node and all subnodes in post order traversal
* IN node
*)
PROCEDURE PrintPostOrder(node: NodePtr);
(*
* Prints the node and all subnodes in pre order, in order and post order
* IN node
*)
PROCEDURE Print(node: NodePtr);
(*
* Calculates the value of the abstract syntax tree.
* HALTS the program if a divison by zero occurs
* IN node
* RETURN calculated value
*)
FUNCTION ValueOf(t: TreePtr): INTEGER;

IMPLEMENTATION

USES sysutils;

VAR
    rootNode: NodePtr;

PROCEDURE PrintPreOrder(node: NodePtr);
BEGIN
    IF node <> nil THEN BEGIN
        Write(node^.val, ' ');
        PrintPreOrder(node^.left);
        PrintPreOrder(node^.right);
    END;

END;

PROCEDURE PrintInOrder(node: NodePtr);
BEGIN
    IF node <> nil THEN BEGIN
        PrintInOrder(node^.left);

        Write(node^.val, ' ');

        PrintInOrder(node^.right);
    END;
END;

PROCEDURE PrintPostOrder(node: NodePtr);
BEGIN
    IF node <> nil THEN BEGIN
        PrintPostOrder(node^.left);

        PrintPostOrder(node^.right);

        Write(node^.val, ' ');
    END;
END;

FUNCTION IsExpression(node: NodePtr): BOOLEAN;
BEGIN
    IsExpression := FALSE;

    IF (node <> NIL) AND ((node^.val = '+') or (node^.val = '-') or(node^.val = '*') or (node^.val = '/') ) THEN
        IsExpression := TRUE;
END;

FUNCTION ValueOf(t: TreePtr): INTEGER;
VAR 
    leftSum, rightSum: INTEGER;
BEGIN
    (* empty tree *)
    IF (t = NIL) OR (t^.val = '')  THEN BEGIN
        ValueOf := 0;
    END ELSE BEGIN
        (* leaf node *)
        IF (t^.left = NIL) and (t^.right = NIL) THEN BEGIN
            ValueOf := StrToInt(t^.val);
        END ELSE BEGIN

            leftSum := ValueOf(t^.left);
            rightSUm := ValueOf(t^.right);

            IF t^.val = '+' THEN
                ValueOf := leftSum + rightSum
            ELSE IF t^.val = '-' THEN
                ValueOf := leftSum - rightSum
            ELSE IF t^.val = '*' THEN
                ValueOf := leftSum * rightSum
            ELSE IF t^.val = '/' THEN BEGIN
                IF rightSum = 0 THEN BEGIN
                    WriteLn('DIVISION BY ZERO. Terminating program..');
                    HALT;
                END ELSE
                    ValueOf := leftSum DIV rightSum
            END;
        END;
    END;
END;

PROCEDURE Print(node: NodePtr);
BEGIN
    Writeln('PreOrder traversal of binary tree.');
    PrintPreOrder(node);
    Writeln('');
    Writeln('InOrder traversal of binary tree.');
    PrintInOrder(node);
    Writeln('');
    Writeln('PostOrder traversal of binary tree.');
    PrintPostOrder(node);
END;

FUNCTION CreateNode(left: NodePtr; value: string; right: NodePtr): NodePtr;
VAR
    node: NodePtr;
BEGIN
    New(node);
    node^.left := left;
    node^.right := right;
    node^.val := value;
    CreateNode := node;
END;

BEGIN
END.