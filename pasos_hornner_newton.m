function[]=pasos_hornner_newton()
format long
syms x
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Entrada de Datos--------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
an=[2 0 -3 3 -4]; %coeficientes de el polinomio P en orden decendente
x0=-2; %punto a evaluar en el polinomio P
[raices]=horner_newton(x0,an); %llamada a el Metodo Horner_newton
save('Hornner_newton.mat','raices')%comando utilizado para guardar las ra√≠ces
polinomio=funcion(an); %esta funci√≥n es usada para construir el polinomio
F=polinomio;
f=matlabFunction(polinomio);
fp=f(raices);%las raices evaluadas en el polinomio
a=min(raices);%intervalo izquierdo donde queremos observar el estudio
b=max(raices);%intervalo Derecho donde queremos observar el estudio
hold on;fplot(f,[a,b],'MarkerEdgeColor','r');line([-1000,1000],[0,0]);scatter(raices,fp,'MarkerEdgeColor','g');legend('funci√≥n','recta y=0','Puntos evaludos en la funcion');hold off;
%el comando fplot(f,[a,b]) es para graficar curvas f en un intervalo [a,b]
%el comando line para graficar rectas [x1,x2];[y1,y2]
%el comando scatter es para graficar eun conjunto de puntos (x,y)
xlabel('eje x')%coamando xlabel para colocar nombre a el eje x
ylabel('eje y')%coamando label para colocar nombre a el eje y
title('Metodo Hornner Newton')%el comando title para colocar nombre a las graficas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %---------------------Informe de los resultados ---------------------%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 fileID=fopen('Horner Newton.txt','w'); %nombre de el archivo txt Horner Newton
 Resultados=(1:length(raices))'; %primera columna indica las iteraciones
 Resultados(:,2)=raices';  %segunda columna indica los xn
 Resultados(:,3)=fp'; %tercera columna indica los f(xn)
  fprintf(fileID,'%5s\t \t %15s\t %10s %10s\n','Ìteraciones','xn','f(xn)','f(x)');
  fprintf(fileID,'%d\t \t \t \t \t %12.8f\t %12.8f\t %10s\n',Resultados(1,:)',char(F));
  fprintf(fileID,'%d\t \t \t \t \t %12.8f\t  %12.8f\n',Resultados(2:size(Resultados,1),:)');
  fclose(fileID); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------funci√≥n usada para construir el polinomio--------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[polinomio]=funcion(an)
syms x;
polinomio=0;%polinomio
n=length(an)-1;%grado de el polinomio
potencias=n:-1:1;%potencias de el polinomio
for i=1:length(potencias)
    polinomio=polinomio+an(i)*x^potencias(i); %construyendo el polinomio
end
polinomio=polinomio+an(length(an));%termino independiente de el polinomio
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo --------------------------------------%
%----------------------Horner Newton---------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[raices]=horner_newton(x0,x)
raices(1)=x0;
    for i=2:length(x)
        [y,z]=Horner(raices(i-1),x);%llamada al metodo de Horner para calcula P(x0) y P'(x0)
        raices(i)=raices(i-1)-y/z;%metodo de newton en la iteraciÛn i para el calculo de raÌces
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------- Metodo --------------------------------------%
%----------------------Horner -----------------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[y,z]=Horner(x0,x)%metodo de horner
format long
z=x(1);
y=x(1);
    for j=2:length(x)-1
        y=x0*y+x(j);%c·lculo de P(x0) en la iteracion i
        z=x0*z+y;%c·lculo de P'(x0) en la iteracion i
    end
     y=x0*y+x(length(x));
end