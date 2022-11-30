clear
figure
TR = 1; %s
T1 = 1; %s
N=100;

tvec = (1:N)*TR;

E1 = exp(-TR/T1);
alpha = 90/360*(2*pi);

M0 = 1;
Mz(1) = 1;
My(1) = 0;

for n=2:N %the n'th pulse
    %signal immediately after the alpha pulse:
    Mz_afterRF = Mz(n-1)*cos(alpha);
    My_afterRF = Mz(n-1)*sin(alpha);
    
    %signal immediately before the next pulse:
    Mz(n) = E1*Mz_afterRF+(1-E1)*M0; %Mz has relaxed following T1
    My(n) = My_afterRF; %we omit T2 relaxation, so My is constant
end

plot(1000*tvec,Mz,'k-','LineWidth',2)
hold on
plot(1000*tvec,My,'k--','LineWidth',2)
title(['T1 = ',num2str(T1),...
    ', TR = ',num2str(TR),' Alpha = ',num2str(alpha/pi*180)])
xlabel('Time (ms)')
ylabel('Magnetization')

%Compare to "theoretical" steady state of the transverse magnetization:        
MT = sin(alpha)*(1-exp(-TR/T1))/(1-exp(-TR/T1)*cos(alpha)); %From the compendium chapter on "MR signal behavoir and image contrast".
plot(1000*tvec,tvec*0+MT,'r')
legend('Mz','My','Theoretical steady-state')