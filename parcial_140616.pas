program parcial_140616;
const valorAlto=9999;
const cantArch=50;

type
    venta=record
        code:Integer;
        cantVentas:Integer;
    end;

    maestro=record
        code:Integer;
        nombre:String;
        desc:String;
        stock:Integer;
    end;

    ArchD = file of venta;
    ArchM = file of maestro;
    ArchivosDet = Array[1..cantAch] of ArchD;
    RegistrosDet = Array[1..cantArch] of venta;

procedure leer(var arch:ArchD; var reg:venta);
begin
    if(not Eof(arch)) then
        Read(arch, reg)
    else
        reg.code:=valorAlto;
end;

procedure minimo(var archivos:ArchivosDet; var regs:RegistrosDet; var min:venta);
var
    posMin, i:Integer;
begin
    posMin:=1;
    min:=regs[posMin];
    for i:=2 to cantArch do begin
        if(regs[i].code<min.code) then begin
            min:=regs[i];
            posMin:=i;
        end;
    end;
    leer(archivos[posMin], min);
end;

procedure ActualizarMaestro(var m:ArchM; var archivos:ArchivosDet);
var
    i:interger; min:venta; regM:maestro; regs:RegistrosDet;
begin
    for i:=1 to cant_arch do begin
        Reset(archivos[i]);
        leer(archivos[i], regs[i]);
    end;
    Reset(m);
    minimo(archivos, regs, min);
    while(min.code <> valorAlto) do begin
        while(min.code <> regM.code) do begin
            Read(m, regM);
        end;
        while (min.code <> valorAlto) and (regM.code = min.code)  do begin
            regM.stock:=regM.stock-min.cantVentas;
            minimo(archivos, regs, min);
        end;
        Seek(m, FilePos(m)-1);
        Write(m, regM);
    end;
end;

var
    m:ArchM;
    archivos:ArchivosDet;
    i:Integer;
begin
    for i:=1 to cantArch do begin
        Assign(archivos[i], 'venta_'+i);
    end;
    Assign(m, 'maestro.dat');
    ActualizarMaestro(m, archivos);
    Close(m);
    for i:=1 to cantArch do begin
        Close(archivos[i]);
    end;
end.