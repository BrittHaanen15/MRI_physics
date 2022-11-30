% Script plotting how the GRE  signal evolves at different
% T1s, T2s and flip angles

clear
close all
for ss=1:2
    figure
for s=1:4
    switch s
        case 1
            subplot(2,2,1)
            T1= 600;
            T2= 20;
            TR = 20;
            N = 50; %how many TR's are simulated
            
        case 2
            subplot(2,2,2)
            T1= 1200;
            T2= 20;
            TR = 20;
            N = 50; %how many TR's are simulated
        case 3
            subplot(2,2,3)
            T1= 600;
            T2= 20;
            TR = 100;
            N = 10; %how many TR's are simulated
        case 4
            subplot(2,2,4)
            T1= 1200;
            T2= 20;
            TR = 100;
            N = 10; %how many TR's are simulated
    end
    
    fa = [20 50 90]/180*pi;
    
    dt = 1; %simulation time steps
    
    M0=1;
    Ma(1) = M0; %initial value for Ma
    Mb(1) = M0; %initial value for Mb
    Mc(1) = M0; %initial value for Mc
    
    MTa(1) = 0; %initial value for MTa
    MTb(1) = 0; %initial value for MTb
    MTc(1) = 0; %initial value for MTc
    
    i=1;
    for n=1:N 
        %flip the signal!
        MTa(i) = Ma(i) * sin(fa(1)); 
        MTb(i) = Mb(i) * sin(fa(2));
        MTc(i) = Mc(i) * sin(fa(3)); 
        
        Ma(i) = Ma(i) * cos(fa(1)); 
        Mb(i) = Mb(i) * cos(fa(2)); 
        Mc(i) = Mc(i) * cos(fa(3));
        
        for t=0:dt:TR %evolve the signal!
            Ma(i+1) = Ma(i)*exp(-dt/T1)+(1-exp(-dt/T1))*M0;
            Mb(i+1) = Mb(i)*exp(-dt/T1)+(1-exp(-dt/T1))*M0;
            Mc(i+1) = Mc(i)*exp(-dt/T1)+(1-exp(-dt/T1))*M0;
            
            MTa(i+1) = MTa(i)*exp(-dt/T2);
            MTb(i+1) = MTb(i)*exp(-dt/T2);
            MTc(i+1) = MTc(i)*exp(-dt/T2);
            i=i+1;
        end
    end
    if ss==1
    plot(Ma,'k','LineWidth',1)
    hold on
    plot(Mb,'r','LineWidth',2)
    plot(Mc,'b','LineWidth',3)
    ylim([0 1])
    if s==1
    legend('Flip = 20 degrees','Flip = 50 degrees','Flip = 90 degrees')
    end
    xlabel('Time (ms)')
    ylabel('Mz (a.u.)')
    title(['T1 = ',num2str(T1),' ms, TR = ',num2str(TR),' ms'])
    end
    
    if ss==2    
    plot(MTa,'k','LineWidth',1)
    hold on
    plot(MTb,'r','LineWidth',2)
    plot(MTc,'b','LineWidth',3)
    ylim([0 1])
    if s==1
    legend('Flip = 20 degrees','Flip = 50 degrees','Flip = 90 degrees')
    end
    xlabel('Time (ms)')
    ylabel('Mt (a.u.)')
    title(['T2 = ',num2str(T2),' ms, TR = ',num2str(TR),' ms'])
    end
    clear M*
end
end