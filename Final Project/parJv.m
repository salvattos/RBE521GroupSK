function [Jv] = parJv(P0,a)

[R,s,~,~,n] = IK(P0,a);

Rsn = zeros(3,6);
Jv = zeros(6,6);

for b = 1:length(s)
    Rsn(:,b) = R*s(:,b);
    Jv(b,:) = [n(:,b)',cross(Rsn(:,b),n(:,b))'];
end
