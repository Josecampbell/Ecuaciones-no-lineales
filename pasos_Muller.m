function[]=pasos_Muller()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0=0.5;%primer punto inicial
x1=-0.5;%segundo punto inicial
x2=0;%tercer punto inicial
tol=0.00001;%tolerancia definida por el usuario
Nmax=15;%nÃºmero maximo de iteraciones
syms x;%el comando syms define un variable x para las funciones tipo f(x)
f=16*x^4-40*x^3+5*x^2+20*x+6;
F=f;
f=matlabFunction(f);%funciï¿½n que desea estudiar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------LLamada al metodo--------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=Muller(x0,x1,x2,tol,Nmax,f);%llamada a el Metodo Muller
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Parametros de salidad---------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fp=f(p);%Imagenes de las raices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------validaciÃ³n de los resultados----------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if(imag(p(length(p)))==0) %graficar si las raices son reales
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %---------------------Graficas de los resultados---------------------%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         close all
        xn=zeros(1,length(p));
        a=min(min(p));%extremo inferior del íntervalo
        b=max(max(p));%extremo Superior del íntervalo
        hold on;fplot(f,[a,b]);line([-1000,1000],[0,0]);scatter(p,fp);scatter(p,xn);legend('funcion','recta y=0');hold off;
        xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
        ylabel('eje y')%coamando label para colocar nombre a el eje y
        title('Metodo Muller')%el comando title para colocar nombre a las graficas
         save('Muller.mat','p','fp')%comando para guardar los resultados de el metodo de Muller 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------Informe de los resultados ----------------------%
  %---------------------De las Raíces Reales ---------------------------%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileID=fopen('Muller.txt','w'); %nombre de el archivo txt Muller
    Resultados=(1:length(p))'; %primera columna indica las iteraciones
    Resultados(:,2)=p';  %segunda columna indica los xn
    Resultados(:,3)=fp'; %tercera columna indica los f(xn)
    fprintf(fileID,'%5s\t %15s\t %10s %10s\n','f(x)','íteraciones','xn=f(xn)','f(xn)');
    fprintf(fileID,'%10s\t %d\t %12.8f\t  %12.8f\n',char(F),Resultados(1,:)');
    fprintf(fileID,'\t \t \t \t %d\t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
    fclose(fileID); 
  else 
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %---------------------Graficas de los resultados----------------------%
     %-------------grafica de las partes reales e imaginarias--------------%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      close all
      reales=real(p(4:length(p)));
      imaginario=imag(p(4:length(p)));
      fr=real(fp(4:length(p)));
      fi=imag(fp(4:length(p)));
       x=4:length(p);
     subplot(1,2,1),hold on;plotyy(x,reales,x,imaginario);hold off; legend('parte Real','Parte Imaginaria');title('comportamiento de la sucesión de Raíces');
     subplot(1,2,2),hold on;plotyy(x,fr,x,fi);hold off; legend('Imagenes de la parte Real','Imagenes de la parte Imaginaria');title('comportamiento de la sucesiones de Imagenes');
     save('Muller.mat','p','fp')%comando para guardar los resultados de el metodo de Muller 
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %---------------------Informe de los resultados ----------------------%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileID=fopen('Muller.txt','w'); %nombre de el archivo txt Muller
    Resultados=(1:length(p))'; %primera columna indica las iteraciones
    Resultados(:,2)=p';  %segunda columna indica los xn
    Resultados(:,3)=f(p)'; %tercera columna indica los f(xn)
    fprintf(fileID,'\t %5s\t %15s\t %10s %10s\n','íteraciones','xn=f(xn)','f(xn)','f(x)');
    fprintf(fileID,'\t \t \t \t %d\t %12.8f\t %12.8f\t %10s\n',Resultados(1,:)',char(F));
    fprintf(fileID,'\t \t \t \t %d\t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
    fclose(fileID); %comando para cerrar el archivo
  end
 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo ----------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[p]=Muller(x0,x1,x2,tol,Nmax,f)
clc
format long
h1=x1-x0;
h2=x2-x1;
delta1=(f(x1)-f(x0))/h1;
delta2=(f(x2)-f(x1))/h2;
d=(delta2-delta1)/(h2+h1);
p=[x0 x1 x2];
for i=4:Nmax
    b=delta2+h2*d;
    D=sqrt((b^2-4*f(x2)*d));
    if(abs(b-D)<abs(b+d))
        E=b+D;
    else
        E=b-D;
    end
    
    h=-2*f(x2)/E;
    p(i)=x2+h;
    
    if(abs(h)<tol)
        return    
    end
    x0=x1;
    x1=x2;
    x2=p(i);
    h1=x1-x0;
    h2=x2-x1;
    delta1=(f(x1)-f(x0))/h1;
    delta2=(f(x2)-f(x1))/h2;
    d=(delta2-delta1)/(h2+h1);
end

end