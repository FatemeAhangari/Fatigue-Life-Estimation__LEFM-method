clc
clear all;
%% Input Data
a_ol = 0;
dk_ol = 0;
r_pol = 0;
N = 0;
VariableLoad  =  xlsread('VariableLoading_SigmaY','TensileOverLoad_Start');
% Walker method constants and Material
C0 = 6.89e-9;
C0 = C0/1000;
m = 3;
Gama0 = 0.82;
S_Y = 744;
%Loading
S_Max = VariableLoad(:,1);
S_Min = VariableLoad(:,2);
S_Res = 0;
%Initial condition
L_noth = 0.00012;% Length of Critical Notch
alpha = 1.1;
ai = 0.001;
a(1) = ai;
n = 1;% Life Counter Step
N = 1;% Life Cycle
i = 1;% Loading counter in one loading Spectrum

%%
while a(1)<0.009
   
for i=1:n:length(S_Max) 
    F = 1.122 / (a(i)/(a(i)+L_noth))^0.5;
    K_Min = F*S_Min(i)*(pi*a(i))^0.5;
    K_Max = F*S_Max(i)*(pi*a(i))^0.5;
    K_Res = F*S_Res*(pi*a(i))^0.5;
    R(i) = (K_Min + K_Res )/ (K_Max + K_Res);
    if R(i)>= 0
    Gama = Gama0;
    else
    Gama = 0;
    end
    
    dS = S_Max(i)-S_Min(i);
    dK(i) = K_Max - K_Min;
    r_p(i) = ((dK(i)/S_Y)^2)*(1/(4*pi));
    if ((a(i) > a_ol)&&(a(i)+r_p(i) < a_ol+r_pol))
    lambda = a_ol+r_pol-a(i);
    Phi = (r_p(i)/lambda)^alpha;
    else
    Phi = 1; 
    end       
    da_dN(i) = Phi*C0*(K_Max-K_Min)^m/(1-R(i))^(m*(1-Gama));
    a(i+1) = a(i) + da_dN(i)*n;
    
    if r_pol < r_p(i)
       dS_ol = dS; 
       r_pol = r_p(i);
       dk_ol = dK(i);
       a_ol = a(i);
    end 
    
end
a(1) = a(i);
N = N + n;
end