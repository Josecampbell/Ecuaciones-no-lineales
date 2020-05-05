function[]=Newton_sistema()
clc
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=3;%Número de variables del sistema
x= sym('x',[1,n]); %comando syms es para definir los parametros de una funcion f(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Funciones no lineales del sistema
F=[3*x(1)-cos(x(2)*x(3))-1/2;x(1)^2-81*(x(2)+0.1)^2+sin(x(3))+1.06;exp(-x(1)*x(2))+20*x(3)+(10*pi-3)/3];
x0=[0.1 0.1 -0.1];%punto Inicial
N=15;%número de iteraciones maximas
tol=0.0000000000001;%tolerancia definidad
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------llamada al metodo-------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=Newton(F,x0,x,N,tol);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------parametros de salidad---------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------------------------------------------------
%X solución aproximada del sistema homogeneo no lineal con sus iteraciones
%en cada columna
%------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Graficas de los resultados----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------calculo del Error-------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux=diff(X);
Error=NaN;
for i=1:size(aux,1)
   Error(i+1)=norm(aux(i,:),inf);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------Informe de los resultados ----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Iteraciones=1:size(X,1);
Resultados(:,1)=Iteraciones;
Resultados(:,2:size(X,1)+1)=X;
Resultados(:,size(Resultados,2)+1)=Error;
fileID=fopen('Newton_sistema.txt','w'); %nombre de el archivo txt llamado Newton sistema
fprintf(fileID,'%10s\n','soluciones');
fprintf(fileID,'%10s\t \t \t %5s\t \t \t %10s\t \t \t \t %5s\t \t \t \t%10s\n','íteraciones','x1','x2','x3','Error');
fprintf(fileID,'%d\t %20.5f\t  %20.5f\t  %20.5f\t %20.5f\n \n',Resultados');
Imagenes(:,1)=Iteraciones;
for i=1:size(X,1)
    Imag(i,:)=double(subs(F,x,X(i,:)));
end
Imagenes(:,2:size(Imag,1)+1)=Imag;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------calculo del Error-------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux=diff(Imagenes);
Error=NaN;
for i=1:size(aux,1)
   Error(i+1)=norm(aux(i,:),inf);
end
Imagenes(:,size(Imagenes,2)+1)=Error;
fileID=fopen('Newton_sistema.txt','a'); %nombre de el archivo txt llamado Newton sistema
fprintf(fileID,'%10s\n','Imagenes de las soluciones');
fprintf(fileID,'%10s\t \t \t %5s\t \t \t %10s\t \t \t \t %5s\t \t \t \t%10s\n','íteraciones','f(x1)','f(x2)','f(x3)','Error');
fprintf(fileID,'%d\t %20.5f\t  %20.5f\t  %20.5f\t %20.5f\n \n',Imagenes');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo ----------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[X]=Newton(F,x0,x,N,tol)
X(1,:)=x0;
J=jacobian(F);
Fxi=double(subs(F,x,x0));
Jxi=double(subs(J,x,x0));
xi=x0-(Jxi\Fxi)';
for i=2:N
    if(norm(X(i-1,:)-xi,inf)<tol)
        X(i,:)=xi;
        return;
    else
        Fxi=double(subs(F,x,xi));
        Jxi=double(subs(J,x,xi));
        xi=xi-(Jxi\Fxi)';
          X(i,:)=xi;
    end
end

end