PROGRAM HashTest;

USES HashingClosed;

VAR
    ok: BOOLEAN;

BEGIN
    AddPerson('Muster', ok); WriteLn(ok);
    AddPerson('Super', ok); WriteLn(ok);
    AddPerson('Wilhelm', ok); WriteLn(ok);
    Dispaly;
    WriteLn(ContainsPerson('Muster'));
    WriteLn(ContainsPerson('Super'));
    WriteLn(ContainsPerson('Neubauer'));
    WriteLn(ContainsPerson('Igor'));
    WriteLn(ContainsPerson('Mayer'));
    WriteLn(ContainsPerson('Wilhelm'))
END.