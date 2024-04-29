program ej4;

type
    tArch = File of Integer;
procedure PasarATexto(arch:tArch);
var
    newArch:Text;
    num:integer;
begin
    Reset(arch);
    Rewrite(newArch);
    while (not Eof(arch)) do begin
        read(arch, num);
        Writeln(newArch, num);
    end;
    Close(newArch);
    Close(arch);
end;


begin

end.