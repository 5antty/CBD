Program ej1;
const nro_detalle = 5;
type
    detalle = record
        cod_emp:Integer;
        fecha:String;
        cant_lic:Integer;
    end;
    maestro = record
        cod_emp:Integer;
        nom:String;
        ape:String;
        fechaNac:String;
        dir:String;
        cant_h:Integer;
        tel:Integer;
        cant_vac:Integer;
    end;
    Det = File of detalle;
    Mae = File of maestro;
    DetR = Array[1..nro_detalle] of Det;
var
    archD:Det;
    archivos:DetR;
    archM:Mae;
    regd:detalle;
    regm:maestro;
    vac:Text;
    i:Integer
begin
    
    for i:=0 to nro_detalle do begin
        read(archivos[i], archD);
        Assign(ArchivosD[i], 'Detalle'+i);
        Reset(archD);
        read(archD, regd);
        Reset(archM);
        Read(archM, regm);
        while(not Eof(archD)) do begin

        end;
    end;
end.