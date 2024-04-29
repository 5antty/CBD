program ej3;

var
    carga:Text;
    tipoDino:String;
begin
    Assign(carga, 'Dinosurios');
    Rewrite(carga);
    Write('Ingrese un tipo de dinosuario: ');
    readln(tipoDino);

    while(tipoDino<>'zzz') do begin
        Writeln(carga, tipoDino);
        Write('Ingrese un tipo de dinosuario: ');
        readln(tipoDino);
    end;

    Close(carga);
end.