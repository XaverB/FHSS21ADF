PROGRAM People;

TYPE
    Address = OBJECT
            PROCEDURE Init(street, zipCode, city: STRING);
            PROCEDURE Done;

            FUNCTION GetStreet: STRING;
            PROCEDURE SetStreet(value: STRING);
            FUNCTION GetZipCode: STRING;
            FUNCTION GetCity: STRING;
            FUNCTION GetFullCity: STRING;
        PRIVATE
            _street, _zipCode, _city: STRING;
    END;
    Person = OBJECT
            PROCEDURE Init(name: STRING; addr: Address);
            PROCEDURE Done;

            FUNCTION GetName: STRING;
            FUNCTION GetAddress: Address;
        PRIVATE
            _name: STRING;
            _address: Address;
    END;

PROCEDURE Address.Init(street, zipCode, city: STRING);
BEGIN
    SELF._street := street;
    SELF._zipCode := zipCode;
    SELF._city := city;
END;

PROCEDURE Address.Done;
BEGIN
    // nothing to do
END;

FUNCTION Address.GetStreet: STRING;
BEGIN
    GetStreet := SELF._street;
END;

PROCEDURE Address.SetStreet(value: STRING);
BEGIN
    // address must have minimum length to be set (e. g.)
    IF Length(value) >= 10 THEN
        SELF._street := value;
END;

FUNCTION Address.GetZipCode: STRING;
BEGIN
    GetZipCode := SELF._zipCode;
END;

FUNCTION Address.GetCity: STRING;
BEGIN
    GetCity := SELF._city;
END;

FUNCTION Address.GetFullCity: STRING;
BEGIN
    GetFullCity := SELF._zipCode + ' ' + SELF._city;
END;



PROCEDURE Person.Init(name: STRING; addr: Address);
BEGIN
    SELF._name := name;
    SELF._address := addr;
END;

PROCEDURE Person.Done;
BEGIN
    // nothing to do
END;

FUNCTION Person.GetName: STRING;
BEGIN
    GetName := SELF._name;
END;

FUNCTION Person.GetAddress: Address;
BEGIN
    GetAddress := SELF._address;
END;


VAR
    a1, a2: Address;
BEGIN
    a1.INIT('Musterallee 1', '4020', 'Linz');
    a2 := a1;

    WriteLn(a2.GetStreet);
    WriteLn(a2.GetFullCity);
END.


VAR
    a: Address;
    p: Person;
BEGIN
    a.INIT('Musterallee 1', '4020', 'Linz');
    p.INIT('Karl', a);
    a.SetStreet('Musterstrasse 2');

    WriteLn(p.GetName);
    WriteLn(p.GetAddress.GetStreet);
    WriteLn(p.GetAddress.GetFullCity);

    p.Done;
    a.Done;
END.