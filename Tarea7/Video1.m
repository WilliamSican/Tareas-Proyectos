###objetos numericos
##
##375 # numero escrito normalmente
##3.75e2 # numero con notacion formato 1
##3.75E2 # numero con notacion formato 2
##0x177 #numero escrito en hexadecimal
##
###rangos numericos
###sintaxis:
###numero_inicial:salto:numero_final    ###### si no se escribe el salto octa lo interpreta como salto 1
##1:0.5:10   ### los numeros superiores al rango nunca se mostraran

###Matrices, se alamacena en una variable
##M = [1,2,3;4,5,6;7,8,9] #se declara por filas las comas separa a los datos de las filas y los ";" separa a las filas
##
##N = [1:3;4:6;7:9] #tambien se puede declarar con rangos numericos

#String o cadena de caracteres
# se declara entre comillas simples o dobles

##'Hola Mundo'
##"Hola Mundo \a" # el simbolo \a hace que la computadora produzca un sonido
##
###estructuras, siempre se asignan a una variable
### las estructuras son "variables" que almacenan datos de distintos tipos por secciones
##x = {}
##x.secuencia = 1:5
##x.matriz = [1,2:3,4]
##x.string = 'Secuencia numerica'
##x.estructua = {}
##x.estructura.numero = 0x177
##x.estructura.letra = 'A'
##x

#tipos de operadores, devuelven un 1 o 0 dependiendo el resultado falso o verdadero
z=2
y=3
z + y
z - y
z * y
z / y
++z # z = z + 1
--z # z = z - 1
z < y
z <= y
z == y
z > y
z >= y
z != y #z diferente a y
z=1
y=0
z & y  #and
z | y  #or
not(z)
