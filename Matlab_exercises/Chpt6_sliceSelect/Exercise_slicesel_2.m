%% Block function and truncation, slice selection (exercise 6.7)
%a
clear
Fs = 1e6; %sampling frequency (1/s)
T = 1/Fs; % sampling period (s)
duration = 1 %Duration of the simulation
N = duration*Fs; %lenght of signal
tvec = ((-N)/2:(N-1)/2)*T; %the time vector

figure(1)
subplot(1,2,1)

curve=3 %1=a+b, 2=c, 3=d
switch curve
    case 1  
        b=3000; %3 kHz
        s=sin(tvec*2*pi*b)./(tvec*2*pi*b);
        s(isnan(s))=1;
    case 2 %keep only middle 8 ms
        b=3000; %3 kHz
        s=sin(tvec*2*pi*b)./(tvec*2*pi*b);
        s(isnan(s))=1;
        s(tvec<-4e-3) = 0;
        s(tvec>4e-3) = 0;
    case 3 %keep only middle 2 ms
        b=3000; %3 kHz
        c=3000; %3 kHz
        s=sin(tvec*2*pi*c);
        s(isnan(s))=1;
        s(tvec<-1e-3) = 0;
        s(tvec>1e-3) = 0;
end
%s = s + 0.01*randn(size(tvec));
%plot(1000*tvec(1:50),s(1:50),'.-')
plot(1000*tvec,s,'-')
title('Signal s(t)')
xlabel('t (milliseconds)')
ylabel('s(t)')
xlim([-5 5])

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

plot(fvec/1000,abs(P1),'-k')
xlim([-10 10]) %+/- 10 kHz
title('Center-shifted Spectrum of S(f)')
xlabel('f (kHz)')
ylabel('|S(f)|')
%xlim([-150 150])
box off
