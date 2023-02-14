clear
alpha = pi/180*70

I=10

    figure(1)
    for i=1:2
    subplot(1,2,i)
    hold off
    quiver3(-1,0,0,2,0,0,1,'Color',[0 0 0],'LineWidth',1.5)
    hold on
    quiver3(0,-1,0,0,2,0,1,'Color',[0 0 0],'LineWidth',1.5)
    quiver3(0,0,-1,0,0,2,1,'Color',[0 0 0],'LineWidth',1.5)
    xlabel('x''')
    ylabel('y''')
    zlabel('z''')
    grid on
    hold on
    end
for i=0:I
    theta = pi/2/I*i
    x = [0 1 0]'*.8
    R2 = [cos(theta) sin(theta) 0
         -sin(theta) cos(theta) 0
         0 0 1]
    x=R2*x
    R = [1 0 0
        0 cos(alpha) sin(alpha)
        0 -sin(alpha) cos(alpha)]
    x2 = R*x
    subplot(1,2,1)
    quiver3(0,0,0,x(1),x(2),x(3),1,'Color',[1 0 0]*i/I,'LineWidth',5)
    quiver3(0,0,0,x(1),x(2),0,1,'Color',[1 0 0]*i/I,'LineWidth',2)
    quiver3(0,0,0,0,0,x(3),1,'Color',[1 0 0]*i/I,'LineWidth',2)

    subplot(1,2,2)
    quiver3(0,0,0,x2(1),x2(2),x2(3),1,'Color',[1 0 0]*i/I,'LineWidth',5)
    quiver3(0,0,0,x2(1),x2(2),0,1,'Color',[1 0 0]*i/I,'LineWidth',2)
    quiver3(0,0,0,0,0,x2(3),1,'Color',[1 0 0]*i/I,'LineWidth',2)
end
    for i=1:2
    subplot(1,2,i)
axis equal
axis([-1 1 -1 1 -1 1]*1.1)
view([  67 24])
    end