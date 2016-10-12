clc;clear;


sim('');

t_Vel = scopestep_velocity.time;
t_Vel_cmd = scopestep_velocity.signals.values(:,1);
t_Vel_response = scopestep_velocity.signals.values(:,2);

%t_omega = scopestep_omega.time;
%t_omega_cmd = scopestep_omega.signals.values(:,1);
%t_omega_response = scopestep_omegasignals.values(:,2);



%figure;

