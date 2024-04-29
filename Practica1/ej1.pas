Program ej1;

type
    //Si creo los archivos de un tipo de registro, tengo que definir el registro y luego un tipo file of REGISTRO
    tArch=File of String;
var
    nomArch:String;
    //Declaro variable del tipo del archivo
    arch:tArch;
    nomMat:String;
Begin
    write('Ingrese nombre del archivo: ');
    readln(nomArch);
    //Siempre hago el assign antes de rewrite o reset
    Assign(arch, nomArch);
    Rewrite(arch);

    repeat
        Write('Ingrese un nombre de material');
        readln(nomMat);
        Write(arch, nomMat);
    until (nomMat = 'cemento');
    //Comparacion de strings en pascal es por operadores logicos nomas
    Seek(arch, 0);
    while (not eof(arch)) do begin
        read(arch, nomMat);
        Writeln(nomMat);
    end;

    Close(arch);
    
End.