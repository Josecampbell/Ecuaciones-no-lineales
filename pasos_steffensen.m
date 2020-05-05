function[]=pasos_steffensen()
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms x;
p=1.5;%punto Inicial del metodo punto fijo
Nmax=15;%n√∫mero maximo de iteraciones
tol=0.001;%tolerancia definida por el usuario
f=sqrt(10/(x+4));
F=f;
g=matlabFunction(f);%funciÔøΩn  al ser estudiada
[p]=steffensen(p,tol,Nmax,g);%llamada a la funcion steffensen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %----------------------parametros de salidad--------------------------------
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % p una matrix de cada columna j representa una iteraci√≥n los candidatos a raices calculadas 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Graficas de los resultados----------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g=matlabFunction(g-x);
fp=g(p);%puntos p(i) evaludos
aux=p(:);
aux2=fp(:);
xn=zeros(1,length(aux));%nodos en la recta y=0
a=min(min(aux));%extremo inferior del Ìntervalo
b=max(max(aux));%extremo Superior del Ìntervalo
hold on;fplot(g,[a,b],'MarkerEdgeColor','y');line([-1000,1000],[0,0]);scatter(aux,aux2,'MarkerEdgeColor','g');scatter(aux,xn,'MarkerEdgeColor','r');legend('funcion','recta y=0','puntos sobre la curva','puntos sobre la recta y=0');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
ylabel('eje y')%coamando label para colocar nombre a el eje y
title('Metodo Steffensen')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Pasos de el Metodo----------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- paso 1 definir los puntos iniciales p0,p1
%--- paso 2  verificar si esxiste una ra√≠z en ese intervalo
%--- paso 3  ha cer el calculo de p(i) de la forma p(i)=p1-q1*(p1-p0)/(q1-q0) iterado i
%del metodo de la posicion falsa
%--- paso 4 repetir el paso 3 hasta que (po-p(i)<tol) o hasta que se
%termine Nmax
%--- paso 5 verificar 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Los Resultados son Guardados en un archivo.mat con el siguiente comando  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('Steffensen.mat','p','fp') %guardar Resultados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------Informe de los resultados ----------------------
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileID=fopen('Steffensen.txt','w'); %nombre de el archivo txt secante
    Resultados=(1:length(aux))'; %primera columna indica las iteraciones
    Resultados(:,2)=aux';  %segunda columna indica los xn
    Resultados(:,3)=aux2'; %tercera columna indica los f(xn)
    fprintf(fileID,'%5s\t  \t \t %15s\t %10s %10s\n','f(x)','Ìteraciones','xn=f(xn)','f(xn)');
    fprintf(fileID,'%10s\t \t %d\t %12.8f\t  %12.8f\n',char(F),Resultados(1,:)');
    fprintf(fileID,'\t \t \t \t \t \t \t \t %d\t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
    fclose(fileID);    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Metodo -------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[p]=steffensen(p,tol,Nmax,g)
clc
format long
        for i=1:Nmax
            p(2,i)=g(p(1,i)); %imagen de p(1)
            p(3,i)=g(p(2,i)); %imagen de g(p(1))
            p(4,i)=p(1,i)-(p(2,i)-p(1,i))^2/(p(3,i)-2*p(2,i)+p(1,i)); %calculo de el nuevo p en funcion de p1,p2,p3
            if(abs(p(4,i)-p(1,i))<tol) %condicion de parada
                return;
            else
               p(1,i+1)=p(4,i); %acttualizando p(1) en la etapa  i 
            end
        end
       
end