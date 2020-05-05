function[]=pasos_secante()
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x; %el comando syms es para definir parametros de las funciones
p0=pi;%punto Inicial del metodo secante
p1=2*pi;%punto Inicial del metodo secante
Nmax=100;%nÃºmero maximo de iteraciones
tol=0.00001;%tolerancia definida por el usuario
f=cos(x);
F=f;
f=matlabFunction(x-f);%funciï¿½n original al ser estudiada
[p]=secante(p0,p1,tol,Nmax,f);%llamada a la funciÃ³n secante
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %----------------------parametros de salidad--------------------------------
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % p vector de los candidatos a raices calculadas 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Grafico de los Resultados-----------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=matlabFunction(x+f);%funciÃ³n f original
a=min(p);%extremo inferior del íntervalo
b=max(p);%extremo Superior del íntervalo
close all
if(p0>0)
fp=f(p(1:length(p)));%puntos p(i) evaludos
xn=zeros(1,length(p));%nodos en la recta y=0
hold on;fplot(f,[a,b],'MarkerEdgeColor','y');line([-1000,1000],[0,0]);scatter(p,fp,'MarkerEdgeColor','g');scatter(p,xn,'MarkerEdgeColor','r');legend('funcion','recta y=0','puntos sobre la curva','puntos sobre la recta y=0');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
ylabel('eje y')%coamando label para colocar nombre a el eje y
title('Metodo posicion falsa')%el comando title para colocar nombre a las graficas
else
fp=f(p(1:length(p)));%puntos p(i) evaludos
xn=zeros(1,length(p));%nodos en la recta y=0
hold on;fplot(f,[p0,p(length(p))],'MarkerEdgeColor','y');line([-1000,1000],[0,0]);scatter(p,fp,'MarkerEdgeColor','g');scatter(p,xn,'MarkerEdgeColor','r');legend('funcion','recta y=0','puntos sobre la curva','puntos sobre la recta y=0');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
ylabel('eje y')%coamando label para colocar nombre a el eje y
title('Metodo posicion falsa')%el comando title para colocar nombre a las graficas
end
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
ylabel('eje y')%coamando label para colocar nombre a el eje y
title('Metodo secante')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Pasos de el Metodo Implementado------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- paso 1 calcular un p0 para g(x) de ser posible
%--- paso 2   calcular el p(i) de la forma p(i)=p0-f(p0)/fÂ´(p0) iterado i
%del metodo de newton
%--- paso3  repetir el paso 2 hasta que (po-p(i)<tol) o hasta que se
%termine Nmax
%--- paso 4 actualizar p0=p(i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Los Resultados odtenidos se guardan en un arcivo.mat 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('secante.mat','p','fp') %guardar Resultados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------Informe de los resultados ----------------------
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileID=fopen('secante.txt','w'); %nombre de el archivo txt secante
    Resultados=(1:length(p))'; %primera columna indica las iteraciones
    Resultados(:,2)=p';  %segunda columna indica los xn
    Resultados(:,3)=fp'; %tercera columna indica los f(xn)
    fprintf(fileID,'%5s\t %15s\t %10s %10s\n','f(x)','íteraciones','yn=f(xn)','f(xn)');
    fprintf(fileID,'%10s\t \t %d\t %12.8f\t  %12.8f\n',char(F),Resultados(1,:)');
    fprintf(fileID,'\t \t \t \t %d\t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
    fclose(fileID);                                      
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo -----------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[p]=secante(p0,p1,tol,Nmax,f)
q0=f(p0); %imagen de p0
q1=f(p1); %imagen de p1
p(1)=p0;
p(2)=p1;
for i=3:Nmax
     p(i)=p1-q1*(p1-p0)/(q1-q0); %formula para el calculo p(i) de el metodo de loa secante
     if(abs(p(i)-p1)<tol)
         return;
     end
     p0=p1;%actualizando p0
     q0=q1;%actualizando la imagen de p0
     p1=p(i); %actualizando p1
     q1=f(p(i));%actualizando la imagen de p1
end
end