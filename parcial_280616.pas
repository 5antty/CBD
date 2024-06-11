program parcial_280616;
const valorAlto=9999;
const cantArch=1;

type
    vivienda=record
        codPartido:Integer;
        tipo:String;
    end;

    maestro=record
        codPartido:Integer;
        tipo:String;
        cant:Integer;
    end;

    ArchD = file of vivienda;
    ArchM = File of maestro;


procedure leer(var arch:ArchD; reg:vivienda);
begin
    if(not Eof(arch)) then
        Read(arch, reg)
    else
        reg:=valorAlto;
end;

procedure Merge(var m:ArchM; var archivo:ArchD);
var
    reg:vivienda; codeAct:Integer; tipoAct:String; totalxViv:Integer;
    mayor, cantxPartido, maxPartido:Integer;
    regm:maestro;
begin
    Reset(archivo);
    leer(archivo, reg);
    mayor:=-1;
    while (reg.codPartido<>valorAlto) do begin
        codeAct:=reg.codPartido;
        cantPartido:=0;
        while(reg.codPartido=codeAct) do begin
            totalxViv:=0;
            tipoAct:=reg.tipo;
            while (reg.codPartido=codeAct) and (reg.tipo=tipoAct) do begin
                totalxViv:=totalxViv+1;
                leer(archivo, reg);
            end;
            regm.codPartido:=codeAct;
            regm.tipo:=tipoAct;
            regm.cant:=totalxViv;
            Write(m, regm);
            cantxPartido:=cantxPartido+totalxViv;
        end;
        if(cantPartido>mayor) then begin
            mayor:=cantPartido;
            maxPartido:=codeAct;
        end;
    end;
    WriteLn('El partido con mayor numero de viviendas construidas es: '+ maxPartido);
end;

var
    m:ArchM;
    archivo:ArchD;

begin
    Assign(archivo, 'archivo.dat');
    Assign(m, 'maestro.dat');
    Merge(m, archivo);
    Close(archivo);
    Close(m);
end.