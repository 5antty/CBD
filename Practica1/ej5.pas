program ej5;

type
    flores=record
        nro:Integer;
        altMax:real;
        nomC:String;
        nomV:String;
        color:String;
    end;

    tArch= File of flores;

procedure TotalEsp(arch:tArch);
var
    min, max:real; cant:Integer; f:flores;
    nomMax, nomMin:String;
begin
    min:=9999;
    max:=-1;
    cant:=0;
    Reset(arch);
    while(not Eof(arch)) do begin
        Read(arch, f);
        if(f.altMax>max) then begin
            max:=f.altMax;
            nomMax:=f.nomC;
        end;
        if(f.altMax<min) then begin
            min:=f.altMax;
            nomMin:=f.nomC;
        end;
        cant:=cant+1;
    end;
    Writeln('La cantidad total de especies es: ', cant);
    WriteLn('La especie de menor altura es: ', nomMin);
    WriteLn('La especie de mayor altura es: ', nomMax);
end;

procedure Listar(arch:tArch);
var
    f:flores;
begin
    Reset(arch);
    while not eof(arch) do begin
        read(arch, f);
        WriteLn(f.nro, f.altMax, f.nomC, f.nomV, f.color);
    end;
end;

procedure modif(arch:tArch);
var
    f:flores;
begin
    while not eof(arch) do begin
        read(arch, f);
        if(f.nomC='Victoria amazonia') then begin
            f.nomC:='Victoria amazónica';
            {Me paso a la posicion anterior para reescribir el registro que acabo de leer}
            Seek(FilePos(arch)-1);
            Write(arch, f);
        end;
    end;
end;

procedure AniadirMas(var arch:tArch);
var
    f:flores;
begin
    Seek(arch, FilePos(arch)-1);
    Write('Ingrese el nombre cientifico de la flor: ');
    readln(f.nomC);
    while(f.nomC<>'zzz') do begin
        Write('Ingrese el numero de la flor');
        ReadLn(f.nro);
        Write('Ingrese el nombre vulgar de la flor: ');
        readln(f.nomV);
        Write('Ingrese la altura maxima de la flor: ');
        readln(f.altMax);
        Write('Ingrese el color de la flor: ');
        readln(f.color);
        Write(arch, f);
        Write('Ingrese el nombre cientifico de la flor: ');
        readln(f.nomC);
    end;
end;



var 
    arch:tArch; f:flores; nom:String;
begin
    Assign(arch, 'flores');
    Rewrite(arch);
    Write('Ingrese el nombre cientifico de la flor: ');
    readln(f.nomC);
    while(f.nomC<>'zzz') do begin
        Write('Ingrese el numero de la flor');
        ReadLn(f.nro);
        Write('Ingrese el nombre vulgar de la flor: ');
        readln(f.nomV);
        Write('Ingrese la altura maxima de la flor: ');
        readln(f.altMax);
        Write('Ingrese el color de la flor: ');
        readln(f.color);
        Write(arch, f);
        Write('Ingrese el nombre cientifico de la flor: ');
        readln(f.nomC);
    end;



end.