clc;clear;

%%Vel loop spec design
% syms s a b c Final_value;
% 
% a = 6.313;
% b =  1.054;
% 
% ess = 0.1; %
% 
% approximate = -1;
% 
% Kposition = (1 - ess) / ess
% Ki = a/b * Kposition
% 
% syms wg
% 
% Gain_Kposition = b*Ki / (a * ((1/a)^2 * wg^2 + 1)^(1/2))
% 
% wg=double(solve(Gain_Kposition==1, wg))
% 
% PM = 180 - atand(1/a*wg)
% 
% %Kp = wg/10 *Ki
% 
% PM_desire = PM + 15
% 
% syms wg_new
% angle = -180+PM_desire
% 
% Kp = 10 * Ki / 4.5 % try and error (diacotomy)

%% Omega loop spec design
% syms s a b c Final_value;
% 
% a = 4.99887;
% b = 3.2393;
% 
% ess = 0.1;
% 
% approximate = -1;
% 
% Kposition = 0.01;%(1 - ess) / ess
% Ki = (10^(Kposition/20) )  * a/b 
% 
% syms wg
% 
% Gain_Kposition = b/a*Ki / wg * ( 1/a * wg + 1)
% 
% wg=double(solve(Gain_Kposition==1, wg))
% 
% PM = 180 - atand(wg) - atand(1/a*wg)
% 
% %Kp = wg/10 *Ki
% 
% PM_desire = PM + 15
% 
% syms wg_new
% angle = -180+PM_desire
% 
% Kp = 10 * Ki / 4.5 % try and error (diacotomy)

%% Vel loop spec design
% syms s a b c Final_value;
% 
% a = 6.313;
% b =  1.054;
% 
% syms s wg Ki Kp
% angle_estimation = 5; %(unit: deg)
% PM_desire = 60 + angle_estimation;
% angle = -180+PM_desire
% 
% wg = 14.3;%look into ''angle'' from bode plot (unit:rad/s)
% tau = 1 /(wg / 10);
% gain_desired_diff = -23.5; % look into "difference" from bode plot unit (unit: dB)
% Kp = 10^(abs(gain_desired_diff)/20)
% 
% %Ki = 10^(15.7/20) * a / b - Kp
% 
% Ki =  Kp / tau
% 
% % ess_desired = 0.5;
% % Kposition = (1 - ess_desired) / ess_desired;
% % controller_value = Kposition / (b/a)
% % 
% % Ki = controller_value * 0.5
% 
% slope_near_gaincross = 

%% Omega loop spec design
syms s a b c Final_value;

a = 4.9887;
b = 3.2693;

syms s wg Ki Kp
angle_estimation = 5; %(unit: deg)
PM_desire = 60 + angle_estimation;
angle = -180+PM_desire

wg = 13.2;%look into ''angle'' from bode plot (unit:rad/s)
tau = 1 /(wg / 10)
gain_desired_diff = -12.9; % look into "difference" from bode plot unit (unit: dB)
Kp = 10^(abs(gain_desired_diff)/20)

%Ki = 10^(15.7/20) * a / b - Kp

Ki =  Kp / tau

% ess_desired = 0.5;
% Kposition = (1 - ess_desired) / ess_desired;
% controller_value = Kposition / (b/a)

% Ki = controller_value * 0.5

% slope_near_gaincross = 