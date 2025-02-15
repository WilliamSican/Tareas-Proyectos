clc; %limpia la pantalla
clear all; %limpia todos los valores que puedan haberse almacenado en las variables en la ejecucion anterior

pkg load database;  % Cargar el paquete 'database' para la conexión con PostgreSQL

% Ruta de almacenamiento del archivo de texto
imctxt = 'C:\Users\willy\Desktop\tareasproyectos2025\Tarea5\imc.txt';

% Conexión a la base de datos
conn = pq_connect(setdbopts("dbname", "postgres", "host", "localhost", "port", "5432", "user", "postgres", "password", "shwilly"));

opc = '';
while ~strcmp(opc, '5') % Comparar lo que hay en 'opc' con el valor 5
    disp('Menu:');
    disp('1. Calcular IMC');
    disp('2. Guardar IMC en archivo y base de datos');
    disp('3. Leer IMC desde archivo');
    disp('4. Borrar archivo y datos de la base de datos');
    disp('5. Salir');
    opc = input('Seleccione una opcion: ', 's'); % Lee la opción como cadena

    if strcmp(opc, '1')
        % Pedir nombre y género de la persona
        persona_nombre = input('Ingrese su nombre: ', 's');

        % Calcular IMC
        peso = input('Ingrese su peso en kg: ');
        altura = input('Ingrese su altura en metros: ');
        imc = peso / (altura ^ 2);

        % Categorizar IMC
        if imc < 18.5
            categoria = 'Bajo peso';
        elseif imc >= 18.5 && imc < 24.9
            categoria = 'Peso normal';
        elseif imc >= 25 && imc < 29.9
            categoria = 'Sobrepeso';
        else
            categoria = 'Obesidad';
        end

        fprintf('Su IMC es: %.2f\n', imc);
        fprintf('Categoria: %s\n', categoria);

    elseif strcmp(opc, '2')
        % Guardar IMC en imctxt y base de datos
        if exist('imc', 'var') && ~isempty(imc)
            % Guardar en archivo
            fid = fopen(imctxt, 'a');
            fprintf(fid, 'Nombre: %s, IMC: %.2f, Categoria: %s\n', persona_nombre, imc, categoria);
            fclose(fid);
            disp('Datos guardados en el archivo.');

            % Guardar en la base de datos
            try
                insert_query = "INSERT INTO imc (nombre, peso, altura, imc, categoria) VALUES ($1, $2, $3, $4, $5);";
                pq_exec_params(conn, insert_query, {persona_nombre, peso, altura, imc, categoria});
                disp('Datos guardados en la base de datos.');
            catch
                disp('Error al guardar en la base de datos.');
            end
        else
            disp('Primero debe calcular su IMC.');
        end

    elseif strcmp(opc, '3')
        % Leer IMC desde archivo
        if exist('imc', 'file')
            fid = fopen(imctxt, 'r');
            while ~feof(fid)
                linea = fgetl(fid);
                disp(linea);
            end
            fclose(fid);
        else
            disp('No hay datos para leer.');
        end

    elseif strcmp(opc, '4')
        % Borrar archivo y datos de la base de datos
        if exist('imc', 'file')
            delete(imctxt);
            disp('Archivo borrado.');
        else
            disp('No hay archivo para borrar.');
        end

        try
            pq_exec_params(conn, "TRUNCATE TABLE imc;");
            disp('Datos borrados de la base de datos.');
        catch
            disp('Error al borrar datos de la base de datos.');
        end

    elseif strcmp(opc, '5')
        disp('Saliendo...');
    else
        disp('Opción inválida. Intente nuevamente.');
    end
end

% Cerrar la conexión con la base de datos
pq_close(conn);
