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

num = [0 1.6095];
den = [1 1.7857];
P = tf(num,den,'InputDelay',0.4)
Intg = tf(1,[1,0])
Q =  tf(1,[1,0],'InputDelay',0.4);
Qall = Intg - Q                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
P0 = tf(num,den);
Tsample = 0.04;

P0all = P0 * Qall;
figure;
bode(P0all,'b')
Pall = P * Qall;
figure;
step(P0,'b',P,'r')
figure;
bode(P,'r',P0,'b')
figure;
bode(Pall,'r')

alpha = 2000;
k = 1;
time_constant = 10;
num_controller = k * [time_constant 1]
den_controller = [time_constant * alpha 1]
controller = tf(num_controller, den_controller) 

pcompensation = controller * P * Qall
figure;
bode(pcompensation,'g')

%sim('BLDCmotor_modeling')