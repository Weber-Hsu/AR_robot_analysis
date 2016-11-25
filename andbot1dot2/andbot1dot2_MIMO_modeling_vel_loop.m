%% Instructions
% In order to run this script, please start with 'andbot1dot2_MIMO_modeling.m'

%% plant_Vel (after friction compensation + time delay)

num_Vel = [0 1.054];
den_Vel = [1 6.313];
Plant_Vel = tf(num_Vel,den_Vel);
figure(1);
subplot(2,2,1)
bode(Plant_Vel,'g');grid on;
hold on;

open_loop_Plantdelay_Vel = series(Plant_Vel,time_delay_tf);
%% velocity measurement

if (ENCOutputMode == ENCDiffMode)
    %% differential equation (velocity measurement)
    Diff_n1_Vel = tf([0 1],[1 0]);
    Diff_n2_Vel = tf([0 1],[1,0],'InputDelay',Tsample);
    Measure_Vel = 1/Tsample*(Diff_n1_Vel - Diff_n2_Vel);
    open_loop_PlantMeasure_Vel = series(open_loop_Plantdelay_Vel,Measure_Vel);
    %subplot(2,2,3);
    bode(open_loop_PlantMeasure_Vel,'b'); grid on;
    %set(gcf,'currentaxes',open_loop_PlantDiff_Vel);
    hold on;
elseif (ENCOutputMode == ENCMovFilterMode)
    %% moving average filter (velocity measurement)
    s = tf('s');
    Measure_Vel = 1 / Tsample / SetENCSample * tf([0 1],[1 0]) * (1 - exp(-SetENCSample*Tsample*s)) / (1 - exp(-Tsample*s));
    open_loop_PlantMeasure_Vel = series(open_loop_Plantdelay_Vel,Measure_Vel);
    %subplot(2,2,3);
    bode(open_loop_PlantMeasure_Vel,'b'); grid on;
    %set(gcf,'currentaxes',open_loop_PlantDiff_Vel);
    hold on;  
end
%% velocity loop PI controller
Kp_Vel = 14.9624;%13.1826;
Ki_Vel = 21.3962;%9.43%21.3962;%32.4291;
iTerm_Umax_Vel = 22;
iTerm_Umin_Vel= -22;
PI_controller_Vel = tf([Kp_Vel Ki_Vel],[1 0]);
gain_anti_windup_Vel = 1;

%% Plant_Vel + diff_Vel + controller
open_loop_PlantDiff_VelController = series(open_loop_PlantMeasure_Vel,PI_controller_Vel)
subplot(2,2,3);
bode(open_loop_PlantDiff_VelController,'r');%open_loop_PlantDiff_Vel,'b');
grid on;
%set(gcf,'currentaxes',open_loop_PlantDiff_VelController);
hold on;

stabilities_vel = allmargin(open_loop_PlantDiff_VelController)
mag_atBWFreq_Vel = db(evalfr(open_loop_PlantDiff_VelController,1*0.1j) * 2^(-0.5)) % mag at BW freq: DC gain * 0.707
%gain_when_bandwidthFreq = 20*(log((num_Vel(2) * Ki_Vel / den_Vel(2) / (0.1) *2^(-0.5)))) % (unit:dB)
% freqresp(open_loop_PlantDiff_VelController,gain_when)
[mag_Vel,phase_Vel,wout_Vel] = bode(open_loop_PlantDiff_VelController);
mag_Vel = 20*log10(mag_Vel); % transmute to dB value
ind_Vel = find(mag_Vel > mag_atBWFreq_Vel - 1 & mag_Vel < mag_atBWFreq_Vel + 1);
bandwidth_Vel = wout_Vel(ind_Vel)

%% Plant_Vel + diff_Vel + controller + FeedForward

num_ff_Vel = [0 6.313];
den_ff_Vel = [0 1.054];

%% Bode plotting
num_range_vel = [0.6438 1.054 1.169 2.152];
den_range_vel = [4.957 6.264 6.32 8.309];

for i = 1:4
    bode((tf([0 num_range_vel(i)],[1 den_range_vel(i)])* time_delay_tf * Measure_Vel * PI_controller_Vel))
    hold on;
end