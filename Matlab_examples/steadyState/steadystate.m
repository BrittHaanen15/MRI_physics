
TR = 5;
TE = 2.5;
T1 = 900;
T2 = 100;
T2star = 100;

th = 0;
a = 0:1:100;

E1=exp(-TR/T1);
E2=exp(-TE/T2);

C= E2*(E1-1)*(1+cosd(a));
D = (1-E1*cosd(a)) - (E1-cosd(a))*E2^2;

Fp = sind(a).*(1-E1).*(1-E2.*exp(-1i.*th))./(C.*cosd(a)+D);

NGRE = (1-E1).*sind(a)./C.*((C+D.*E2)./(sqrt(D.^2-C.^2))-E2);
T2GRE = (1-E1).*E2.*sind(a)./C.*(1-(D+C.*E2)./(sqrt(D.^2+C.^2)))
BGRE = (sind(a).*(1-E1).*sqrt(E2))./(1-(E1-E2).*cosd(a)-E1.*E2)
T1GRE = sind(a).*(1-E1)./(1-E1.*cosd(a))*exp(-TE/T2star)
figure
%plot(abs(Fp),'-k')
plot(abs(NGRE),'-.k','LineWidth',2)
hold on
plot(abs(T2GRE),':b','LineWidth',2)
plot(abs(BGRE),'--r','LineWidth',2)
plot(abs(T1GRE),'-g','LineWidth',2)
legend('N-GRE','T2-GRE','B-GRE','T1-GRE')
box off