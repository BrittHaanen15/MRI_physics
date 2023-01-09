% Extended Bloch equation (visual av slice sel)
clear
close all
cla
M(:,1) = [0 0 1]';
M0 =1;

dt=0.01;
tvec = 1:dt:400;

T2 = Inf;
T1 = Inf;

gammaGR = [-50:1:50]*.01;
%gammaB1x = sin((tvec-250)*8)./((tvec-250)*8);
%gammaB1x(isnan(gammaB1x))=1;
if 0 % constant b1
    gammaB1x=tvec*0+0.01;
elseif 0  % gaussian pulse
    gammaB1x=0.022*exp(-(tvec-100).^2/40^2);
else  % sinc pulse
    gz = .3;
    gamma=1;
    d=0.6;
    gammaB1x=gz*d*sinc(gamma*gz*(tvec-200)*d/2);
end

%figure,plot(ifftshift(abs(fft(gammaB1x))))
figure,plot(tvec,gammaB1x)
ylabel('B1 field')
xlabel('Time')
box off
set(gca,'FontSize',14) % Creates an axes and sets its FontSize to 18
%%
MT = zeros(length(tvec),length(gammaGR));
angle = zeros(length(tvec),length(gammaGR));
for g = 1:length(gammaGR)
    gammGR_g = gammaGR(g);
    for t=2:length(tvec)
        Mat = [-1/T2 gammGR_g 0 ;
            -gammGR_g -1/T2 gammaB1x(t)
            0 -gammaB1x(t) -1/T1];
        dMdt = Mat*M(:,t-1) + [0;0;M0/T1];
        M(:,t) = M(:,t-1)+dMdt*dt;
    end
    MT(:,g) = (M(1,:).^2+M(2,:).^2).^.5;
    angle(:,g) = atan2(MT(:,g),M(3,:)');
    if 0
        figure(1)
        
        plot3(tvec,tvec*0+g,MT(:,g),'k')
        %plot(M(1,:),'r')
        hold on
        %plot(M(2,:),'g')
        %plot3(tvec,tvec*0+g,M(3,:),'b')
        plot3(tvec,tvec*0+g,M(3,:)*0,'k--')
    end
end
%%
[p x]=max(MT(:, ceil(size(MT,2)/2)),[],1)
figure
plot(MT(:,ceil(size(MT,2)/2)),tvec)
ylabel('Time after RF start')
xlabel('Transverse magnetization')
box off
set(gca,'FontSize',14) % Creates an axes and sets its FontSize to 18
figure
plot(gammaGR,MT(x,:))
xlabel('Position (Local field strength)')
ylabel('Transverse magnetization at 90^o flip')
box off
set(gca,'FontSize',14) % Creates an axes and sets its FontSize to 18

figure
plot(gammaGR,MT(end,:))
xlabel('Position (Local field strength)')
ylabel('Transverse magnetization after RF')
box off
set(gca,'FontSize',14) % Creates an axes and sets its FontSize to 18
figure
imagesc(MT)
xlabel('Position (Local field strength)')
ylabel('Time')
caxis([0 1])
a = colorbar;
a.Label.String = 'Transverse magnetization'
box off
set(gca,'FontSize',14) % Creates an axes and sets its FontSize to 18
figure
imagesc(angle/pi*180)
caxis([0 180])
a = colorbar;
a.Label.String = 'Flip angle'
xlabel('Position (Local field strength)')
ylabel('Time')
box off
set(gca,'FontSize',14) % Creates an axes and sets its FontSize to 18
