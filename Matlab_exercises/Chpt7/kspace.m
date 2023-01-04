% exercise on kspace with brain image
set(0, 'DefaultFigureRenderer', 'painters');

%% exercise 7.2a and b
im = imread('brain.jpg');
Im = fftshift(fft2(im));
figure
subplot(3,1,1)
imagesc(im)
axis equal off
colormap bone
title('Original image')
subplot(3,1,2)
imagesc(log(abs(Im)))
axis equal off
colormap bone
title('Log of k-space')
subplot(3,1,3)
imagesc((angle(Im)))
axis equal off
colormap bone
title('Angle of k-space')

%% exercise 7.2c
figure
subplot(1,3,1)
plot(abs(Im(:,256)))
xlim([0 512])
ylim([0 2.5e6])
xlabel('K-space line 256')
ylabel('Signal amplitude')
subplot(1,3,2)
plot(abs(Im(:,257)))
xlim([0 512])
ylim([0 2.5e6])
xlabel('K-space line 257')
ylabel('Signal amplitude')
subplot(1,3,3)
plot(abs(Im(:,258)))
xlim([0 512])
ylim([0 2.5e6])
xlabel('K-space line 258')
ylabel('Signal amplitude')

%% exercise 7.3a
Im_striped = Im; %copy original kspace
Im_striped(1:2:end,:) = 0; %remove every other line
im_striped = ifft2(ifftshift(Im_striped)); %inverse fft

figure
subplot(1,3,1)
imagesc(im)
axis equal off
colormap bone
title('Original image')
subplot(1,3,2)
imagesc(log(abs(Im_striped)))
axis equal off
colormap bone
title('Log of striped k-space')
subplot(1,3,3)
imagesc((abs(im_striped)))
axis equal off
colormap bone
title('Inverse FFT of striped k-space')


%% exercise 7.3b
Im_halved = Im(1:2:end,:); %copy every other line from the original kspace
im_halved = ifft2(ifftshift(Im_halved)); %inverse fft

figure
subplot(1,3,1)
imagesc(im)
axis equal off
colormap bone
title('Original image')
subplot(1,3,2)
imagesc(log(abs(Im_halved)))
axis equal off
colormap bone
title('Log of halved k-space')
subplot(1,3,3)
imagesc((abs(im_halved)))
axis equal off
colormap bone
title('Inverse FFT of halved k-space')



%% exercise 7.3c
Im_changed = Im; %copy the original kspace
Im_changed(256-10:256+11,256-10:256+11) = 0; %copy the original kspace
im_changed = ifft2(ifftshift(Im_changed)); %inverse fft

figure
subplot(1,3,1)
imagesc(im)
axis equal off
colormap bone
title('Original image')
subplot(1,3,2)
imagesc(log(abs(Im_changed)))
axis equal off
colormap bone
title('Log of perturbed k-space')
subplot(1,3,3)
imagesc((abs(im_changed)))
axis equal off
colormap bone
title('Inverse FFT of perturbed k-space')


%% exercise 7.3d
Im_changed = Im; %copy the original kspace
rimSize = 220;
Im_changed(1:rimSize,:) = 0; %remove outer rim
Im_changed(end-rimSize:end,:) = 0; %remove outer rim
Im_changed(:,1:rimSize) = 0; %remove outer rim
Im_changed(:,end-rimSize:end) = 0; %remove outer rim
im_changed = ifft2(ifftshift(Im_changed)); %inverse fft

figure
subplot(1,3,1)
imagesc(im)
axis equal off
colormap bone
title('Original image')
subplot(1,3,2)
imagesc(log(abs(Im_changed)))
axis equal off
colormap bone
title('Log of perturbed k-space')
subplot(1,3,3)
imagesc((abs(im_changed)))
axis equal off
colormap bone
title('Inverse FFT of perturbed k-space')


%% exercise 7.3e
Im_changed = Im; %copy the original kspace
Im_changed(:,1:256) = 0; %remove left half of image, but keep the central line
im_changed = ifft2(ifftshift(Im_changed)); %inverse fft

figure
subplot(1,3,1)
imagesc(im)
axis equal off
colormap bone
title('Original image')
subplot(1,3,2)
imagesc(log(abs(Im_changed)))
axis equal off
colormap bone
title('Log of perturbed k-space')
subplot(1,3,3)
imagesc((abs(im_changed)))
axis equal off
colormap bone
title('Inverse FFT of perturbed k-space')

%% exercise 7.3f
Im_changed = Im; %copy the original kspace
Im_changed(258:end,:) = 0; %remove bottom half of image, but keep the central line
im_changed = ifft2(ifftshift(Im_changed)); %inverse fft

figure
subplot(1,3,1)
imagesc(im)
axis equal off
colormap bone
title('Original image')
subplot(1,3,2)
imagesc(log(abs(Im_changed)))
axis equal off
colormap bone
title('Log of perturbed k-space')
subplot(1,3,3)
imagesc((abs(im_changed)))
axis equal off
colormap bone
title('Inverse FFT of perturbed k-space')