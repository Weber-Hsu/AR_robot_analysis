clc ; clear ;

syms R L J B;
syms Kt Ke ; 

%% mechanical parameters

m = 18.8; % unit: kg
l = 0.41367 / 2; % half of wheel separation
r = 0.085; %wheel radius

%% wheel motor parameters
P = 30;
ke = 0.31; 
kt = 0.01; % to be determined
J = 0.1; % to be determined
B = 0.1; % to be determined
L = 0.1; % to be determined
R = 0.02;

%% practical condition
Vq_MAX = 520;
Tsample = 0.04; %loop time






