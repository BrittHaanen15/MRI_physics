x=-12:0.01:12
figure
plot(x,sin(x)./x)


%%
gamma = 42.58e6; %Hz/T
gamma = 2*pi*42.58e6; %rad/s/T
Gz = 10e-3; %T/m
d = 3e-3; %m
tvec = -1.57e-3:100e-6:1.57e-3;

sincPulse = sin(gamma*Gz*tvec*d/2)./(gamma*Gz*tvec*d/2);
B1 = Gz*d*sin(gamma*Gz*tvec*d/2)./(gamma*Gz*tvec*d/2);
figure
subplot(2,1,1)
plot(tvec,sincPulse)
xlabel('Time (s)')
ylabel('Sinc function only')
subplot(2,1,2)
plot(tvec,B1)
xlabel('Time (s)')
ylabel('B1(t) [T]')
%%