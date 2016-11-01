clc ; clear ;
andbot1dot2_param; % param m file

simulation_time = 20; % set simulation time in simulink (Unit : sec)
%% common function
time_delay_tf = exp(-Tsample*tf('s')); % time delay system
input_Vel = 1;  % to simulink
input_Omega = 1; % to simulink

%% plant_Vel (after friction compensation + time delay)

num_Vel = [0 0.261065];
den_Vel = [1 2.5006];
Plant_Vel = tf(num_Vel,den_Vel);
figure(1);
subplot(2,2,1)
bode(Plant_Vel);
hold on;

open_loop_Plantdelay_Vel = series(Plant_Vel,time_delay_tf);
%% differential equation (velocity measurement)

Diff_Vel_n1 = tf([0 1],[1 0]);
Diff_Vel_n2 = tf([0 1],[1,0],'InputDelay',Tsample);
Diff_Vel = 1/Tsample*(Diff_Vel_n1 - Diff_Vel_n2);

open_loop_PlantDiff_Vel = series(open_loop_Plantdelay_Vel,Diff_Vel);
%subplot(2,2,3);
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

%% velocity loop PI controller
Kp_Vel = 1500;
Ki_Vel = 1;
PI_Vel_controller = tf([Kp_Vel Ki_Vel],[1 0]);

%% Plant_Vel + diff_Vel + controller
open_loop_PlantDiff_VelController = series(open_loop_PlantDiff_Vel,PI_Vel_controller)
subplot(2,2,3);
bode(open_loop_PlantDiff_VelController,'r',open_loop_PlantDiff_Vel,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;

%% Plant_Vel + diff_Vel + controller + FeedForward

num_Vel_ff = [4.99887];
den_Vel_ff = [3.2393];

%% plant_Omega (after friction compensation) + time delay

num_Omega = [0 3.2393];
den_Omega = [1 4.9887];
Plant_Omega = tf(num_Omega,den_Omega);
figure(2);
subplot(2,2,1)
bode(Plant_Omega,'g');
hold on;

open_loop_Plantdelay_Omega = series(Plant_Omega,time_delay_tf);
%% differential equation (Omega measurement)

Diff_Omega_n1 = tf([0 1],[1 0]);
Diff_Omega_n2 = tf([0 1],[1,0],'OutputDelay',Tsample);
Diff_Omega = 1/Tsample*parallel(Diff_Omega_n1,-Diff_Omega_n2);

open_loop_PlantDiff_Omega = series(open_loop_Plantdelay_Omega,Diff_Omega);
%subplot(2,2,2);
bode(open_loop_PlantDiff_Omega,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_Vel);
hold on;
% figure;
% step(open_loop_PlantDiff_Vel,'b')

%% omega controller

% PI controller
Kp_Omega = 1;
Ki_Omega = 0;
PI_Omega_controller = tf([Kp_Omega Ki_Omega],[1 0]);
% subplot(2,2,3);
% bode(PI_Omega_controller);
% hold on;

%% Plant_Omega + diff_Omega + controller
open_loop_PlantDiff_OmegaController = series(open_loop_PlantDiff_Omega,PI_Omega_controller);
subplot(2,2,3);
bode(open_loop_PlantDiff_OmegaController,'r',open_loop_PlantDiff_Omega,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;

%% Plant_Omega + diff_Omega + controller + FeedForward

num_Omega_ff = [4.99887];
den_Omega_ff = [3.2393];

sim('andbot1dot2_voltage_loop_frictioncompensation')
%% data management

% plot Vel_loop
t_Vel = ScopeData_Vel.time;
Vel_plot1 = ScopeData_Vel.signals.values(:,1);
figure(1);
subplot(2,2,2);
plot(t_Vel,Vel_plot1,'p'); grid on; 
legend('Vel loop');
title('step responce-Vel');
xlabel('time'); ylabel('amplitude')

% plot omega_loop
t_Omega = ScopeData_Omega.time;
Omega_plot1 = ScopeData_Omega.signals.values(:,1);
figure(2);
subplot(2,2,2);
plot(t_Omega,Omega_plot1,'b'); grid on;
legend('Omega loop');
title('step responce-Omega');
xlabel('time'); ylabel('amplitude')