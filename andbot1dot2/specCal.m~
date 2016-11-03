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

%%Vel loop spec design
syms s a b c Final_value;

a = 6.313;
b =  1.054;

syms wg Ki Kp
PM_desire = 60 
angle = -180+PM_desire

wg = 16.1 ;%from bode plot unit(rad/s)
wg_new = wg / 5
gain_cross = 1 / (Ki / Kp);
Ki = wg_new * Kp;



Kp = 10 * Ki / 4.5 % try and error (diacotomy)
ess = 0.1; %
approximate = -1;

Kposition = (1 - ess) / ess
Ki = a/b * Kposition

syms wg

Gain_Kposition = b*Ki / (a * ((1/a)^2 * wg^2 + 1)^(1/2))

wg=double(solve(Gain_Kposition==1, wg))

PM = 180 - atand(1/a*wg)

%Kp = wg/10 *Ki



