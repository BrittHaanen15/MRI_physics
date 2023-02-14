clear
 set(0, 'DefaultFigureRenderer', 'painters');
 

dt = 0.001;
T = 500;
phi(1) = 0;
gamma=1;
figure
count=1
for iii=1:4
for ii=1:3
    switch ii
        case 1
            x0=25;
            v0=0;
            a0=0;
            titlestring='Constant position';
        case 2
            x0=0;
            v0=0.1;
            a0=0;
            titlestring='Constant velocity';
        case 3
            x0=0;
            v0=0;
            a0=0.003;
            titlestring='Constant acceleration';
    end
    switch iii
        case 1
            G = [zeros(1,50) ones(1,100) zeros(1,50)];

        case 2
            G = [zeros(1,50) ones(1,100) zeros(1,0) -ones(1,100) zeros(1,50)];

        case 3
            G = [zeros(1,50) ones(1,100) zeros(1,0) -ones(1,100)*2 ones(1,100) zeros(1,50)];

        case 4
            G = [zeros(1,50) ones(1,50) zeros(1,0) -ones(1,50)*3 ones(1,50)*3 -ones(1,50)  zeros(1,50)];
           % G = [zeros(1,50) ones(1,50) zeros(1,0) -ones(1,150) ones(1,150) -ones(1,50)  zeros(1,50)];
    end
    clear phi
    phi(1) = 0;
for t=2:length(G)
    dPhi = gamma * G(t)*(x0+v0*t+0.5*a0*t^2) * dt;
    phi(t) = phi(t-1)+dPhi;
end
subplot(4,3,count)
count=count+1;
plot(G*0,'k:')
hold on
plot(G*1,'k')
plot(phi,'r','LineWidth',2)
hold off
title(titlestring)
ylim([-5 5])

end
end

%% Effect of position of single polar gradient, bipolar and tripolar.
clear


dt = 0.001;
T = 500;
phi(1) = 0;
gamma=1;
for g=1:3
figure
count=1
for iii=1:3
for ii=1:3
    switch ii
        case 1
            x0=25;
            v0=0;
            a0=0;
            titlestring='Constant position';
        case 2
            x0=0;
            v0=0.1;
            a0=0;
            titlestring='Constant velocity';
        case 3
            x0=0;
            v0=0;
            a0=0.0005;
            titlestring='Constant acceleration';
    end
    switch iii
        case 1
            if g==1
                G = [zeros(1,100) ones(1,100) zeros(1,300)];
            elseif g==2
                G = [zeros(1,100) ones(1,100) -ones(1,100) zeros(1,300)];
            elseif g==3
                G = [zeros(1,100) ones(1,100) -ones(1,200) ones(1,100) zeros(1,300)];
            end
            
        case 2
            if g==1
                G = [zeros(1,200) ones(1,100) zeros(1,200)];
            elseif g==2
                G = [zeros(1,200) ones(1,100) -ones(1,100) zeros(1,200)];
            elseif g==3
                G = [zeros(1,200) ones(1,100) -ones(1,200) ones(1,100) zeros(1,200)];
            end
            
        case 3
            if g==1
                G = [zeros(1,300) ones(1,100) zeros(1,100)];
            elseif g==2
                G = [zeros(1,300) ones(1,100) -ones(1,100) zeros(1,100)];
            elseif g==3
                G = [zeros(1,300) ones(1,100) -ones(1,200) ones(1,100) zeros(1,100)];
            end

    end
    clear phi
    phi(1) = 0;
for t=2:length(G)
    dPhi = gamma * G(t)*(x0+v0*t+0.5*a0*t^2) * dt;
    phi(t) = phi(t-1)+dPhi;
end
subplot(3,3,count)
count=count+1;
plot(G*0,'k:')
hold on
plot(G*1,'k')
plot(phi,'r','LineWidth',2)
hold off
title(titlestring)
ylim([-5 5])
box off
end
end
end