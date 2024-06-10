program parcial_310516;

type
    venta=record
        cod_prod:Integer;
        nombre:String;
        descripcion:String;
        stock:Integer;
    end;

    archD = file of venta;

procedure generaBinario(var archText:Text; var arch:archD);
var
    reg:venta;
begin
    Assign(arch, 'binario.dat');
    Rewrite(arch);
    Reset(archText);
    while (not Eof(archText)) do begin
        Readln(archText, reg.cod_prod, reg.nombre);
        ReadLn(archText, reg.stock, reg.descripcion);
        Write(arch, reg);
    end;
end;

procedure eliminoObsoletos(var arch:archD; obsoleto:Integer);
var
    reg:venta;
begin
    Reset(arch);
    while (not eof(arch)) and (reg.cod_prod<>obsoleto) do begin
        Read(arch, reg);
        if(reg.cod_prod=obsoleto) then begin
            reg.cod_prod:='@';
            Seek(arch, FilePos(arch)-1);
            Write(arch, reg);
            reg.cod_prod:=(FilePos(arch)-1)*(-1);
            Seek(arch, 0);
            Write(arch, reg);
        end;
    end;

end;

var
    texto:Text;
    archivo:archD;
    obsoleto:String;

begin
    generaBinario(texto, archivo);
    Write('Ingrese un codigo obsoleto ');
    ReadLn(obsoleto);
    while(obsoleto<>'zzz') do begin
        eliminoObsoletos(archivo, obsoleto);
        Write('Ingrese un codigo obsoleto ');
        ReadLn(obsoleto);
    end;
end.