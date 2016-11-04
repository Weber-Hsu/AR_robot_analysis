clc ; clear ;
andbot1dot2_param; % param m file

simulation_time = 10; % set simulation time in simulink (Unit : sec)
%% common function
time_delay_tf = exp(-Tsample*tf('s')); % time delay system
input_Vel = 1;  % to simulink
input_Omega = 1; % to simulink

%% plant_Vel (after friction compensation + time delay)

num_Vel = [0 1.054];
den_Vel = [1 6.313];
Plant_Vel = tf(num_Vel,den_Vel);
figure(1);
subplot(2,2,1)
bode(Plant_Vel,'g');
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

%% velocity loop PI controller
Kp_Vel = 14.9624;%13.1826;
Ki_Vel =  21.3962%9.43%21.3962;%32.4291;
PI_Vel_controller = tf([Kp_Vel Ki_Vel],[1 0]);

%% Plant_Vel + diff_Vel + controller
open_loop_PlantDiff_VelController = series(open_loop_PlantDiff_Vel,PI_Vel_controller)
subplot(2,2,3);
bode(open_loop_PlantDiff_VelController,'r');%open_loop_PlantDiff_Vel,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;

allmargin(open_loop_PlantDiff_VelController)
gain_when_bandwidthFreq = db(evalfr(open_loop_PlantDiff_VelController,1*0.1j) * 2^(-0.5))
%gain_when_bandwidthFreq = 20*(log((num_Vel(2) * Ki_Vel / den_Vel(2) / (0.1) *2^(-0.5)))) % (unit:dB)
% freqresp(open_loop_PlantDiff_VelController,gain_when)
[mag,phase,wout] = bode(open_loop_PlantDiff_VelController);
mag = 20*log10(mag);
ind = find(mag > gain_when_bandwidthFreq - 1 & mag < gain_when_bandwidthFreq + 1)
bandwidth_vel = wout(ind)
%% Plant_Vel + diff_Vel + controller + FeedForward

num_Vel_ff = [0 6.313];
den_Vel_ff = [0 1.054];

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
Kp_Omega = 4.4157;
Ki_Omega = 5.8287;
PI_Omega_controller = tf([Kp_Omega Ki_Omega],[1 0])
% subplot(2,2,3);
% bode(PI_Omega_controller);
% hold on;

%% Plant_Omega + diff_Omega + controller
open_loop_PlantDiff_OmegaController = series(open_loop_PlantDiff_Omega,PI_Omega_controller);
subplot(2,2,3);
bode(open_loop_PlantDiff_OmegaController,'r');%,open_loop_PlantDiff_Omega,'b');
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;

bandwidth(open_loop_PlantDiff_OmegaController)
allmargin(open_loop_PlantDiff_OmegaController);

%% Plant_Omega + diff_Omega + controller + FeedForward

num_Omega_ff = [0 4.99887];
den_Omega_ff = [0 3.2393];

sim('andbot1dot2_voltage_loop_frictioncompensation')
%% data management

% plot Vel_loop
t_Vel = ScopeData_Vel.time;
Vel_plot1 = ScopeData_Vel.signals.values(:,1);
figure(1);
subplot(2,2,2);
plot(t_Vel,Vel_plot1,'b'); grid on; 
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