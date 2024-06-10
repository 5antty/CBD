program parcial_130623;
const valorAlto=9999;
const cant_arch=20;

type
    venta=record
        anio_venta:Integer;
        mes_venta:Integer;
        dia_venta:integer;
        code_marca:Integer;
        code_mod:Integer;
        nombre_marca:String;
        nombre_mod:String;
        color:String;
        dni_cli:integer;
        monto_op:real;
    end;

    maestro=record
        anio:Integer;
        mes:Integer;
        monto_total:Real;
        cant_ventas:Integer;
    end;

    ArchD=file of venta;
    ArchM=file of maestro;

    arrayReg = Array[1..cant_arch] of venta;
    arrayD = Array[1..cant_arch] of ArchD;

procedure leer(var arch:ArchD; var reg:venta);
begin
    if(not Eof(arch)) then
        read(arch, reg)
    else
        reg.code_marca=valorAlto;
end;

procedure minimo(var ardet:arrayD; var reg:arrayReg; var min:venta);
var
    posMin, i:integer;
begin
    posMin:=1;
    min:=reg[1];
    for i:=2 to cant_arch do begin
        if(reg[i].code_marca<min.code_marca) then begin
            min:=reg[i];
            posMin:=i;
        end;
    end;
    leer(ardet[posMin], min);
end;

procedure corteControl(var m:ArchM; var ardet:arrayD; var arreg:arrayReg);
var
    regm:maestro; codMarcaAct, anioAct, mesAct, modMasVendido:Integer;

begin

end;

var
    min:venta;
    m:ArchM;
    maestro:maestro;
    ardet:arrayD;
    regs:arrayReg;
    regm:maestro; codMarcaAct, anioAct, mesAct, modMasVendido, aux:Integer;
    montoTotal:real;

begin
    Assign(m, maestro);
    read(m);
    for i:=0 to nro_detalle do begin
        Assign(ardet[i], 'detalle'+i);
        Reset(ardet[i]);
        leer(ardet[i], regs[i]);
    end;
    minimo(ardet, regs, min);
    while(min.code_marca<>valorAlto) do begin
        codMarcaAct:=min.code_marca;
        while (regm.prov<>min.prov) do begin
            read(m, regm);
        end;
        anioAct:=min.anio_venta;
        montoTotal:=0;
        while (anioAct=min.anio_venta) do begin
            regm.anio:=min.anio_venta;
            mesAct:=min.mes_venta;
            while(anioAct=min.anio_venta) and (mesAct=min.mes_venta) do begin

            end;
            minimo(RegistrosD, min, ArchivosD);
        end;
    end;
    writeln(votos, 'cantidad de archivos proc'+ nro_detalle);
    writeln(votos, '');
    Close(m);
end.