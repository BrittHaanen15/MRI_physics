
clear
M0 = [0 0 1]'; %initial magnetization

M(:,1) = M0; %magnetization at time t=1

N = 100; %number of TRs to simulate


TR = 15; %time between excitations
T1 = 1000;
T2 = 100;

theta = [0:360]/180*pi; %theta angle
alpha = 30/180*pi; %flip angle


E1 = exp(-TR/T1);
E2 = exp(-TR/T2);

for t=1:length(theta)
    %Relaxation matrix:
    Rel = [E2*cos(theta(t)) E2*sin(theta(t)) 0
        -E2*sin(theta(t)) E2*cos(theta(t)) 0
        0 0 E1];

    %Rotation matrix:
    Rot = [1 0 0
        0 cos(alpha) sin(alpha)
        0 -sin(alpha) cos(alpha)];

    for n=1:N-1
        M_n_plus = M(:,n); %Magnetization after prevous RF pulse
        M_nplusone_minus = Rel*M_n_plus + (1-E1)*M0; %Relaxation...
        M(:,n+1) = Rot*M_nplusone_minus; %Magnetization after this RF pulse
        MT(t,n) = sqrt(M(1,n+1).^2+M(2,n+1).^2);
    end

end
figure
imagesc(1:N,theta/pi*180,MT)
ylabel('Theta')
xlabel('Number of TRs')
a=colorbar
caxis([0 1])
colormap(hot)
a.Label.String = 'Transverse magnetization';