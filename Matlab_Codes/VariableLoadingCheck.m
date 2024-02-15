clc
clear all;
%% Input Data
a_ol = 0;
dk_ol = 0;
r_pol = 0;
N = 0;
VariableLoad  =  xlsread('VariableLoading_Sigma','CompressionOverLoad_Start');
% Walker method constants and Material
C0 = 6.89e-9;
C0 = C0/1000;
m = 3;
Gama0 = 0.82;
S_Y = 744;
%Loading
S_Max = VariableLoad(:,1);
S_Min = VariableLoad(:,2);
S_Res = -80;
%Initial condition
L_noth = 0.0012;% Length of Critical Notch
alpha = 1.1;
ai = 0.001;
a(1) = ai;
n = 0.5;% Life Counter Step
N = 1;% Life Cycle
i = 1;% Loading counter in one loading Spectrum

%%
while a(1)<0.009
   
for i=0.5:n:length(S_Max)/2 
    F = 1.122 / (a(2*i)/(a(2*i)+L_noth))^0.5;
    K_Min = F*S_Min(2*i)*(pi*a(2*i))^0.5;
    K_Max = F*S_Max(2*i)*(pi*a(2*i))^0.5;
    K_Res = F*S_Res*(pi*a(2*i))^0.5;
    R(2*i) = (K_Min + K_Res )/ (K_Max + K_Res);
    if R(2*i)>= 0
    Gama = Gama0;
    else
    Gama = 0;
    end
    
    dS = S_Max(2*i)-S_Min(2*i);
    dK(2*i) = K_Max - K_Min;
    r_p(2*i) = ((dK(2*i)/S_Y)^2)*(1/(4*pi));
    if ((a(2*i) > a_ol)&&(a(2*i)+r_p(2*i) < a_ol+r_pol))
    lambda = a_ol+r_pol-a(2*i);
    Phi = (r_p(2*i)/lambda)^alpha;
    else
    Phi = 1; 
    end       
    da_dN(2*i) = Phi*C0*(K_Max-K_Min)^m/(1-R(2*i))^(m*(1-Gama));
    a(2*i+1) = a(2*i) + da_dN(2*i)*n;
    
    if r_pol < r_p(2*i)
       dS_ol = dS; 
       r_pol = r_p(2*i);
       dk_ol = dK(2*i);
       a_ol = a(2*i);
    end 
    
end
a(1) = a(2*i);
N = N + 1;
end