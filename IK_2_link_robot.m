%% solve the Inverse Kinematics of our simplified robot Leg
syms x y theta1 theta2 
L1 = 50.8;
L2 = 103.27;
IK = solve([x==L1*cos(theta1) +L2*cos(theta1+theta2), y == L1*sin(theta1)+L2*cos(theta1+theta2)], [theta1,theta2]);
