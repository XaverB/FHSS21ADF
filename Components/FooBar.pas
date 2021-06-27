PROGRAM FooBar;

TYPE
    Base = ^BaseObj;
    BaseObj = OBJECT // "the" base class for EVERYTHING
        PROCEDURE GetClassName;
        PRIVATE
            _className: STRING;
    END;


    A = AObj;
    AObj = OBJECT
            CONSTRUCTOR Init;
        PRIVATE
    END;

CONSTRUCTOR AObj.Init
B