function [R, s, u, l, n] = IK(P0,a,Rp,)
%Enter position as a column vector.

alpha = 60*(pi/180); %Hwk5
beta = alpha; %Hwk5
%beta = 85*(pi/180);

Rp = 300/2; %Platform radius
Rb = 480/2; %Base radius

O = P0(1:3); %Origin vector
euler = P0(4:6); %defining the Euler angles

%euler = (pi/180).*euler; 

Rzyz = rot('z',euler(1))*rot('y', euler(2))*rot('z',euler(3));
Rxyz = rot('x', euler(1))*rot('y',euler(2))*rot('z',euler(3));

%ZYZ and XYZ
if strcmp(a,'zyz') == 1
    R = Rzyz;
elseif strcmp(a,'xyz')==1
    R = Rxyz;
end


%Defining collections
s = zeros(3,6);
u = zeros(3,6);
L = zeros(3,6);
l = zeros(6,1);
n = zeros(3,6);

%{

s(:,1) = [Rp*cos(beta/2); Rp*sin(beta/2); 0];
s(:,2) = [-Rp*sin(pi/6-beta/2); Rp*cos(pi/6-beta/2); 0];
s(:,3) = [-Rp*sin(pi/6+beta/2); Rp*cos(pi/6+beta/2);0];
s(:,4) = [-Rp*cos(pi/3-beta/2); -Rp*sin(pi/3-beta/2);0];
s(:,5) = [-Rp*cos(pi/3+beta/2); -Rp*sin(pi/3+beta/2);0];
s(:,6) = [Rp*cos(beta/2); -Rp*sin(beta/2); 0];

u(:,1) = [Rb*cos(alpha/2); Rb*sin(alpha/2);0];
u(:,2) = [-Rb*sin(pi/6-alpha/2); Rb*cos(pi/6-alpha/2);0];
u(:,3) = [-Rb*sin(pi/6+alpha/2); Rb*cos(pi/6+alpha/2);0];
u(:,4) = [-Rb*cos(pi/3-alpha/2); -Rb*sin(pi/3-alpha/2);0];
u(:,5) = [-Rb*cos(pi/3+alpha/2); -Rb*sin(pi/3+alpha/2);0];
u(:,6) = [Rb*cos(alpha/2); -Rb*sin(alpha/2); 0];
%}

s(:,1) = [Rp*cos(2*beta); Rp*sin(2*beta); 0];
s(:,2) = [Rp*sin(beta); Rp*cos(beta); 0];
s(:,3) = [Rp*sin(3*beta); Rp*cos(3*beta);0];
s(:,4) = [Rp*cos(0); Rp*sin(0);0];
s(:,5) = [Rp*cos(4*beta); Rp*sin(4*beta);0];
s(:,6) = [Rp*cos(-beta); Rp*sin(-beta); 0];

u(:,1) = [Rb*cos(2*alpha); Rb*sin(2*alpha);0];
u(:,2) = [Rb*sin(alpha); Rb*cos(alpha);0];
u(:,3) = [Rb*sin(3*alpha); Rb*cos(3*alpha);0];
u(:,4) = [Rb*cos(0); Rb*sin(0);0];
u(:,5) = [Rb*cos(4*alpha); Rb*sin(4*alpha);0];
u(:,6) = [Rb*cos(-alpha); Rb*sin(-alpha); 0];

if a == "zyz"
    for b = 1:length(L)
        L(:,b) = O + Rzyz*s(:,b) - u(:,b);
        l(b) = norm(L(:,b));
        n(:,b) = L(:,b)/l(b);
    end
elseif a =="xyz"
    for b = 1:length(L)
        L(:,b) = O + Rxyz*s(:,b) - u(:,b);
        l(b) = norm(L(:,b));
        n(:,b) = L(:,b)/l(b);
    end
end



