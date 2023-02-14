clear
movmake = true;

close all
V=1000 %number of vectors to simulate
Vvec = linspace(-.01,.01,V) %relative position along the gradient for the V vectors

%initialize the magnetization:
for v=1:V
    M(:,1,v)=[0 0 1]'; %direction, time, position
end

dt = 3e-7;
T = 750;

G = .5; %T %variation from -V/2 to V/2
gamma = 267.513e6; %rad/sT

%rot RF
a=pi/2+0.2
R_RF = [1 0 0
    0 cos(a) sin(a)
    0 -sin(a) cos(a)] ;
R_RF2 = [1 0 0
    0 cos(a) sin(a)
    0 -sin(a) cos(a)] ;
R_RF3 = [1 0 0
    0 cos(a) sin(a)
    0 -sin(a) cos(a)] ;


%times for RF pulse
tGrad=200;
TGrad=230;

RF_times = 2;
RF_times2 = RF_times+tGrad;
RF_times3 = RF_times+tGrad+TGrad;

t_8b = RF_times+tGrad+tGrad;
t_8bRF = RF_times+2*TGrad;
t_StimE = RF_times+TGrad+2*tGrad;

%Precess
for v=1:V
    w = gamma*G*Vvec(v); %rad/s
    R_prec(:,:,v) = [cos(w*dt) sin(w*dt) 0
        -sin(w*dt) cos(w*dt) 0
        0 0 1] ;
end

if movmake
    %%% Invisible movie creator: initialize %%%
    filename =strcat(['movies\eightball2',num2str(randi(1000))]);
    myVideo = VideoWriter(filename,'MPEG-4');
    myVideo.FrameRate = 6;
    myVideo.Quality = 99;
    open(myVideo)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
F=figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');
for t=2:T
    for v=1:V
        if ismember(t,RF_times)
            M(:,t,v) = R_RF*M(:,t-1,v);
        elseif ismember(t,RF_times2)
            M(:,t,v) = R_RF2*M(:,t-1,v);
        elseif ismember(t,RF_times3)
            M(:,t,v) = R_RF3*M(:,t-1,v);
        else
            M(:,t,v) = R_prec(:,:,v)*M(:,t-1,v);
        end
    end
end
for t=2:10:T
    disp(t)
    for v=round(linspace(1,V,25))
        subplot(3,2,[1 3 5])
        % if ismember(v,1:5:V)
        
        plot3([0 M(1,t,v)],[0 M(2,t,v)],[0 M(3,t,v)],'k')
        
        hold on
        %plot3([M(1,1:t,v)],[M(2,1:t,v)],[M(3,1:t,v)],'k-')
        plot3([M(1,t,v)],[M(2,t,v)],[M(3,t,v)],'ko')
        %  end
        %  if v==V
    end
    plot3(squeeze([M(1,t,:)]),squeeze([M(2,t,:)]),squeeze([M(3,t,:)]),'r-')
    %  end
    title(t)
    hold off
    axis equal
    axis([-1 1 -1 1 -1 1])
    subplot(3,2,2)
    for v=round(linspace(1,V,25))
        
        plot([0 M(1,t,v)],[0 M(2,t,v)],'k')
        
        hold on
        %plot3([M(1,1:t,v)],[M(2,1:t,v)],[M(3,1:t,v)],'k-')
        plot([M(1,t,v)],[M(2,t,v)],'ko')
    end
    
    plot(squeeze([M(1,t,:)]),squeeze([M(2,t,:)]),'r-')
    
    title('Top view')
    axis equal
    hold off
    axis([-1 1 -1 1])
    
    subplot(3,2,4)
    for v=round(linspace(1,V,25))
        
        plot([0 M(1,t,v)],[0 M(3,t,v)],'k')
        
        hold on
        %plot3([M(1,1:t,v)],[M(2,1:t,v)],[M(3,1:t,v)],'k-')
        plot([M(1,t,v)],[M(3,t,v)],'ko')
    end
    
    plot(squeeze([M(1,t,:)]),squeeze([M(3,t,:)]),'r-')
    
    title('Side view')
    axis equal
    hold off
    axis([-1 1 -1 1])
    subplot(3,2,6)
    cla
    hold on
    plot(1:t,sqrt(sum(M(1,1:t,:),3).^2+sum(M(2,1:t,:),3).^2),'.-k')
   % plot(1:t,sqrt(sum(M(1,1:t,:),3).^2),'-r')
   % plot(1:t,sqrt(sum(M(2,1:t,:),3).^2),'-g')
    plot(1:t,sqrt(sum(M(3,1:t,:),3).^2),'.-b')
    plot([1 1]*t_8b,ylim,':r')
    plot([1 1]*t_8bRF,ylim,':g')
    plot([1 1]*t_StimE,ylim,':b')
    plot([1 1]*RF_times,ylim,'--k')
    plot([1 1]*RF_times2,ylim,'--k')
    plot([1 1]*RF_times3,ylim,'--k')
    title('M_T (black), M_z (blue)')
    xlabel('Time point')
    set(gcf,'renderer','Painters')
    pause(0.01)
if movmake
       % set(gcf,'Position',UserParam.FullSizeFigurePosition)
 %       set(gcf,'units','normalized','outerposition',[0 0 1 1])
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
    disp('Video created')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end


%% two different FA
clear
close all
V=41 %number of vectors to simulate
Vvec = linspace(-.01,.01,V) %relative position along the gradient for the V vectors

%initialize the magnetization:
for v=1:V
    M(:,1,v)=[0 0 1]'; %direction, time, position
end

dt = 6e-7;
T = 62;

G = 0.1 %T %variation from -V/2 to V/2
gamma = 267.513e6 %rad/sT

%rot RF
a=pi/2;
R_RF = [1 0 0
    0 cos(a) sin(a)
    0 -sin(a) cos(a)] ;
a=pi/4;
R_RF2 = [1 0 0
    0 cos(a) sin(a)
    0 -sin(a) cos(a)] ;


%times for RF pulse
RF_times = 2
RF_times2 = 22:20:T

%Precess
for v=1:V
    w = gamma*G*Vvec(v); %rad/s
    R_prec(:,:,v) = [cos(w*dt) sin(w*dt) 0
        -sin(w*dt) cos(w*dt) 0
        0 0 1] ;
end

figure(1)
for t=2:T
    for v=1:V
        if ismember(t,RF_times)
            M(:,t,v) = R_RF*M(:,t-1,v);
        elseif ismember(t,RF_times2)
            M(:,t,v) = R_RF2*M(:,t-1,v);
        else
            M(:,t,v) = R_prec(:,:,v)*M(:,t-1,v);
        end
    end
    for v=1:5:V
        subplot(3,2,[1 3 5])
        % if ismember(v,1:5:V)
        
        plot3([0 M(1,t,v)],[0 M(2,t,v)],[0 M(3,t,v)],'k')
        
        hold on
        %plot3([M(1,1:t,v)],[M(2,1:t,v)],[M(3,1:t,v)],'k-')
        plot3([M(1,t,v)],[M(2,t,v)],[M(3,t,v)],'ko')
        %  end
        %  if v==V
    end
    plot3(squeeze([M(1,t,:)]),squeeze([M(2,t,:)]),squeeze([M(3,t,:)]),'r-')
    %  end
    title(t)
    hold off
    axis equal
    axis([-1 1 -1 1 -1 1])
    subplot(3,2,2)
    for v=1:5:V
        
        plot([0 M(1,t,v)],[0 M(2,t,v)],'k')
        
        hold on
        %plot3([M(1,1:t,v)],[M(2,1:t,v)],[M(3,1:t,v)],'k-')
        plot([M(1,t,v)],[M(2,t,v)],'ko')
    end
    
    plot(squeeze([M(1,t,:)]),squeeze([M(2,t,:)]),'r-')
    
    title('Top view')
    axis equal
    hold off
    axis([-1 1 -1 1])
    
    subplot(3,2,4)
    for v=1:5:V
        
        plot([0 M(1,t,v)],[0 M(3,t,v)],'k')
        
        hold on
        %plot3([M(1,1:t,v)],[M(2,1:t,v)],[M(3,1:t,v)],'k-')
        plot([M(1,t,v)],[M(3,t,v)],'ko')
    end
    
    plot(squeeze([M(1,t,:)]),squeeze([M(3,t,:)]),'r-')
    
    title('Side view')
    axis equal
    hold off
    axis([-1 1 -1 1])
    subplot(3,2,6)
    cla
    hold on
    plot(1:t,sqrt(sum(M(1,1:t,:),3).^2+sum(M(2,1:t,:),3).^2),'.k')
    plot(1:t,sqrt(sum(M(1,1:t,:),3).^2),'-r')
    plot(1:t,sqrt(sum(M(2,1:t,:),3).^2),'-g')
    plot(1:t,sqrt(sum(M(3,1:t,:),3).^2),'-b')
    title('M_T')
    xlabel('Time point')
    set(gcf,'renderer','Painters')
    pause(0.1)
end
