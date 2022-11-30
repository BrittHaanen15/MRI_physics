clear
I=20000; %time steps to simulate
dt = 1e-11; % s per timestep

gamma=2.7e8;

B1 = 0.1; %T
B0 = 1.5; %T

omega_a = B1*gamma; %strength of B1 field
omega0 = B0*gamma; %strength of B0 field
factor = 1.00;				%Factor for altering the RF frequency (1.00, 1.01
omega1 = omega0*factor; 		%RF frequency, mathcing the Larmor frequency
omegaR = 0; %rotating frame-of-reference frequency


M(:,1) = [0 0 1]; %Initialize M at time t=1

for i=1:I
    B(1)= B1*cos((omega1-omegaR)*(i*dt));
    B(2)= -B1*sin((omega1-omegaR)*(i*dt));
    B(3)= B0-omegaR/gamma;
    dMdT(:,i) = gamma * cross(M(:,i),B)*dt;
    M(:,i+1) = M(:,i)+dMdT(:,i);
end

% Plot figure

figure
subplot(2,3,1)
plot(M(1,:),'-')
xlabel('T')
ylabel('X')
box off
subplot(2,3,2)
plot(M(2,:),'-')
xlabel('T')
ylabel('Y')
title(['\omega_0 = ',num2str(omega0),...
    ', \omega_1 = ',num2str(omega1),...
    ', \omega_r = ',num2str(omegaR)])
box off
subplot(2,3,3)
plot(M(3,:),'-')
xlabel('T')
ylabel('Z')

subplot(2,3,4)
plot(M(1,:),M(2,:),'-')
xlabel('X')
ylabel('Y')
axis equal
box off
subplot(2,3,5)
plot(M(1,:),M(3,:),'-')
xlabel('X')
ylabel('Z')
axis equal
box off
subplot(2,3,6)
plot(M(2,:),M(3,:),'-')
xlabel('Y')
ylabel('Z')
axis equal
box off


print('-depsc2','-painters','plot_1_9_b-c.eps')

%%
figure
subplot(1,2,1)
plot((M(1,:).^2+M(2,:).^2).^.5,'-')
xlabel('T')
ylabel('xy')
subplot(1,2,2)
plot(M(3,:),'-')
xlabel('T')
ylabel('Z')
title(['\omega_0 = ',num2str(omega0),...
    ', \omega_1 = ',num2str(omega1),...
    ', \omega_r = ',num2str(omegaR),...
    ])
return
%%
figure
plot3(M(1,:),M(2,:),M(3,:),'-')
xlabel('X')
ylabel('Y')
zlabel('Z')

%%
if 0
    %%
figure
for i=1:I
    plot3(M(1,1:i),M(2,1:i),M(3,1:i),'-')
    hold on
    plot3(M(1,i),M(2,i),M(3,i),'ok')
    plot3([M(1,1) M(1,i)],[M(2,1) M(2,i)],[M(3,1) M(3,i)],'-k')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    pause(0.01)
    cla
end

end
