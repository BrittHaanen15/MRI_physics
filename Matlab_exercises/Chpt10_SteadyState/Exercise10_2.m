clear
M0 = [0 0 1]'; %initial magnetization

M(:,1) = M0; %magnetization at time t=1

R = 60; %number of TRs

TR = 20;
T1 = 1000;
T2 = 50;

theta = 0;
alpha = pi/4; %flip angle

E1 = exp(-TR/T1);
E2 = exp(-TR/T2);

Rel = [E2*cos(theta) E2*sin(theta) 0
    -E2*sin(theta) E2*cos(theta) 0
    0 0 E1];

Rot = [1 0 0
    0 cos(alpha) sin(alpha)
    0 -sin(alpha) cos(alpha)];

for r=2:R
    Mplus = M(:,r-1);
    Mminus = Rel*Mplus + (1-E1)*M0;
    M(:,r) = Rot*Mminus;
end

figure(1)
tvec=(0:(R-1))*TR;
Mt = (M(1,:).^2+M(2,:).^2).^0.5;
Msum = (M(1,:).^2+M(2,:).^2+M(3,:).^2).^0.5;
plot(tvec,Mt,'r.-')
hold on
plot(tvec,M(3,:),'b.-')
plot(tvec,Msum,'k--')
hold off
legend('Transverse','Longitudinal','Length of M vector')