clc ; clear ;

syms R L J B;
syms Kt Km ; 

P = 30;
Ke = 0.02; 
Kt = 0.01; % to be determined
J = 0.1; % to be determined
B = 0.1; % to be determined
L = 0.1; % to be determined
R = 0.02;
%S = subs(i_w,{R,L,Km,Kb,J,In,b,g},{2,0.5,0.015,0.015,0.2,0.02,2,2,30}) ;

sim('BLDCmotor_modeling')