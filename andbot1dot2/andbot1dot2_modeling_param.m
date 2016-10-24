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
VQ_MAX = 520;
Tsample = 0.01; %loop time


%% plant_Vel

num = [0 0.261065];
den = [1 2.5006];
Plant_Vel = tf(num,den)
figure;
subplot(2,2,1)
bode(Plant_Vel);
hold on;

%% differential equation (velocity measurement)


Diff_Vel_n1 = tf([0 1],[1 0]);
Diff_Vel_n2 = tf([0 1],[1,0],'OutputDelay',Tsample);
Diff_Vel = 1/Tsample*parallel(Diff_Vel_n1,-Diff_Vel_n2);

open_loop_PlantDiff_Vel = series(Plant_Vel,Diff_Vel)
subplot(2,2,2);
bode(open_loop_PlantDiff_Vel,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_Vel);
hold on;
% figure;
% step(open_loop_PlantDiff_Vel,'b')

%% velocity controller

alpha = 2000;
k = 1;
time_constant = 10;
num_controller = k * [time_constant 1]
den_controller = [time_constant * alpha 1]
controller = tf(num_controller, den_controller) 

% PI controller
Kp = 1500;
Ki = 1;
PI_controller = tf([Kp Ki],[1 0]);

%% Plant_Vel + diff_Vel + controller
open_loop_PlantDiff_VelController = series(open_loop_PlantDiff_Vel,PI_controller)
subplot(2,2,3);
bode(open_loop_PlantDiff_VelController,'r',open_loop_PlantDiff_Vel,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;

%% plant_Omega

num_Omega = [0 2.4105e-2];
den_Omega = [1 8.40336];
Plant_Omega = tf(num_Omega,den_Omega)
figure;
subplot(2,2,1)
bode(Plant_Omega);
hold on;

%% differential equation (velocity measurement)

Diff_Omega_n1 = tf([0 1],[1 0]);
Diff_Omega_n2 = tf([0 1],[1,0],'OutputDelay',Tsample);
Diff_Omega = 1/Tsample*parallel(Diff_Omega_n1,-Diff_Omega_n2);

open_loop_PlantDiff_Omega = series(Plant_Omega,Diff_Omega)
subplot(2,2,2);
bode(open_loop_PlantDiff_Omega,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_Vel);
hold on;
% figure;
% step(open_loop_PlantDiff_Vel,'b')

%% omega controller

% PI controller
Kp = 1500;
Ki = 10000;
PI_Omega_controller = tf([Kp Ki],[1 0]);
subplot(2,2,3);
bode(PI_Omega_controller);
hold on;
%% Plant_Omega + diff_Omega + controller
open_loop_PlantDiff_OmegaController = series(open_loop_PlantDiff_Omega,PI_Omega_controller)
subplot(2,2,4);
bode(open_loop_PlantDiff_OmegaController,'r',open_loop_PlantDiff_Omega,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;


%sim('BLDCmotor_modeling')