program act;
const nro_detalle = 500;
const valorAlto = 99999;
type
    detalle = record
        localidad:Integer;
        prov:integer;
        validos:integer;
        anulados:integer;
        blancos:integer;
    end;
    maestro = record
        prov:String[50];
        cod_prov:Integer;
        validos:Integer;
        blancos:Integer;
        anulados:integer;
    end;
    Det = File of detalle;
    Mae = File of maestro;
    DetR= Array[1..nro_detalle] of detalle;
    DetA =Array[1..nro_detalle] of Det;

procedure minimo(var detr:DetR; var min:detalle; var detalleA:DetA)
var
    i, pos:Integer
begin
    pos:=1;
    min:=detr[pos];
    for i:=2 to nro_detalle do begin
        if(min.prov>detr[i].prov) then begin
            min:=detr[i];
            pos:=i;
        end;
    end;
    leer(detalleA[pos], detr[pos]);
end;

procedure leer(var detalleA:DetA; var D:detalle)
begin
    if(not Eof(detalleA)) then read(detalleA, D)
    else D.prov:=valorAlto;
end;

var
    m:Mae;
    regm:maestro;
    min:detalle;
    Aux:Integer;
    ArchivosD:DetA;
    RegistrosD:DetR;
    votos:Text;
    totalA, totalB, totalV:Integer
    
begin
    Assign(m, maestro);
    read(m);
    for i:=0 to nro_detalle do begin
        Assign(ArchivosD[i], 'detalle'+i);
        Reset(ArchivosD[i]);
        leer(ArchivosD[i], RegistrosD[i]);
    end;


    minimo(RegistrosD, min, ArchivosD);
    if(not Eof(ArchivosD)) then read(m, regm);
    totalB:=0;
    totalV:=0;
    totalA:=0;
    while(min.prov<>valorAlto) do begin
        while (regm.prov<>min.prov) do begin
            read(m, regm);
        end;
        aux:=min.prov;
        while (Aux=min.prov) do begin
            regm.validos:=regm.validos+min.validos;
            regm.anulados:=regm.anulados+min.anulados;
            regm.blancos:=regm.blancos+min.blancos;
            totalB:=totalB+min.blancos;
            totalV:=totalV+min.validos;
            totalA:=totalA+min.anulados;
            minimo(RegistrosD, min, ArchivosD);
        end;
        Seek(m, FilePos(m)-1);
        write(m, regm);  
    end;
    writeln(votos, 'cantidad de archivos proc'+ nro_detalle);
    writeln(votos, '');
    Close(m);
    Close(votos);
    for i:=1 to nro_detalle do begin
        Close(ArchivosD[i]);
    end;
end.