clc ; clear ;

syms R L J B;
syms Kt Km ; 

% P = 30;
% ke = 0.02; 
% kt = 0.01; % to be determined
% J = 0.1; % to be determined
% B = 0.1; % to be determined
% L = 0.1; % to be determined
% R = 0.02;
%S = subs(i_w,{R,L,Km,Kb,J,In,b,g},{2,0.5,0.015,0.015,0.2,0.02,2,2,30}) ;

% P = 30;
% ke = 0.31;
% kt = 0.51; % to be determined
% J = 0.02; % to be determined
% B = 0.1; % to be determined
% L = 0.5; % to be determined
% R = 0.02;

P = 14;
ke = 11.623;
kt = 0.0859; % to be determined
J = 141e-7; % to be determined
B = 0.1; % to be determined
L = 0.324e-3; % to be determined
R = 0.218;

% sim('BLDCmotor_modeling')