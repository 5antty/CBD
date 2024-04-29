program adicional9_4;
type
    profesional = record
        dni:integer;
        nombre:string;
        apellido:string;
        sueldo:real;
    end;
    tArchivo = file of profesional;

procedure Crear(var Arch:tArchivo; var info:Text);
var p:profesional;
begin
    {no olvidarse de crear la cabecera para saber si tengo un registro eliminado o no}
    reset(info); Rewrite(Arch);
    p.dni:=0;
    write(Arch, p);
    while(not Eof(info)) do begin
        {Hago esto para poder leer los dos campos de strings separados por lineas}
        ReadLn(info, p.dni, p.sueldo, p.nombre);
        ReadLn(info, p.apellido);
        Write(Arch, p);
    end;
    Close(info);
    Close(Arch);
end;

procedure Agregar(var Arch:tArchivo; p:profesional);
var
    aux:profesional; cabecera:profesional
begin
    Reset(Arch);
    read(Arch, cabecera);
    if(cabecera.dni<>0) then
    begin
        Seek(Arch, -cabecera.dni);
        read(Arch, aux);
        Seek(Arch, 0);
        Write(Arch, aux);
        Seek(Arch, -cabecera.dni);
    end
    else
        Seek(Arch, FileSize(Arch));
    Write(Arch, p);
    Close(Arch);
end;

procedure Eliminar(var Arch:tArchivo; dni:integer; var bajas:Text);
var
    p, c:profesional;
begin
    Reset(Arch); Reset(bajas);
    read(Arch, c);
    p.dni:=-1;
    while(not Eof(Arch) and p.dni<>dni) do
    begin
        read(Arch, p);
        if(p.dni=dni) then begin
            Seek(Arch, FilePos(Arch)-1);
            write(Arch, c);
            c.dni:=(FilePos(Arch)-1)*(-1);
            {Me posiciono en la cabecera}
            Seek(Arch, 0);
            {Sobreescribo la cabecera}
            Write(Arch, c);
            WriteLn(bajas, p.dni, p.sueldo, p.nombre);
            WriteLn(bajas, p.apellido);
        end
        else
            WriteLn('no fue encontrado');
    end;
    Close(bajas);
    Close(Arch);
end;
begin

end.