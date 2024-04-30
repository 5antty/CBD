program ej2;

type
    tVehiculo= Record
        codigoVehiculo:integer;
        patente: String;
        n_motor:String;
        cantidadPuertas: integer;
        precio:real;
        descripcion:String
    end;
    tArchivo = File of tVehiculo;

procedure Agregar(var arch:tArchivo; vehiculo:tVehiculo);
var
begin

end;

procedure Eliminar(var arch:tArchivo; codigoVehiculo:Integer);
var
begin
    
end;

begin

end.