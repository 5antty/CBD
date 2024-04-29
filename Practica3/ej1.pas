program ej1;

type
    plantas = record
        codEspecie:Integer;
        nombreV:String[20];
        nombreC:String[50];
        altProm:Float;
        desc:String[50];
        zonaG:String[50];
    end;
    Plant = file of plantas;

procedure nuevoArch(var nue, arch:Plant);
var
    reg:plantas
begin
    Reset(nue);
    Reset(arch);
    while(not eof(arch)) do begin
        read(arch, reg);
        if(reg.nombreC<>'@') then
            Write(nue, reg);
    end;

end;
var
    regp:plantas;
    ArchP:Plant
    codEliminar:Integer;
    nueArch:Plant;
begin
    Assign(ArchP, regp);
    Reset(ArchP);
    Write('Ingrese un codigo de especie a eliminar ');
    readln(codEliminar);
    while (codEliminar<>100000) do begin
        while (not eof(ArchP)) do begin
            read(ArchP, regp);
            if(regp.codEspecie=codEliminar) then 
                regp.nombreC:='@';
        end;
        Write('Ingrese un codigo de especie a eliminar ');
        readln(codEliminar);
    end;
    nuevoArch(nueArch, ArchP);
    Close(ArchP);
    Close(nueArch);
end.