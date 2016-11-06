%% Instructions
% In order to run this script, please start with 'andbot1dot2_MIMO_modeling.m'

%% plant_Omega (after friction compensation) + time delay

num_Omega = [0 3.2393];
den_Omega = [1 4.9887];
Plant_Omega = tf(num_Omega,den_Omega);
figure(2);
subplot(2,2,1)
bode(Plant_Omega,'g');grid on;
hold on;

open_loop_Plantdelay_Omega = series(Plant_Omega,time_delay_tf);
%% differential equation (Omega measurement)

Diff_n1_Omega = tf([0 1],[1 0]);
Diff_n2_Omega = tf([0 1],[1,0],'OutputDelay',Tsample);
Diff_Omega = 1/Tsample*parallel(Diff_n1_Omega,-Diff_n2_Omega);

open_loop_PlantDiff_Omega = series(open_loop_Plantdelay_Omega,Diff_Omega);
%subplot(2,2,2);
bode(open_loop_PlantDiff_Omega,'b');grid on;
%set(gcf,'currentaxes',open_loop_PlantDiff_Vel);
hold on;

%% omega controller

% PI controller
Kp_Omega = 4.4157;
Ki_Omega = 5.8287;
PI_controller_Omega = tf([Kp_Omega Ki_Omega],[1 0]);
% subplot(2,2,3);
% bode(PI_Omega_controller);
% hold on;

%% Plant_Omega + diff_Omega + controller
open_loop_PlantDiff_OmegaController = series(open_loop_PlantDiff_Omega,PI_controller_Omega);
subplot(2,2,3);
bode(open_loop_PlantDiff_OmegaController,'r');%,open_loop_PlantDiff_Omega,'b');
grid on;
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;

allmargin(open_loop_PlantDiff_OmegaController)
mag_atBWFreq_Omega = db(evalfr(open_loop_PlantDiff_OmegaController,1*0.1j) * 2^(-0.5)) % mag at BW freq: DC gain * 0.707
%gain_when_bandwidthFreq = 20*(log((num_Vel(2) * Ki_Vel / den_Vel(2) / (0.1) *2^(-0.5)))) % (unit:dB)
% freqresp(open_loop_PlantDiff_VelController,gain_when)
[mag_Omega,phase_Omega,wout_Omega] = bode(open_loop_PlantDiff_OmegaController);
mag_Omega = 20*log10(mag_Omega); % transmute to dB value
ind_Omega = find(mag_Omega > mag_atBWFreq_Omega - 1 & mag_Omega < mag_atBWFreq_Omega + 1);
bandwidth_Omega = wout_Omega(ind_Omega)

%% Plant_Omega + diff_Omega + controller + FeedForward

num_ff_Omega = [0 4.99887];
den_ff_Omega = [0 3.2393];

%% Bode plotting
num_range_Omega = [2.9231 3.2805 3.5144];
den_range_Omega = [5.0096 4.9856 4.9708];

for i = 1:3
    plant_range_Omega(i) = tf([0 num_range_Omega(i)],[1 den_range_Omega(i)])* time_delay_tf * Diff_Vel * PI_controller_Omega;
    %bode(tf([0 num_range_Omega(i)],[1 den_range_Omega(i)])* time_delay_tf * Diff_Vel * PI_Vel_controller)
    bode(plant_range_Omega(i))
    hold on;
end