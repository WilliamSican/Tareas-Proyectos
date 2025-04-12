###funciones
##x = hipotenusa #sintaxis para pedir 1 valor
##[x,b] = hipotenusa(1,2) #sintaxis para pedir 2 valores
#grafica
##x = [-3:0.1:1]; # forma de declara de donde a donde se evalua la funciones
##x = linspace(-3,1,50); # 2da forma
##plot(x, funcion(x),'Color','red')#color cambia el color en el que se dibuja la grafica
#'LineStyle','-' cambia el estilo en que se dibuja la grafica
##title('Titulo')
##ylabel('eje y')
##xlabel('eje x')
##stem(x, funcion(x)) #ploteo discreto


#2 funciones en la misma grafica
x = [0:0.1:4*pi]
y1 = sin(x);
y2 = cos(x);

hold on;
p1 = plot(x,y1);
p2 = plot(x,y2);
set(p1,'Color','red', 'LineWidth',2);
set(p2,'Color','red', 'LineWidth',1);
ylabe('eje y');
xlabel('eje x');
title('Seno y coseno');
legend('seno', 'coseno');
hold off;  #hold on y hold off indica que todo lo que esta dentro es de una misma grafica
