Program ej2;

type
    tArch = File of Integer;

var
    arch: tArch;
    nomArch: String;
    min, max, num, i: Integer;
begin
    min:=9999;
    max:=-1;
    Write('Ingrese el nombre del archivo: ');
    readln(nomArch);
    Assign(arch, nomArch);
    Rewrite(arch);
    for i :=1 to 5 do begin
        readln(num);
        Write(arch, num);
    end;
    Seek(arch, 0);
    while (not eof(arch)) do begin
        read(arch, num);
        if(num<min) then min:=num;
        if(num>max) then max:=num;
        WriteLn(num);
    end;
    Writeln('La cantidad minima de votantes es: ', min);
    WriteLn('La cantidad maxima de votantes es: ', max);
end.