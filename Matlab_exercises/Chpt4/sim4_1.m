clear

%Tissue 1
T1_1 = 300 %ms
Mz_1(1) = 0;
M0_1 = 1;

%Tissue 2
T1_2 = 1300 %ms
Mz_2(1) = 0;
M0_2 = 2;


for t=2:3000
    Mz_1(t) = M0_1 * (1-exp(-t/T1_1)) + Mz_1(1) * exp(-t/T1_1);
    Mz_2(t) = M0_2 * (1-exp(-t/T1_2)) + Mz_2(1) * exp(-t/T1_2);
end

diff=abs(Mz_1-Mz_2);
[maxDiff,maxDiffPos]=max(diff)

figure
plot(Mz_1,'k-','LineWidth',2)
hold on
plot(Mz_2,'k--','LineWidth',2)
plot(diff,'k-.','LineWidth',1)
legend('Tissue 1','Tissue 2','Difference')
xlabel('Time (ms)')
ylabel('Mz (a.u.)')
box off
