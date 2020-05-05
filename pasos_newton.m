function[]=pasos_newton()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Metodo Para Calcular ---------------------------%
%----------------------Newton ó Newton Rapson--------------------------%
%----------------------algoritmo 2.3 cap 2-----------------------------%
%----------------------Libro Richard L. Burden-------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x;%comando syms es para definir los parametros de una funcion f(x)
p0=-2;%punto Inicial del metodo punto fijo
Nmax=15;%nÃºmero maximo de iteraciones
tol=0.00001;%tolerancia definida por el usuario
F=x^3+x^2;%funcion al ser estudiada
F=x-F;%funcion modificada
f=matlabFunction(F);%funciï¿½n original al ser estudiada
[p]=Newton(p0,tol,Nmax,f,F);%llamada a la funcion newton 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------parametros de salidad---------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p vector de los candidatos a raices calculadas 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Graficas de los resultados----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
fp=f(p);%puntos p(i) evaludos en la funcion f
a=min(min(p,p0));%extremo inferior del íntervalo
b=max(max(p,p0));%extremo Superior del íntervalo
close all
xn=zeros(1,length(p));%nodos en la recta y=0
hold on;fplot(f,[a,b],'MarkerEdgeColor','k');line([-1000,1000],[0,0],'MarkerEdgeColor','b');scatter(p,fp,'MarkerEdgeColor','g');scatter(p,xn,'MarkerEdgeColor','r');legend('funcion','recta y=0','puntos sobre la curva','puntos sobre la recta y=0');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
ylabel('eje y')%coamando label para colocar nombre a el eje y
title('Metodo Newton')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- paso 1 calcular un p0 para g(x) de ser posible
%--- paso 2   calcular el p(i) de la forma p(i)=p0-f(p0)/fÂ´(p0) iterado i
%del metodo de newton
%--- paso3  repetir el paso 2 hasta que (po-p(i)<tol) o hasta que se
%termine Nmax
%--- paso 4 actualizar p0=p(i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('Newton.mat','p','fp')%comando save para guardar los resultados en un archivo .mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------Informe de los resultados ----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileID=fopen('Newton.txt','w'); %nombre de el archivo txt llamado Newton
    Resultados=(1:length(p))'; %primera columna indica las iteraciones
    Resultados(:,2)=p';  %segunda columna indica los xn
    Resultados(:,3)=fp'; %tercera columna indica los f(xn)
      fprintf(fileID,'%5s\t \t %15s\t %10s %10s\n','íteraciones','xn','f(xn)','f(x)');
      fprintf(fileID,'%d\t \t \t \t \t %12.8f\t %12.8f\t %10s\n',Resultados(1,:)',char(F));
      fprintf(fileID,'%d\t \t \t \t \t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
    fclose(fileID); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo ----------------------------------------%
%----------------------Newton ó Newton Rapson--------------------------%
%----------------------Univariable-------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[p]=Newton(p0,tol,Nmax,f,F)
   T=diff(F); %la curva t es la derivada de f es decir T=F'
   t=matlabFunction(T);
    for i=1:Nmax
        p(i)=p0-f(p0)/t(p0); %iterado i del metodo de Newton
        if(abs(p(i)-p0)<tol)
            return
        end
        p0=p(i);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Estimación de Error ---------------------------%
%---------------------- cap 2 algoritmo 2.3-------------------------------%
%----------------------Libro Richard L Burden -----------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
