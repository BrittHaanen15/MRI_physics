% Script plotting how the SE equation predict signal strength at different
% T1 and T2's
figure
T1a= 1122 %myocardial T1 (https://doi.org/10.1186/s12968-017-0371-5)
T1b= 1122 %myocardial T1 (https://doi.org/10.1186/s12968-017-0371-5)
T1c=750
T1d=750

T2a=52  %myocardial T2 (https://doi.org/10.1186/s12968-017-0371-5)
T2b=20
T2c=52  %myocardial T2 (https://doi.org/10.1186/s12968-017-0371-5)
T2d=20

M0a=1;
M0b=1;
M0c=1;
M0d=1;

%TE-vec
TEvec = 0:0.1:100;
TR=1500;

Ma = M0a * (1-exp(-TR/T1a)) * exp(-TEvec/T2a);
Mb = M0b * (1-exp(-TR/T1b)) * exp(-TEvec/T2b);
Mc = M0c * (1-exp(-TR/T1c)) * exp(-TEvec/T2c);
Md = M0d * (1-exp(-TR/T1d)) * exp(-TEvec/T2d);
subplot(1,2,1)
plot(TEvec,Ma,'k','LineWidth',3)
hold on
plot(TEvec,Mb,'k--','LineWidth',3)
plot(TEvec,Mc,'r','LineWidth',1.5)
plot(TEvec,Md,'r--','LineWidth',1.5)
title(['TR = ',num2str(TR),' ms'])
hold off
legend(['(a) T1/T2 = ',num2str(T1a),'/',num2str(T2a)],...
    ['(b) T1/T2 = ',num2str(T1b),'/',num2str(T2b)],...
    ['(c) T1/T2 = ',num2str(T1c),'/',num2str(T2c)],...
    ['(d) T1/T2 = ',num2str(T1d),'/',num2str(T2d)],'Location','Best')

ylabel('Magnetization (a.u.)')
xlabel('TE (ms)')

% subplot(2,2,3)
% plot(TEvec,abs(Ma-Mb),'k','LineWidth',2)
% hold on
% plot(TEvec,abs(Ma-Mc),'k--','LineWidth',2)
% legend('Contrast, different T2 (a-b)','Contrast, different T1 (a-c)','Location','Best')
% ylabel('Magnetization difference (a.u.)')
% xlabel('TE (ms)')

%TR-vec
TRvec = 0:10:5000;
TE=10;
Ma = M0a * (1-exp(-TRvec/T1a)) * exp(-TE/T2a);
Mb = M0b * (1-exp(-TRvec/T1b)) * exp(-TE/T2b);
Mc = M0c * (1-exp(-TRvec/T1c)) * exp(-TE/T2c);
Md = M0d * (1-exp(-TRvec/T1d)) * exp(-TE/T2d);
subplot(1,2,2)
plot(TRvec,Ma,'k','LineWidth',3)
hold on
plot(TRvec,Mb,'k--','LineWidth',3)
plot(TRvec,Mc,'r','LineWidth',1.5)
plot(TRvec,Md,'r--','LineWidth',1.5)

title(['TE = ',num2str(TE),' ms'])
hold off
legend(['(a) T1/T2 = ',num2str(T1a),'/',num2str(T2a)],...
    ['(b) T1/T2 = ',num2str(T1b),'/',num2str(T2b)],...
    ['(c) T1/T2 = ',num2str(T1c),'/',num2str(T2c)],...
    ['(d) T1/T2 = ',num2str(T1d),'/',num2str(T2d)],'Location','Best')
ylabel('Magnetization (a.u.)')
xlabel('TR (ms)')

% subplot(2,2,4)
% plot(TRvec,abs(Ma-Mb),'k','LineWidth',2)
% hold on
% plot(TRvec,abs(Ma-Mc),'k--','LineWidth',2)
% legend('Contrast, different T2 (a-b)','Contrast, different T1 (a-c)','Location','Best')
% ylabel('Magnetization difference (a.u.)')
% xlabel('TR (ms)')