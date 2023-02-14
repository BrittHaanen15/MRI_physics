addpath R:\Felles_PCRTP\div
dt = 1e-3;
T=1000;

close all
gamma = 1;


for model =1
switch model
    case 1
        M0 = [1 0 1]';
        M=zeros(3,T);
        M(:,1) = M0;
        T1 = 1;
        T2 = 1;
        B1 = 0;
        B0 = 0;
        omega_RF = gamma*B0;
        omega_rot = gamma*B0;
        %omega_rot = omega_RF;
        titlestring = 'Static B_0 and perfect on-resonance  B_1 (rFoV)';
end
finished = false;
t=2;
stopT=T;
while t<T && ~finished
%for t=2:T
    disp(t)
    B = [B1 * cos((omega_RF-omega_rot)*t*dt);
        -B1 * sin((omega_RF-omega_rot)*t*dt);
        B0-omega_rot/gamma];
    B1only = [B1 * cos((omega_RF-omega_rot)*t*dt);
        -B1 * sin((omega_RF-omega_rot)*t*dt);
        0];
    B0only = [0;
        0;
        B0-omega_rot/gamma];
    dMdT(:,t) = gamma * cross(M(:,t-1),B);
    dMdT_B1only(:,t) = gamma * cross(M(:,t-1),B1only);
    dMdT_B0only(:,t) = gamma * cross(M(:,t-1),B0only);
    M(:,t) = M(:,t-1)+dMdT(:,t)*dt;

    %relax
    dMxdt = -M(1,t)/T2;
    dMydt = -M(2,t)/T2;
    dMzdt = -(M(3,t)-1)/T1;
    M(1,t) = M(1,t)+dMxdt*dt;
    M(2,t) = M(2,t)+dMydt*dt;
    M(3,t) = M(3,t)+dMzdt*dt;
    
    if 0
        if t>T/10
            if norm(M(:,t)-M(:,1))<1e-2
                finished=true;
                stopT = t;
            end
        end
    end
    t=t+1;
%end
end

%%
movmake=true;
if movmake
    %%% Invisible movie creator: initialize %%%
    filename =strcat(['movies\sim_model',num2str(model),'_',num2str(randi(10000))]);
    myVideo = VideoWriter(filename,'MPEG-4');
    myVideo.FrameRate = 12;
    myVideo.Quality = 90;
    open(myVideo)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

for t=1:100:stopT %400 frames @ 20fps = 20 sek
    F=figure(1)
    for i=1:6
        subtightplot(2,3,i,.1,.1,.2)
        quiver3(0,0,0,M(1,t),M(2,t),M(3,t),1,'b','LineWidth',4)
        hold on
        %%quiver3(M(1,t),M(2,t),M(3,t),dMdT(1,t),dMdT(2,t),dMdT(3,t),.000000002,'k','LineWidth',2)
        quiver3(M(1,t),M(2,t),M(3,t),dMdT_B1only(1,t),dMdT_B1only(2,t),dMdT_B1only(3,t),.00000002,'g','LineWidth',2)
        quiver3(M(1,t),M(2,t),M(3,t),dMdT_B0only(1,t),dMdT_B0only(2,t),dMdT_B0only(3,t),.000000002,'r','LineWidth',2)
        quiver3(0,0,0,1,0,0,1,'k')
        quiver3(0,0,0,0,1,0,1,'k')
        quiver3(0,0,0,0,0,1,1,'k')
        trail = 1%max([1 t-500])
        plot3(M(1,trail:t),M(2,trail:t),M(3,trail:t),'b')
       % plot3(M(1,1:t),M(2,1:t),0*M(3,1:t),'r--')
        hold off
       % 
        %ax=gca;
       % ax.Clipping = 'off'; 
        xlabel('x')
        ylabel('y')
        zlabel('z')
        switch i
            case 1
                view([-38 34])
            case 2
                view([0 90])
                title(titlestring)
            case 3
                view([90 0])
            case 4
                view([-gamma*B0*t*dt/pi*180+0 34])
            case 5
                view([-gamma*B0*t*dt/pi*180+0 90])
               % title(titlestring)
            case 6
                view([-gamma*B0*t*dt/pi*180+90 0])
          
        end
        %axis manual
        set(gca,'CameraViewAngleMode','Manual')
        axis equal
        axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
        set(gcf,'color','w');
    end
    pause(.05)
    if movmake
       % set(gcf,'Position',UserParam.FullSizeFigurePosition)
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        %%% Invisible movie creator: Frame capture %%%
        %img = hardcopy(F, '-dzbuffer', '-r0');
        %%
        %figure(F)
        writeVideo(myVideo,getframe(F));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
end
if movmake
    %%% Invisible movie creator: File closing %%%
    close(myVideo);
    disp(['Video created (',filename,')'])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
end