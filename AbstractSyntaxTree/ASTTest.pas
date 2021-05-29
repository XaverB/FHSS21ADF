PROGRAM ASTTest;

Uses Ast;

Function CreateTree: NodePtr;
VAR
    node: NodePtr;
BEGIN
    node := NIL;
    node := CreateNode(nil, '1', nil);
    node^.left := CreateNode(nil, '2', nil);
    node^.right := CreateNode(nil, '3', nil);
    node^.left^.left := CreateNode(nil, '4', nil);
    node^.left^.right := CreateNode(nil, '5', nil);
    CreateTree := node;
END;

PROCEDURE Print;
VAR 
    node: NodePtr;
BEGIN
    node := CreateTree;
    Writeln('Preorder traversal of binary tree. Expected: 1 2 4 5 3');
    PrintPreOrder(node);
    Writeln('');
    Writeln('InOrder traversal of binary tree. Expected: 4 2 5 1 3');
    PrintInOrder(node);
    Writeln('');
    Writeln('PostOrder traversal of binary tree. Expected: 4 5 2 3 1');
    PrintPostOrder(node);
END;

BEGIN
    Print;
END.