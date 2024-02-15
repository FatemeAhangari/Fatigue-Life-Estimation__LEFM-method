%% Forman Method with residual Stress considerations + variable Shape Stress intensity factor "F(a)" 
clear all
clc;
%% Input Data
% Forman method constants
K_C = 150;
C2 = 2.3e-7;
C2 = C2/1000;
m2 = 3;
Gama0 = 0.82;
%Loading
S_Max = 367.47;
S_Min = 36.747;
S_Res = -80;
%Initial condition
L_noth = 0.00012;
ai = 0.001;
a(1) = ai;
dN = 1;
N = 1;
i = 1;

%% Life Estimation (Forman Method)
while a(i)<= 0.009
    F = 1.122 / (a(i)/(a(i)+L_noth))^0.5;
    K_Min = F*S_Min*(pi*a(i))^0.5;
    K_Max = F*S_Max*(pi*a(i))^0.5;
    K_Res = F*S_Res*(pi*a(i))^0.5;
    R(i) = (K_Min + K_Res )/ (K_Max + K_Res);
    da_dN = C2*(K_Max-K_Min)^m2/((1-R(i))*(K_C-K_Max));
    da = dN * da_dN;
    a(i+1) = a(i) + da;
    i = i + 1;
    N = N + 1;
end