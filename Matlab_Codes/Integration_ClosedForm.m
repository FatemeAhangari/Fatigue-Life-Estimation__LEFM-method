clear all
clc;
syms a
%% Data
% Geometry
b = 2*15;
t = 30;
F = 1.122;

% Material
Sigma0 = 743;
Kc = 150;
m = 3;
m2 = 3;
Gama = 0.82;
C0 = 6.89e-9;
C2 = 2.3e-7;
L_noth = 0.00012;
% Loading
P = 281111;
P_Prime = P /(b*t*Sigma0);
R = 0.1;
DS = 331;
S_Max = 367.47;

%% Crack Length
af = b * (P_Prime+1-(2*P_Prime*(P_Prime+1))^0.5);
af = af/1000;
ai = 0.001;
%% Walker
C_Walker = C0/(1-R)^(m*(1-Gama));
C_Walker = C_Walker / 1000;
C = C_Walker;
S = a/(a+L_noth);
F = 1.122/S^0.5;
f = 1/(C*(F*DS*(pi*a)^0.5)^m);
fint = int(f,a,[ai af]);
N_walker_integration = vpa (fint)
%% Forman
A = (1-R)*(Kc-F*S_Max*(pi*a)^0.5);
C2 = C2 / (A*1000);
f = 1/(C2*(F*DS*(pi*a)^0.5)^m2);
fint = int(f,a,[ai af]);
N_Forman_integration = vpa (fint)
%% Closed_Form
F =1.122;
N_Walker_Closed_Form = ((af)^(1-m/2)-(ai)^(1-m/2))/(C_Walker*(F*DS*pi^0.5)^m * (1-m/2))