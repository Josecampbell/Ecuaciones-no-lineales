function[]=pasos_punto_fijo()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Metodo Para Calcular ---------------------------%
%----------------------Punto fijo -----------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x;%comando syms es para definir los parametros de una funcion f(x)
p0=0.5;%punto Inicial del metodo punto fijo
Nmax=1000;%nÃºmero maximo de iteraciones
tol=0.00001;%tolerancia definida por el usuario 
f=x^3+x^2;
F=f;
f=matlabFunction(x^3+x^2);%funciï¿½n original al ser estudiada
g=matlabFunction(x-(x^3+x^2));%funciï¿½n convertida
[p]=punto_fijo(p0,tol,Nmax,g);%llamada  a la funciï¿½n punto fijo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------parametros de salidad--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%p son los resultados de las iteraciones de el metodo de punto fijo    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Graficas de los resultados----------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fp=f(p(1:length(p)));%puntos p(i) evaludos
a=min(min(p,p0));%extremo infeiror del intervalo
b=max(max(p,p0));%extremo superior del intervalo
close all
xn=zeros(1,length(p));%los xn es para graficar las raices p(i)
hold on;fplot(f,[a,b],'MarkerEdgeColor','y');line([-1000,1000],[0,0],'MarkerEdgeColor','k');scatter(p,fp,'MarkerEdgeColor','g');scatter(p,xn,'MarkerEdgeColor','r');legend('funcion','recta y=0','puntos sobre la curva','puntos sobre la recta y=0');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')  %coamando xlabel para colocar nombre a el eje x
ylabel('eje y')  %coamando label para colocar nombre a el eje y
title('Metodo Punto fijo')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- paso 1 convertir la funciï¿½n en uno de la forma g(x)=x-f(x)
%--- paso 2 calcular un p0 para g(x) de ser posible
%--- paso 3 evaluar g(p0)=p(i)  
%--- paso 4  repetir el paso 3 hasta que (po-p(i)<tol) o hasta que se
%termine Nmax
%--- paso 5 actualizar p0=p(i)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('punto_fijo.mat','p','fp') %comando save para guardar los resultados en un archivo .mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------Informe de los resultados ----------------------%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 error=Error(F,p,p0);
    fileID=fopen('punto fijo.txt','w'); %nombre de el archivo txt llamado punto fijo
    Resultados=(1:length(p))'; %primera columna indica las iteraciones
    Resultados(:,2)=p';  %segunda columna indica los xn
    Resultados(:,3)=fp'; %tercera columna indica los f(xn)
    fprintf(fileID,'%5s\t \t %15s\t \t \t %10s\t \t \t %20s\t \t \t %10s\n','íteraciones','xn=f(xn)','f(xn)','Error estimado','f(x)');
    fprintf(fileID,'%d\t \t \t \t \t %20.15f\t %20.15f\t %20.15f\t %20s\n',Resultados(1,:)',error,char(F));
    fprintf(fileID,'%d\t \t \t \t \t %20.15f\t  %20.15f\n',Resultados(2:size(Resultados,1),:)');
    fclose(fileID); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo Punto fijo ---------------------------%
%---------------------- cap 2 alg 2.2 -------------------------------%
%----------------------Libro Richard L Burden -----------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[p]=punto_fijo(p0,tol,Nmax,g)
clc
format long
        for i=1:Nmax 
           if(i<Nmax)
                p(i)=g(p0); %calculo del candidato i al punto fijo
                    if(abs(p(i)-p0)<tol) %condiciï¿½n de parada del punto fijo obtenido
                        return;
                    end
                 p0=p(i); %actualizando p0 con el p(i) obtenido
           else
               return;
           end
        end
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Estimación de Error ---------------------------%
%---------------------- cap 2 algoritmo 2.2 -------------------------------%
%----------------------Libro Richard L Burden -----------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[error]=Error(F,p,p0)
syms x
F=F-x;
df=diff(F);
df=matlabFunction(df);
k=df(p(length(p)));
    if(abs(k)<1 && abs(k)>0)
        maximo=max([p0-p(1) p(length(p))-p0]);
        error=k^length(p)*maximo;
    else
        fprintf('Error no es posible hallar el punto fijo\n');
       return;
    end
end