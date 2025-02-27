clc; % Limpia la pantalla
clear all; % Limpia todas las variables almacenadas

pkg load database;  % Cargar el paquete 'database' para la conexión con PostgreSQL

% Ruta de almacenamiento del archivo de texto
factura = 'C:\Users\willy\Desktop\tareasproyectos2025\Parcial1\factura.txt';

% Conexión a la base de datos
conn = pq_connect(setdbopts("dbname", "postgres", "host", "localhost", "port", "5432", "user", "postgres", "password", "shwilly"));

while true
    persona = input('Ingrese su nombre: ', 's');
    placa = input('Ingrese su numero de placa: ', 's');

    % Mostrar opciones de combustible
    disp('Precio de gasolina por galon');
    disp('1. Disel a Q28.78');
    disp('2. Regular a Q30.36');
    disp('3. Super a Q31.85');

    % Validar opción de gasolina
    while true
        opc = input('Que tipo de gasolina desea: ', 's'); % Leer la opción como string
        if strcmp(opc, '1')
            p1 = 28.78;
            tipo = 'Disel';
            break;
        elseif strcmp(opc, '2')
            p1 = 30.36;
            tipo = 'Regular';
            break;
        elseif strcmp(opc, '3')
            p1 = 31.85;
            tipo = 'Super';
            break;
        else
            disp('Opción no válida. Intente nuevamente.');
        end
    end

    % Validar la cantidad de galones
    while true
        cantidad = str2double(input('Cuantos galones desea: ', 's'));
        if ~isnan(cantidad) && cantidad > 0
            break;
        else
            disp('Error: Ingrese un número válido y mayor a 0.');
        end
    end

    total = cantidad * p1;
    fprintf('Su total es: Q %.2f\n', total);
    fprintf('Factura generada.\n');

    % Guardar factura en factura.txt y base de datos
    fid = fopen(factura, 'a');
    fprintf(fid, '*************************\n');
    fprintf(fid, 'Nombre: %s\n', persona);
    fprintf(fid, 'Numero de placa: %s\n', placa);
    fprintf(fid, 'Tipo de combustible: %s\n', tipo);
    fprintf(fid, 'Cantidad de galones: %.2f\n', cantidad);
    fprintf(fid, 'Precio por galon: %.2f\n', p1);
    fprintf(fid, 'Total a pagar: %.2f\n', total);
    fprintf(fid, '**Gracias por su Compra**\n');
    fclose(fid);
    disp('Datos guardados en el archivo.');

    % mostrar factura en consola
    fprintf('*************************\n');
    fprintf('Nombre: %s\n', persona);
    fprintf('Numero de placa: %s\n', placa);
    fprintf('Tipo de combustible: %s\n', tipo);
    fprintf('Cantidad de galones: %.2f\n', cantidad);
    fprintf('Precio por galon: %.2f\n', p1);
    fprintf('Total a pagar: %.2f\n', total);
    fprintf('**Gracias por su Compra**\n');

    % Guardar en la base de datos
    try
        insert_query = "INSERT INTO factura (Nombre, Numero_de_Placa, Combustible, Galones, Precio, Total) VALUES ($1, $2, $3, $4, $5, $6);";
        pq_exec_params(conn, insert_query, {persona, placa, tipo, cantidad, p1, total});
        disp('Datos guardados en la base de datos.');
    catch
        disp('Error al guardar en la base de datos.');
    end

    % Preguntar si desea realizar otra compra
    continuar = input('¿Desea realizar otra compra? (s/n): ', 's');
    if lower(continuar) ~= 's'
        break;
    end
end

% Cerrar la conexión con la base de datos
pq_close(conn);

