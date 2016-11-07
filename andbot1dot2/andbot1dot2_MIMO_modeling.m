clc ; clear ;
andbot1dot2_param; % param m file

%% common function
time_delay_tf = exp(-Tsample*tf('s')); % time delay system

%% run MIMO modeling (bode plotting and controller design)
andbot1dot2_MIMO_modeling_vel_loop; % vel loop m file;
andbot1dot2_MIMO_modeling_omega_loop; % omega loop m file; 

%% to simulink
simulation_time = 10; % set simulation time in simulink (Unit : sec)

% input
input_Vel = 1;  % to simulink
input_Omega = 1; % to simulink
% saturation
Umax_Volt = 20; % Unit: V
Umin_Volt = -20;

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