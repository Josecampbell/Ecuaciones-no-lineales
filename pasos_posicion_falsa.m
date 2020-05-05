function[]=pasos_posicion_falsa()
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x;%el comando syms es para definir parametros de las funciones
p0=0.5;%punto Inicial del metodo posicion falsa
p1=pi/4;%punto Inicial del metodo posicion falsa
Nmax=15;%nÃºmero maximo de iteraciones
tol=0.00001;%tolerancia definida por el usuario
f=cos(x)-x;
F=f;
f=matlabFunction(f);%funciï¿½n original al ser estudiada
[p]=posicion_falsa(p0,p1,tol,Nmax,f);%llamada a el metodo posicion falsa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Graficas de los resultados----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fp=f(p(1:length(p)));%puntos p(i) evaludos
xn=zeros(1,length(p));%nodos en la recta y=0
a=min(min(p,p0));%extremo inferior del íntervalo
b=max(max(p,p0));%extremo Superior del íntervalo
hold on;fplot(f,[a,b],'MarkerEdgeColor','y');line([-1000,1000],[0,0]);scatter(p,fp,'MarkerEdgeColor','g');scatter(p,xn,'MarkerEdgeColor','r');legend('funcion','recta y=0','puntos sobre la curva','puntos sobre la recta y=0');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
ylabel('eje y')%coamando label para colocar nombre a el eje y
title('Metodo posicion falsa')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Pasos de el Metodo-----------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- paso 1 definir los puntos iniciales p0,p1
%--- paso 2  verificar si esxiste una raÃ­z en ese intervalo
%--- paso 3  ha cer el calculo de p(i) de la forma p(i)=p1-q1*(p1-p0)/(q1-q0) iterado i
%del metodo de la posicion falsa
%--- paso 4 repetir el paso 3 hasta que (po-p(i)<tol) o hasta que se
%termine Nmax
%--- paso 5 verificar 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Los Resultados son Guardados en un archivo.mat con el siguiente comando  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('posicion_falsa.mat','p','fp') %guardar Resultados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------Informe de los resultados ----------------------
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileID=fopen('posicion falsa.txt','w'); %nombre de el archivo txt posicion falsa
    Resultados=(1:length(p))'; %primera columna indica las iteraciones
    Resultados(:,2)=p';  %segunda columna indica los xn
    Resultados(:,3)=fp'; %tercera columna indica los f(xn)
    fprintf(fileID,'%5s\t \t %15s\t %10s %10s\n','íteraciones','xn','f(xn)','f(x)');
    fprintf(fileID,'%d\t \t \t \t \t %12.8f\t %12.8f\t %10s\n',Resultados(1,:)',char(F));
    fprintf(fileID,'%d\t \t \t \t \t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
    fclose(fileID); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------- Metodo ----------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[p]=posicion_falsa(p0,p1,tol,Nmax,f)
 if(f(p0)*f(p1)<0) %condicion para ver si existe un punto fijo en el intervalo [p0,p1]
        q0=f(p0); % la imagen de p0 es q0
        q1=f(p1); % la mimagen de p1 es q1
        p(1)=p0;
        p(2)=p1;
        for i=3:Nmax
                 p(i)=p1-q1*(p1-p0)/(q1-q0);%iterado i del metodo de Newton
              if(abs(p(i)-p1)<tol) %condicion de parada
                  return;
              end
              if(f(p(i))*f(p1)<0) %condicion para actualizar el intervalo
                  p0=p1; %actualizando el extremo inferior del intervalo 
                  q0=q1;  %actualizando  la imagen de el extremo inferior del intervalo 
                  p1=p(i);  %actualizando el extremo superior del intervalo 
                  q1=f(p(i));  %actualizando la imagen de el extremo superior del intervalo 
              else
                  p0=p(i); %actualizando el extremo inferior del intervalo 
                  q0=f(p(i));  %actualizando  la imagen de el extremo inferior del intervalo 
              end
        end
       
 else
     fprintf('no es posible cvalcular un punto fijo \n') 
 end
 
end



