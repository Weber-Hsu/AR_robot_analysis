clc;clear;

syms s a b c Final_value;

%% system ID
c = 2;
Final_value = 0.37;
value_when_tau = Final_value * 0.632
tau = 0.158611; % look into the graph

G_p = b / (s+a);
G_p_Final = subs(G_p,{s},{0});
G_p_temp = G_p_Final / Final_value * c;

TimeConstant = 1/tau; 

%a = TimeConstant;
G_p_temp = subs(G_p_temp,{a},{TimeConstant});

G_p = subs(G_p,{a,b},{TimeConstant,double(solve(G_p_temp == 1,b))})
tf([0 double(solve(G_p_temp == 1,b))], [1 TimeConstant])