%% Out of reach ai
clear all
clc;
%% Data
b = -0.064;
Sigmaf_Prime = 1170;
C0 = 6.89e-9;
n = 3;
Gama = 0.82;
C_Prime = (1/2)*(2*Sigmaf_Prime)^(-1/b);
Y = 1.122;
S_Max = 367.47;
S_Min = 36.747;
R = 0.1;
Num = 100;
%% Main Part
dsigma = S_Max - S_Min;
ai = linspace(5e-5,10e-3,Num);
C_Walker = C0/(1-R)^(n*(1-Gama));
C_Walker = C_Walker / 1000;
C = C_Walker;

for i=1:Num
    N(i) = (1./(Y^n*C.*dsigma.^n*pi^(n/2))) .* ((ai(i) +((dsigma.^((-1/b)-n))./((Y^n*C*C_Prime*pi^(n/2)).*(n/2-1))).^(1/(n/2-1))).^(1-n/2))./(n/2-1);
end
plot(ai,N)