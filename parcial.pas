program parcial;
const valorAlto=9999;
const cant_arch=12;

type
    detalle=record
        cod_cat:Integer;
        nombre_cat:String;
        cod_art:Integer;
        nombre_art:String;
        monto_total:Real;
        cant_vendida:Integer;
    end;

    maestro=record
        cod_cat:Integer;
        nombre_cat:String;
        cant_cat:Integer;
        monto_cat:Real;
    end;
    
    ArchD = File of detalle;
    ArchM = File of maestro;
    RegistrosDet = Array[1..cant_arch] of detalle;
    ArchivosDet = Array[1..cant_arch] of ArchD;

procedure leer(var arch:ArchD; var det:detalle);
begin
    if(not Eof(arch)) then
        Read(arch, det)
    else
        det.cod_cat=valorAlto;
end;

procedure minimo(var a_arch:ArchivosDet; var a_reg:RegistrosDet; var min:detalle);
var
    posMin, i:Integer;
begin
    posMin:=1;
    min:=a_reg[1];
    for i:=2 to cant_arch do begin
        if(a_reg[i].cod_cat<min.cod_cat) then begin
            min:=a_reg[i];
            posMin:=i;
        end;
    end;
    leer(a_arch[posMin], min);
end;
{
    Actualizacion maestro - n detalles
procedure actualizar(var m:ArchM; var a_arch:ArchivosDet);
var
    i:interger; min:detalle; regM:maestro; a_regd:RegistrosDet;
begin
    for i:=1 to cant_arch do begin
        Reset(a_arch[i]);
        leer(a_arch[i], a_regd[i]);
    end;
    Reset(m);
    minimo(a_arch, a_regd, min);
    while(min.cod_cat <> valorAlto) do begin
        while(min.cod_cat <> regM.cod_cat) do begin
            Read(m, regM);
        end;
        while (min.cod_cat <> valorAlto) and (regM.cod_cat = min.cod_cat)  do begin
            regM.cant_cat:=regM.cant_cat+min.cant_vendida;
            minimo(a_arch, a_regd, min);
        end;
        Seek(m, FilePos(m)-1);
        Write(m, regM);
    end;
end;

var
    m:ArchM;
    a_arch:ArchivosDet;
    i:Integer;
    nombreDet:String;

begin
    for i:=1 to cant_arch do begin
        Writeln('Escriba un nombre para el archivo');
        Read(nombreDet);
        Assign(a_arch[i], nombreDet);
    end;
    actualizar(m, a_arch);
    for i:=1 to cant_arch do begin
        Close(a_arch[i]);
    end;
end.
}

procedure Merge(var m:ArchM; var a_arch:ArchivosDet);
var
    i, aux:interger; min:detalle; regm:maestro; ardet:RegistrosDet;
begin
    for i:=1 to cant_arch do begin
        Reset(a_arch[i]);
        leer(a_arch[i], ardet[i]);
    end;
    minimo(a_arch, ardet, min);
    while(min.cod_cat <> valorAlto) do begin
        aux := min.cod_cat;
        regm.cod_cat := min.cod_cat;
        regm.nombre_cat := min.nombre_cat;
        regm.cant_cat := 0;
        regm.monto_cat := 0;
        while (aux = min.cod_cat) do begin
            regm.cant_cat := regm.cant_cat+min.cant_vendida;
            regm.monto_cat := regm.monto_cat+min.monto_total;
            minimo(a_arch, ardet, min);
        end;
        Write(m, regm);
    end;
end;

var
    m:ArchM;
    a_arch:ArchivosDet;
    i:Integer;
    nombreDet:String;
    ardet:RegistrosDet;
    min, det:detalle;
    regm:maestro;
begin
    for i:=1 to cant_arch do begin
        Writeln('Escriba un nombre para el archivo');
        Read(nombreDet);
        Assign(a_arch[i], nombreDet);
    end;
    Assign(m, 'Maestro.dat');
    Rewrite(m);
    Merge(m, a_arch);
    Close(m);
end.