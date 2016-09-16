clc;clear;

% state space form of DC motor x' = Ax+Bu; 
% ea = input voltage; 

R= 2.0; % Ohms
L= 0.5; % Henrys
Kt = .015; % Torque constant
Ke= .015; % emf constant
Kb= 0.2; % Nms
J= 0.02; % kg.m^2/s^2

A = [-R/L 0 -Ke/L ; 0 0 1 ; Kt/J 0 -Kb/J] 
B = [1/L; 0; 0] 
C = [0 1 0] 
D = zeros(1,1)
% A=[-R/L -Ke/L;Kt/J -Kb/J] ;
% B=[1/L;0] ;
% C = eye(2) ;
% D = zeros(2,1) ;
eig = eig(A);
sys_a = rank(A);
co = ctrb(A,B);
co_r = rank(co)
if sys_a == co_r
    disp('The system is controllable')
else
    disp('The system is uncontrollable')
end

% damp = 0.99 ; wn = 3.33 ;
% [num1 , den1] = ord2(wn,damp) ;
% do_pole = roots(den1) ;
% des_pole = do_pole' ;
% K=acker(A,B,des_pole) ;

sim('DCmotor_modeling_statespace');

