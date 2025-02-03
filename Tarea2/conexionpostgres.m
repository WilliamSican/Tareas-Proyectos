pkg load database  % Cargar el paquete de base de datos

% Conectar a la base de datos
conn = pq_connect(setdbopts('dbname', 'postgres', 'host', 'localhost', 'port', '5432', 'user', 'postgres', 'password', 'shwilly'));

%ingresar datos desde OCTAVE
N=pq_exec_params(conn, "INSERT INTO tarea2 VALUES('WILL','20202020');")
% Ejecutar la consulta SQL
N = pq_exec_params(conn, 'SELECT * FROM tarea2;');
disp(N);

% Cerrar la conexión (recomendado)
pq_close(conn);

