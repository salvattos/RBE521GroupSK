%% Final Project

%% Inverse Kinematics
l = [28.575,50.8,59.75]; %linkage lengths
l_max = sum(l); %maximum length of the legs

%% Forward Kinematics

%% Leg Kinematics
%lh_lhp left hip to left hind paw
%rh_rhp right hip to right hind paw
%ls_lfp left shoulder to left front paw
%rs_rfp right shoulder to right front paw
%{
The matrices representing {lhp} in {lh} is the same as the one representing
{lfp} in {ls}. Similarly, the matrices representing {lh} in {lhp} and {ls}
in {lfp} are the same. We will use a convention wherein the screw axes
point medially. That is, for a robot with lateral symmetry, the screw axes
on one side will point towards those on the other.
%}

joints0 = zeros(3,4); %columns: lhl,lfl,rhl,rfl
theta_guess = [60,90,60]*(pi/180);
% Left hind leg

Mlh_lhp = [0,1,0,0;-1,0,0,sum(l);0,0,1,0;0,0,0,1]; %home position

S1_lh = [0,0,1,0,0,0]';
S1_lh_box = VecTose3(S1_lh);

S2_lh = [0,0,-1,l(1),0,0]';
S2_lh_box = VecTose3(S2_lh);

S3_lh = [0,0,1,sum(l(1:2)),0,0]';
S3_lh_box = VecTose3(S3_lh);

Slhl = [S1_lh S2_lh S3_lh];

Tlh_lhp = expm(S1_lh_box*joints0(1))*expm(S2_lh_box*joints0(2))...
    *expm(S3_lh_box*joints0(3))*Mlh_lhp;

[angles_lhl,~] = IKinSpace(Slhl,Mlh_lhp,Tlh_lhp,theta_guess,0.001,0.001);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Mlhp_lh = [0,-1,0,sum(l);1,0,0,0;0,0,1,0;0,0,0,1];

B1_lhp = [0,0,1,0,-l(3),0]';
B1_lhp_box = VecTose3(B1_lhp);

B2_lhp = [0,0,-1,0,-sum(l(2:3)),0]';
B2_lhp_box = VecTose3(B2_lhp);

B3_lhp = [0,0,1,0,-sum(l),0]';
B3_lhp_box = VecTose3(B3_lhp);

Blhl = [B1_lhp B2_lhp B3_lhp];

Tlhp_lh = Mlhp_lh*expm(B1_lhp_box*joints0(3))*expm(B2_lhp_box*joints0(2))...
    *expm(B3_lhp_box*joints0(1));

% Left front leg
Mls_lfp = [0,1,0,0;-1,0,0,sum(l);0,0,1,0;0,0,0,1]; 

S1_ls = [0,0,1,0,0,0]';
S1_ls_box = VecTose3(S1_ls);

S2_ls = [0,0,-1,l(1),0,0]';
S2_ls_box = VecTose3(S2_ls);

S3_ls = [0,0,1,sum(l(1:2)),0,0]';
S3_ls_box = VecTose3(S3_ls);

Slfl = [S1_ls S2_ls S3_ls];

Tls_lfp = expm(S1_ls_box*joints0(4))*expm(S2_ls_box*joints0(5))...
    *expm(S3_ls_box*joints0(6))*Mls_lfp;

[angles_lfl,~] = IKinSpace(Slfl,Mls_lfp,Tls_lfp,theta_guess,0.001,0.001);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mlfp_ls = [0,-1,0,sum(l);1,0,0,0;0,0,1,0;0,0,0,1];

B1_lfp = [0,0,1,0,-l(3),0]';
B1_lfp_box = VecTose3(B1_lfp);

B2_lfp = [0,0,-1,0,-sum(l(2:3)),0]';
B2_lfp_box = VecTose3(B2_lfp);

B3_lfp = [0,0,1,0,-sum(l),0]';
B3_lfp_box = VecTose3(B3_lfp);

Blfl = [B1_lfp B2_lfp B3_lfp];

Tlfp_ls = Mlfp_ls*expm(B1_lfp_box*joints0(6))*expm(B2_lfp_box*joints0(5))...
    *expm(B3_lfp_box*joints0(4));

% Right hind leg
Mrh_rhp = [0,1,0,0;-1,0,0,sum(l);0,0,1,0;0,0,0,1]; 

S1_rh = [0,0,-1,0,0,0]';
S1_rh_box = VecTose3(S1_rh);

S2_rh = [0,0,1,l(1),0,0]';
S2_rh_box = VecTose3(S2_rh);

S3_rh = [0,0,-1,sum(l(1:2)),0,0]';
S3_rh_box = VecTose3(S3_rh);

Srhl = [S1_rh S2_rh S3_rh];

Trh_rhp = expm(S1_rh_box*joints0(7))*expm(S2_rh_box*joints0(8))...
    *expm(S3_rh_box*joints0(9))*Mrh_rhp;

[angles_rhl,~] = IKinSpace(Slhl,Mlh_lhp,Tlh_lhp,theta_guess,0.001,0.001);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mrhp_rh = [0,-1,0,sum(l);1,0,0,0;0,0,1,0;0,0,0,1];

B1_rhp = [0,0,-1,0,-l(3),0]';
B1_rhp_box = VecTose3(B1_rhp);

B2_rhp = [0,0,1,0,-sum(l(2:3)),0]';
B2_rhp_box = VecTose3(B2_rhp);

B3_rhp = [0,0,-1,0,-sum(l),0]';
B3_rhp_box = VecTose3(B3_rhp);

Brhl = [B1_rhp B2_rhp B3_rhp];

Trhp_rh = Mrhp_rh*expm(B1_rhp_box*joints0(9))*expm(B2_rhp_box*joints0(8))...
    *expm(B3_rhp_box*joints0(7));

% Right front leg
Mrs_rfp = [0,1,0,0;-1,0,0,sum(l);0,0,1,0;0,0,0,1]; 

S1_rs = [0,0,-1,0,0,0]';
S1_rs_box = VecTose3(S1_rs);

S2_rs = [0,0,1,l(1),0,0]';
S2_rs_box = VecTose3(S2_rs);

S3_rs = [0,0,-1,sum(l(1:2)),0,0]';
S3_rs_box = VecTose3(S3_rs);

Srfl = [S1_rs S2_rs S3_rs];

Trs_rfp = expm(S1_rs_box*joints0(10))*expm(S2_rs_box*joints0(11))...
    *expm(S3_rs_box*joints0(12))*Mrs_rfp;

[angles_rfl,~] = IKinSpace(Slhl,Mlh_lhp,Tlh_lhp,theta_guess,0.001,0.001);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mrfp_rs = [0,-1,0,sum(l);1,0,0,0;0,0,1,0;0,0,0,1];

B1_rfp = [0,0,-1,0,-l(3),0]';
B1_rfp_box = VecTose3(B1_rfp);

B2_rfp = [0,0,1,0,-sum(l(2:3)),0]';
B2_rfp_box = VecTose3(B2_rfp);

B3_rfp = [0,0,-1,0,-sum(l),0]';
B3_rfp_box = VecTose3(B3_rfp);

Brfl = [B1_rfp B2_rfp B3_rfp];

Trfp_rs = expm(B1_rfp_box*joints0(12))*expm(B2_rfp_box*joints0(11))...
    *expm(S3_rs_box*joints0(10))*Mrfp_rs;

%% Trajectory Planning

