%Daniela, Erick, José, Minerva
clear ; close all; clc
disp('UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO');
disp('FACULTAD DE INGENIERÍA');
disp('FUNDAMENTOS DE CONTROL - CRITERIOS DE ESTABILIDAD POLINOMIOS DE ORDEN N');
disp('INTEGRANTES: Daniela, Erick, José, Minerva');
disp(' ');
disp('CRITERIOS DE ESTABILIDAD');
disp('1. Criterio de estabilidad de Routh');
disp('2. Criterio de estabilidad de Jury');
n=input('Seleccione el criterio: \n');
disp(' ');
switch n
case 1
	clc
	disp('CRITERIO DE ESTABILIDAD DE ROUTH');
	disp('');
	ord = input('Ingresa el orden del polinomio: \n');
	pol = input('Ingresa los valores de los coeficientes (i.e. [an an-1 an-2 ... a0]): \n');
	polL = length(pol);

	if ((ord + 1) == polL)
    	fprintf('El orden del polinomio corresponde con los coeficientes ingresados.\n')
    	RMatC = round(polL/2);
    	RMat = zeros(polL,RMatC);
    	RMat(1,:) = pol(1,1:2:polL);
    
    	if (rem(polL,2) ~= 0)
        	RMat(2,1:RMatC - 1) = pol(1,2:2:polL);
    	else
       		RMat(2,:) = pol(1,2:2:polL);
    	end

    	e = 0.01;

    	for i = 3:polL
   
        	if RMat(i-1,:) == 0
            	orden = (polL - i);
            	c1 = 0;
            	c2 = 1;
        
            	for j = 1:RMatC - 1
                	RMat(i-1,j) = (orden - c1) * RMat(i-2,c2);
                	c2 = c2 + 1;
                	c1 = c1 + 2;
            	end
        	end
    
        	for j = 1:RMatC - 1
            	Primercu = RMat(i-1,1);
            	RMat(i,j) = ((RMat(i-1,1) * RMat(i-2,j+1)) - ....
            	(RMat(i-2,1) * RMat(i-1,j+1))) / Primercu;
        	end
        
        	if RMat(i,1) == 0
            	RMat(i,1) = e;
        	end
    	end

    	Polosinest = 0;

    	for i = 1:polL - 1
        	if sign(RMat(i,1)) * sign(RMat(i+1,1)) == -1
            	Polosinest = Polosinest + 1;
        	end
    	end
    	disp(' ');
    	fprintf('MATRIZ ROUTH')
    	RMat

    	if Polosinest == 0
        	disp(' ');
        	fprintf('**** SISTEMA ESTABLE ****')
    	else
        	disp(' ');
        	fprintf('**** SISTEMA INESTABLE ****')
    	end

    	disp(' ');
    	fprintf('Número de polos inestables =%2.0f\n',Polosinest)

    	disp(' ');
    	raices = roots(pol);
    	fprintf('RAÍCES')
    	raices
    
	else
    	fprintf('El orden del polinomio no corresponde con los coeficientes ingresados.\n')
	end

case 2
	clc
	disp('CRITERIO DE ESTABILIDAD DE JURY');
	disp(' ');
end