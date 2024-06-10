program parcial_300517;
const valorAlto=9999;

type
    ventas=record
        code_exc:integer;
        nombre:String;
        desc:String;
        total_vendidas:Integer;
    end;

    ArchB = file of ventas;

procedure lecturaTexto(var arch:ArchB; var texto:Text);
var
    reg:ventas; codeAct, cantVentas, aux:Integer;
begin
    Reset(texto);
    ReadLn(texto, reg.code_exc, aux, reg.nombre);
    ReadLn(texto, reg.desc);
    while (not Eof(texto)) do begin
        codeAct:=reg.code_exc;
        cantVentas:=0;
        while(reg.code_exc=codeAct) do begin
            cantVentas:=cantVentas+aux;
            ReadLn(texto, reg.code_exc, aux, reg.nombre);
            ReadLn(texto, reg.desc);
        end;
        reg.total_vendidas:=cantVentas;
        Write(arch, reg);
    end;
end;

var
    archivoBin:ArchB;
    archivoTexto:Text;

begin
    Assign(archivoBin, 'bin.dat');
    Assign(archivoTexto, 'ventas.txt');
    Rewrite(archivoBin);
    lecturaTexto(archivoTexto, archivoBin);
    Close(archivoBin);
    Close(archivoTexto);
end.