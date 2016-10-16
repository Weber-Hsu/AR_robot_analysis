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

%% plant

num = [0 7.415e-3];
den = [1 10];
Plant_Vel = tf(num,den)
figure;
subplot(2,2,1)
bode(Plant_Vel);
hold on;

%% differential equation (velocity measurement)
Tsample = 0.01; %loop time

Diff_Vel_n1 = tf([0 1],[1 0]);
Diff_Vel_n2 = tf([0 1],[1,0],'OutputDelay',Tsample);
Diff_Vel = 1/Tsample*parallel(Diff_Vel_n1,-Diff_Vel_n2);

open_loop_PlantDiff_Vel = series(Plant_Vel,Diff_Vel)
subplot(2,2,2);
bode(open_loop_PlantDiff_Vel,'b');
set(gcf,'currentaxes',open_loop_PlantDiff_Vel);

% figure;
% step(open_loop_PlantDiff_Vel,'b')

%% velocity controller

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