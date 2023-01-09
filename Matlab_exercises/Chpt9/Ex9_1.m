set(0, 'DefaultFigureRenderer', 'painters');
%% Exercise 9.1a
clear
M0 = 1; %equal for both tissue

%Tissue 1:
T1_1 = 900;
T2_1 = 50;

%Tissue 2:
T1_2 = 1100;
T2_2 = 250;

%TR and TE's to check:
TR = linspace(0,5000,100);
TE = linspace(0,300,100);

for i=1:length(TR)
    for j=1:length(TE)
        SI_1(i,j) = M0 * (1-exp(-TR(i)/T1_1)) .* exp(-TE(j)/T2_1);
        SI_2(i,j) = M0 * (1-exp(-TR(i)/T1_2)) .* exp(-TE(j)/T2_2);
        SI_diff(i,j) = abs(SI_1(i,j)-SI_2(i,j));
    end
end

figure
imagesc(TE,TR,SI_diff)
xlabel('TE (ms)')
ylabel('TR (ms)')
title('Signal difference between tissue 1 and tissue 2')
colormap(hot)
%% Exercise 9.1b
clear
M0 = 1; %equal for both tissue

%Tissue 1:
T1_1 = 300;
T2_1 = 50;

%Tissue 2:
T1_2 = 900;
T2_2 = 70;

%TR and TE's to check:
TR = linspace(0,5000,100);
TE = linspace(0,300,100);

for i=1:length(TR)
    for j=1:length(TE)
        SI_1(i,j) = M0 * (1-exp(-TR(i)/T1_1)) .* exp(-TE(j)/T2_1);
        SI_2(i,j) = M0 * (1-exp(-TR(i)/T1_2)) .* exp(-TE(j)/T2_2);
        SI_diff(i,j) = abs(SI_1(i,j)-SI_2(i,j));
    end
end

figure
imagesc(TE,TR,SI_diff)
xlabel('TE (ms)')
ylabel('TR (ms)')
title('Signal difference between tissue 1 and tissue 2')
colormap(hot)