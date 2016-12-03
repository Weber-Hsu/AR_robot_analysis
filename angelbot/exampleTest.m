clc; clear;

% % motor specs
% Km = 0.0487;
% Kb = Km;
% La = 0.64*(10^-3);
% Ra = 0.27;
% 
% % Robot specs
% r =0.085;
% m =18.8;
% L =0.43;
% I =m*(L^2)/6;
% beta=0.4;%Surface friction
% 
% h1 = tf(Km,[La Ra]);
% h1.u='e1'; h1.y='taum1';
% 
% h2=tf(1,[(r^2)*m 0]);
% h2.u='x1'; h2.y='vhat1';
% 
% h3=tf(L^2,[2*(r^2)*I 0]);
% h3.u='x2'; h3.y='omegahat1';
% 
% h7=tf(beta,1);
% h7.u='omega1'; h7.y='tauf1';
% 
% h8=tf(Kb,1);
% h8.u='omega1'; h8.y='vb1';
% 
% sum1=sumblk('e1=omegar1-vb1');
% sum2=sumblk('tau1=taum1-tauf1');
% sum3=sumblk('x1=tau1+tau2');
% sum4=sumblk('x2=tau1-tau2');
% sum5=sumblk('omega1=vhat1+omegahat1');
% 
% h4=tf(Km, [ La Ra ] ) ;
% h4.u='e2' ; h4.y='taum2' ;
% 
% h6=tf(1,[(r^2)*m 0]);
% h6.u='x4'; h6.y='vhat2';
% 
% h5=tf(L^2,[2*(r^2)*I 0]);
% h5.u='x3';h5.y='omegahat2';
% 
% h9 = tf(beta,1);
% h9.u='omega2';h9.y='tauf2';
% 
% h10=tf(Kb,1);
% h10.u='omega2';h10.y='vb2';
% 
% sum6 = sumblk('e2=omegar2 - vb2');
% sum7 = sumblk('tau2=taum2-tauf2');
% sum8 = sumblk('x3=tau1-tau2');
% sum9 = sumblk('x4=tau2 + tau1');
% sum10 = sumblk('omega2=vhat2-omegahat2')
% 
% ML = connect(ss(h1),h2,h3,ss(h4),h5,h6,h7,h8,h9,h10,sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,{'omegar1','omegar2'},{'omega1','omega2'})
% ML.statename = {'ia1','x2','x3','ia2','x5','x6'};


% zeroholder = tf([0 1],[1 0]) * (1 - tf([-0.04/2 1],[0.04/2 1]))
% zeroholder_exp = tf([0 1],[1 0]) * ( 1- exp(-0.04*tf('s')))
% figure(3)
% bode(zeroholder,'r',zeroholder_exp, 'b', exp(-0.04*tf('s'))/tf('s'),'y')
% figure(4)
% Kp = 30;
% Ki = 12;tf([Kp Ki],[1 0])
% bode(tf([Kp Ki],[1 0]),'b',tf([0 Kp],[0 1]),'r',tf([0 Ki],[1 0]),'g')
% figure(5)
% bode(tf([0 Ki],[1 0]),'g')

syms Uright Uleft Usum Udiff;
syms VelRef OmegaRef VelFb OmegaFb VelCtrler OmegaCtrler;
syms OmegaRight OmegaLeft OmegaRightRef OmegaLeftRef;
syms WheelRadius WheelSeparation Jacob 

Umotor = [Uright; Uleft];
URobot = [Usum; Udiff];
OmegaMotorRef = [OmegaRightRef; OmegaLeftRef];
OmegaMotorFb = [OmegaRight; OmegaLeft];
RobotRef = [VelRef; OmegaRef];
RobotFb = [VelFb; OmegaFb];
CtrlerRobot = [VelCtrler 0; 0 OmegaCtrler];
Jacob = [1 1; WheelSeparation/2 -WheelSeparation/2];

URobot = Jacob*Umotor

[VelCtrler 0 ; 0 OmegaCtrler] * ( [VelRef; OmegaRef] - [VelFb; OmegaFb])

WheelRadius * inv(Jacob.') * OmegaMotorFb
WheelRadius * inv(Jacob.') * OmegaMotorRef
OmegaMotorRef = Jacob.' * RobotRef ./ WheelRadius 

inv(Jacob) * CtrlerRobot * WheelRadius * inv(Jacob.') * (OmegaMotorRef - OmegaMotorFb)