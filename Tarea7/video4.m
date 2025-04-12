#conexion de octave con postgress
pkg load database #carga el paquete de base de datos
conn = pq_connect (setdbopts ("dbname","postgres","host","localhost","port","5432","user","postgres","password","shwilly")); # conexion a la base de datos
N = pq_exec_params (conn, "SELECT * FROM test");# estructura, hace la conexion y luego ejecuta la instruccion de postgres que esta en las comillas
N.data; #muestra los datos que hay en la estructura N
N = pq_exec_params (conn,"INSERT INTO test(num,texto,num2) VALUES (22, 'Texto desde OCTA',365)");#para insertar datos
