#estructuras de control
x=1
y = 0
z = 5
##if (x > y && z < 0) #condicion anidada
##   'x es mayor a y'
##elseif (x == y || z < 0)
##   'x y y son iguales'
##else
##   'y es mayor a x'
##endif

### simepre se ejecutara la primera opcion que encuentre valida aunque mas adelante exista otra que tambien sea valida

#2da estructura while
##
##while(z < y)# mientras que z sea mayor a y, se ejecutara el codigo que este dentro de la estructura while
##    'Valor z'
##    z
##    ++z
##endwhile

#3ra estructura for
#como ejemplo se calcula la secuencia fibonacci
##fib = ones(1, 10); #ones funcion integrada, crea un vector de 10 poscisiones donde todos sus valores son 1
##for i = 3:10
##  fib(i) = fib(i-1) + fib(i-2);
##endfor
##fib
##
#manejo de errores/excepciones
##try #intenta ejecutar el siguiente codigo
##  m = [1:5;10:15]
##catch #codigo a ejecutar si el codigo anterior no se pudo o tuvo algun error al ejecutar
##  'No se pudo ejecutar, se continua con la ejecucion'
##end_try_catch

#operaciones basica con matrices
M = [1,2,5;4,5,8;9,5,0]
N = [0,1,3;8,10,7;7,2,0]
M + N
M - N
M * N
cross(M,N)# M X N, solo se puede hacer entre matrices de mas de 2X2
dot(M,N)
M' #matriz traspuesta
