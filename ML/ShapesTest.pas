PROGRAM ShapesTest;

USES UGroup, URectangle, UCircle, UShape;

// STRONG AGGREGATION --> OBJECTS ARE OWNED BY T HEIR CONTAINERS AND DIE WITH THEM
// WEAK AGGREGATION --> OBJECTS OUTLIVE THEIR CONTAINERS


VAR
    c: CIrcle;
    r: Rectangle;
    g: Group;
    s: Shape;
    ok: BOOLEAN;
BEGIN

    New(c, Init(10,20,5));

    s := c;
    s^.Draw();
    s^.MoveBy(30, 30);
    s^.Draw();
    

    New(r, Init(10, 10, 10, 10));
    s := r;
    s^.Draw();
    s^.MoveBy(30, 30);
    s^.Draw();

    New(g, Init);
    g^.AddShape(r, ok); // container takes full ownership
    g^.AddShape(c, ok); // container takes full ownership
    g^.Draw();
    g^.MoveBy(10, 10);
    g^.Draw();

    Writeln(c^.Class, ' ', c^.baseClass, ' ', c^.IsA('Rectangle'), ' ', c^.IsA('MLObject')); // ## now we can also get information about

    Dispose(g, Done); // all owned objets die 


    // r^.Draw -- not allowed: container is resposible for this
    // c^.Draw -- not allowed: container is resposible for this
    // Dispose(c, Done) -- not allowed: container is resposible for this



END.