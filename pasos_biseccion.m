function[]=pasos_biseccion()
clc
format long
syms x; %comando syms es para definir los parametros de una funcion f(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=1; %extremo inferior del intervalo
b=2;%extremo superior  del intervalo
Nmax=30;%n煤mero maximo de iteraciones
tol=0.01;%tolerancia definida por el usuario
f=12*x-3*x^4-2*x^6;
F=f;
f=matlabFunction(f);
%el comando matlabFunction(f(x)) es par definir funciones esplicitas que
%depende de la variable x

[p,fp]=biseccion(a,b,tol,Nmax,f); %llamada  a la funci贸n bisecci贸n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------parametros de salidad--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p vector raices calculadas
% fp vector de imagenes de las raices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Graficas de los resultados----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all %comando para cerrar la ventana de graficas si esta abierta
xn=zeros(1,length(p)); %los xn es para graficar las raices p(i)
hold on;fplot(f,[a,b],'MarkerEdgeColor','r');line([a,b],[0,0]);scatter(p,fp,'MarkerEdgeColor','g');scatter(p,xn,'MarkerEdgeColor','y');legend('funcion','recta y=0','puntos sobre la curva','puntos sobre la recta y=0');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x') %coamando xlabel para colocar nombre a el eje x
ylabel('eje y') %coamando label para colocar nombre a el eje y
title('Metodo biseccion')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- paso 1 verificar si existe una ra铆z en el Intervalo
%--- paso 2 hacer el calculo de el punto medio
%--- paso 3 verificar si esa es la ra铆z 贸 si es proxima a la ra铆z
%--- paso 4  ver cual de los extremos vamos a modificar
%--- paso 5 repetir los pasos del 1 al 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('biseccion.mat','p','fp') %comando save para guardar los resultados en un archivo .mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Informe de los resultados ----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Error=(b-a)/2^(length(p));
fileID=fopen('biseccion.txt','w'); %nombre de el archivo txt llamado biseccion
Resultados=(1:length(p))'; %primera columna indica las iteraciones
Resultados(:,2)=p';  %segunda columna indica los puntos medios
Resultados(:,3)=fp'; %tercera columna indica las imagenes de los puntos medios
fprintf(fileID,'%5s\t %15s\t %10s %15s\t  %10s\n','韙eraciones','xn=(an+bn)/2','f(xn)','Error Estimado','f(x)');
fprintf(fileID,'\t \t %d\t %12.8f\t  %12.8f\t %12.8f\t %10s\n',Resultados(1,:)',Error,char(F));
fprintf(fileID,'\t \t %d\t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
fclose(fileID);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo ----------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[p,fp]=biseccion(a,b,tol,Nmax,f)
format long
fa=f(a); % funci贸n evaluada en el extremo inferior del intervalo
fb=f(b); % funci贸n evaluada en el extremo superiror del intervalo
if(fa*fb<0) %condici贸n de validaci贸n para ver si existe una ra铆z en el intervalo
    for i=1:Nmax
        p(i)=(a+b)/2;% calculo del nuevo extremo del intervalo
        fp(i)=f(p(i)); % funci贸n evaluada en nuevo extremo del intervalo
        if(abs(fp(i))<tol) %condici贸n de parada
            return
        else  % si no pasa a la siguiente iteraci贸n
            if(i==Nmax) %condici髇 de parada si llega al n鷐ero maximo de iteraciones
                return
            else
                if(fp(i)*fa>0) %condici贸n para ver que extremo se sustituye
                    a=p(i); %si se cumple esta condici贸n se toma p como el extremo inferior
                    fa=fp(i);
                else
                    b=p(i);%si no se cumple esta condici贸n se toma p como el extremo superior
                end
            end
            
        end
        
    end
else
    fprintf('no hay ra铆ces en ese Intervalo\n')
end

end


