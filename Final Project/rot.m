function R = rot(a,ang)
%{
This function takes in the axis of rotation and the desired rotation angle
and returns to the appropriate rotation matrix.
%}
ang = ang*(pi/180);

Rx = [1 0 0; 0 cos(ang) -sin(ang); 0 sin(ang) cos(ang)];
Ry = [cos(ang) 0 sin(ang); 0 1 0; -sin(ang) 0 cos(ang)];
Rz = [cos(ang) -sin(ang) 0; sin(ang) cos(ang) 0; 0 0 1];

if a == 'x'
   R = Rx;
elseif a =='y'
   R = Ry;
elseif a == 'z'
   R = Rz;
end
