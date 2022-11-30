close all
tvec = 1:.1:100;
omega=1;
S=sin(tvec*omega)./tvec*omega;
S=[zeros(1,100) ones(1,20) zeros(1,100)]

K = (checkerboard(1,1,length(tvec)) > 0.5);
K=(K(1,:)-0.5)*2

%S=S.*K(1,1:length(S));

subplot(1,2,1)
plot(S,'.-')

s=fft(S);

subplot(1,2,2)
plot(abs(s),'.-k')
hold on
plot(angle(s),'-r')

%% check freqs (BRA FIGUR!)
clear
close all
tvec = 0:0.0001:1;
f=6;
s = sin(2*pi*f*tvec)+sin(2*pi*10*tvec);
%         subplot(4,3,1)
% plot(s)
% hold on
%check freqs
test_freqs=[2 4 6 8 10];
for i=1:length(test_freqs)
    test_wave = sin(2*pi*test_freqs(i)*tvec) + 1i* cos(2*pi*test_freqs(i)*tvec);
    S(i) = sum(s.*test_wave);
    
    %if test_freqs(i)==8
    subplot(length(test_freqs),3,(3*(i))-2)
    plot(tvec,s,'r','LineWidth',2)
    hold on
    plot(tvec,real(test_wave),'b','LineWidth',1.5)
    %  hold on
    %  plot(imag(test_wave),'b')
    title({'Original signal (thick red line) +',['Test signal @ ',num2str(test_freqs(i)),'Hz (thin blue line)']})
    box off
    subplot(length(test_freqs),3,(3*(i))-1)
    plot(tvec,real(s.*test_wave),'k')
    % hold on
    %  plot(imag(s.*test_wave),'b')
    ylim([-2,2])
    title('Original signal \times test signal')
    box off
    subplot(length(test_freqs),3,(3*(i))-0)
    plot(tvec,abs(cumsum(s.*test_wave)),'k')
    title('Cumulative sum of original signal \times test signal')
    box off
    % end
end
%         subplot(10,4,40)
%         plot(test_freqs,abs(S),'.-r')
%         title('P')

%% Check many freqs (bra fig!)

clear
close all
tvec = 0:0.001:1
f=6
s = sin(2*pi*f*tvec)
%         subplot(4,3,1)
% plot(s)
% hold on
%check freqs
test_freqs=1:10;
for i=1:length(test_freqs)
    test_wave = sin(2*pi*test_freqs(i)*tvec) + 1i* cos(2*pi*test_freqs(i)*tvec);
    S(i) = sum(s.*test_wave);
    
end
figure
plot(test_freqs,S,'o-')
xlabel('Frequency of test wave [Hz]')
ylabel('Integral of (original signal) \times (test wave) [a.u.]')
box off

%% ny fig test signals
tvec=0:0.0001:1;
s = 2*exp(-2*pi*1i*4*tvec) + 3*exp(-2*pi*1i*5*tvec) ;
%s = exp(-2*pi*1i*5*tvec) ;
figure
for j=1:10
    testS = exp(2*pi*1i*j*tvec);
    produ = testS.*s;
    sumProd(j) = sum(produ);
    subplot(4,4,j)
    plot(real(testS),'k')
    hold on
    plot(real(s),'k')
    plot(real(s.*testS),'r')
end

%% DFT effects (from Matlabs fft documentation) Used in chapter FFT!!!!
%Exercises in chapter FT.

Fs = 1000; %sampling frequency (1/s)
T = 1/Fs; % sampling period (s)
duration = 0.5 %s
N = duration*Fs; %lenght of signal
tvec = (0:N-1)*T; %the time vector

figure(1)
subplot(1,2,1)

f1=30;
f2=50;
curve=5;
decay=5;
c=0;
blockStart = 100+c
blockStop =400+c
switch curve
    case 0
        s = sin(2*pi*f1*tvec)%+2*sin(2*pi*f2*tvec);
    case 1
        s = sin(2*pi*f1*tvec)+2*sin(2*pi*f2*tvec);
    case 2
        s = exp(-decay*tvec);
    case 3
        s = (sin(2*pi*f1*tvec)+2*sin(2*pi*f2*tvec)).*exp(-decay*tvec);
    case 4
        s = 0*tvec;
        s(blockStart:blockStop)=1;
    case 5
        block = 0*tvec;
        block(blockStart:blockStop)=1;
        s=block.*(sin(2*pi*f1*tvec)+2*sin(2*pi*f2*tvec));
end
%s = s + 0.01*randn(size(tvec));
plot(1000*tvec(1:50),s(1:50),'-')
plot(1000*tvec,s,'-')
ylim([-5 5])
title('Signal s(t)')
xlabel('t (milliseconds)')
ylabel('s(t)')

%FFT
S= fft(s);
P2 = abs(S/N);
P2 = S/N;
%P1 = P2(1:N/2+1);
P1 = ifftshift(P2);
P1(2:end-1) = 2*P1(2:end-1);

fvec = Fs*((-N/2):(N/2-1))/N; %this is important!
box off
subplot(1,2,2)
if 1
    plot(fvec,real(P1),'-g')
    hold on
    plot(fvec,imag(P1),'-r')
    plot(fvec,abs(P1),'-k')
    legend('Real','Imag','Abs')
else
    plot(fvec,abs(P1),'-k')
end
title('Center-shifted Spectrum of S(f)')
xlabel('f (Hz)')
ylabel('|S(f)|')
box off
%% NOT USED
subplot(4,2,1)
plot(tvec,real(s));
hold on
plot(tvec,imag(s),'r');
subplot(4,2,2)
plot(fvec,real(fft(s)));
hold on
plot(fvec,imag(fft(s)),'r');
box off

t0=10;
subplot(4,2,3)
decay = exp(-t0*tvec);
plot(decay)
subplot(4,2,4)
plot(abs(fft(decay)))


subplot(4,2,5)
plot(s.*decay)
subplot(4,2,6)
plot(abs(fft(s.*decay)))


comb = 0*tvec;
comb(round(linspace(1,length(tvec),20)))=1;

subplot(4,2,7)
plot(comb)
subplot(4,2,8)
plot(abs(fft(comb)))

%% 2D FFTs (USED IN FIG 3.4!!!)
S=5
count=0
for s1=1:S
    for s2=1:S
        count=count+1;
        image = zeros(S);
        image(s1,s2) = 1;
        
        figure(1)
        subplot(S,S,count)
        imagesc(abs(image))
        axis equal off
        colormap(bone)
        figure(2)
        subplot(S,S,count)
        imagesc(real(fft2(ifftshift(image))))
        Image{s1,s2} = fft2(ifftshift(image));
        axis equal off
        colormap(bone)
    end
end

%


face = zeros(S);
face(2,2) = 2;
face(2,4) = 2;
face(4,2) = 1;
face(5,3) = 1;
face(4,4) = 1;
figure
subplot(1,2,1)
imagesc(face)
title('5x5 face')
axis equal off
colormap(bone)
subplot(1,2,2)
imagesc(abs(fftshift(fft2(face))))
title('2DFT of 5x5 face (only abs value shown)')
axis equal off
colormap(bone)
Face=fftshift(fft2(face));

sumFace = zeros(S);

count=0;
for s1=1:S
    for s2=1:S
        count=count+1;
        weight = Face(s1,s2);
        figure(9)
        subplot(5,5,count)
        imagesc(real(Image{s1,s2}.*conj(weight)));
        axis equal off
        title([num2str(abs(weight))])
        colormap(bone)
        figure(10)
        sumFace = sumFace+Image{s1,s2}.*conj(weight);
        subplot(5,5,count)
        imagesc(real(sumFace))
        axis equal off
        colormap(bone)
    end
end

