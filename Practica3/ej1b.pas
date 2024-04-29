program ej1b;
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

var
    regp:plantas;
    ArchP:Plant
    codEliminar:Integer;
    aux:plantas;
    posBorrar:Integer;
begin
    Assign(ArchP, regp);
    Reset(ArchP);
    Write('Ingrese un codigo de especie a eliminar ');
    readln(codEliminar);
    posBorrar:=0;
    while (codEliminar<>100000) do begin
        while (not eof(ArchP)) do begin
            read(ArchP, regp);
            if(regp.codEspecie=codEliminar) then begin
                posBorrar:=FilePos(ArchP)-1;
                Seek(ArchP, FileSize(ArchP)-1);
                read(ArchP, aux);
                Seek(ArchP, posBorrar);
                Write(ArchP, aux);
                Seek(ArchP, FileSize(ArchP)-1);
                truncate(ArchP);
            end;
        end;
        Write('Ingrese un codigo de especie a eliminar ');
        readln(codEliminar);
    end;
    Close(ArchP);
end.