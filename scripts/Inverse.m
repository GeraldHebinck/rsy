clc;
clear all;

target = [ 385, 0, 302, 0 , 0]

theta_ = [ 0 0 0 0 0 ];
theta_offset = [ 0 pi/2 0 pi/2 0];
DH_array = [  33, pi/2,   147, theta_(1)+theta_offset(1);
             155,    0,     0, theta_(2)+theta_offset(2);
             135,    0,     0, theta_(3)+theta_offset(3);
               0, pi/2,     0, theta_(4)+theta_offset(4);
               0,    0, 217.5, theta_(5)+theta_offset(5)    
           ];

syms a1 a2 a3 a4
syms d1
syms s
syms alpha beta
syms psi
syms theta1 theta2 theta3 theta4 theta5
syms x y z
syms rd d
syms r4 z4
syms xd yd zd

x = target(1);
y = target(2);
z = target(3);
psi = target(4);

a1 = DH_array(1,3); 
a2 = DH_array(2,1);
a3 = DH_array(3,1);
a4 = DH_array(5,3);
d1 = DH_array(1,1);

% Ziel in XY-Ebene
d = sqrt(x^2+y^2);
% Ziel in XY-Ebene minus Offset Joint1
rd = d - d1;
% Ziel in Z minuus Laenge Joint1
zd = z - a1;
% Winkel Joint1
theta1 = acos(x/d);
% Ziel Joint4 XY
r4 = rd - a4 * cos(psi);
% Ziel Joint4 Z
z4 = zd - a4 * sin(psi);
% Strecke zwischen Joint2 und Joint4
s = sqrt(z4^2+r4^2);
% Winkel zur Strecke Joint2Joint4
alpha = atan2(z4,r4);
% Gegenwinkel Joint3
% Cosinussatz mit s = b, a2 = a, a3 = c
% s^2 = a2^2 + a3^2 - 2 * a2 * a3 * cos(beta)
beta = acos((-s^2 + a2^2 + a3^2)/(2*a2*a3));
% Winkel Joint3
theta3 = beta - pi;
% Winkel Joint2
% Sinussatz s/sin(beta) = a3/sin(epsilon)
epsilon = asin(sin(beta)*a3/s);
theta2 = epsilon + alpha;
% Winkel Joint4
theta4 = psi - theta2 - theta3 + pi/2;
% Winkel Joint5
theta5 = target_(5);
% Winkel als Vektor
theta = [ theta1 theta2 theta3 theta4 theta5 ];