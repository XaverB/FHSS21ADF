program KPM;

uses sysutils;

var 
    position : integer;
    pattern : array[1..4] of char;
    text : array[1..5] of char;
    next : array[1..4] of integer;

PROCEDURE InitNext(pattern : array of char);
BEGIN 
    

END;

FUNCTION Search(text : array of char; pattern : array of char): integer;
    BEGIN (* Search *)
        WriteLn('Searching for pattern (' + pattern + ') inside text (' + text + ')');
        Search := -1;
        InitNext(pattern);

    END; (* Search *)

begin
    position := -1;
    pattern := 'ABC';
    text := 'ABABC';

    WriteLn('Starting search..');
    position := Search(text, pattern);    
    WriteLn('Value of position: ' + IntToStr(position));
END.