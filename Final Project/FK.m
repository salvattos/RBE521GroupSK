function [Pose,Dp] = FK(P0,lg,a)
%Enter the position and given leg lengths as column vectors
%Just stick to ZYZ for now, this just has to work and it "pretty much" does
here
%Step 1
Pos(:,1) = P0;
i = 2;
Dp = 1;
e = 0.0001;

while Dp > e
    %Step 2
    J = parJv(Pos(:,i-1),'zyz');
    
    %Step 3
    
    euler = (pi/180)* Pos(4:6,i-1); %convert to radians
    
    B = [0, -sin(euler(1)), sin(euler(2))*cos(euler(1));
        0, cos(euler(1)), sin(euler(2))*sin(euler(1));
        1, 0, cos(euler(2))]; %Euler angle derivatives and such
    T = [eye(3) zeros(3,3); zeros(3,3), B];
    
    %Step 4
    [~,~,~,l,~] = IK(Pos(:,i-1),a); %Calling IK, suppressing unused outputs
    
    Dl = lg-l; %comparing length values

    Pos(:,i) = Pos(:,i-1) + pinv(J*T) * Dl; %Updating the position
    
    %Step 6
    Dp = norm(Pos(:,i) - Pos(:,i-1));
    i = i+1;
end

Pose = Pos(:,end);

