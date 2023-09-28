close all

image=imcomplement(imread('smiling_face2.bmp'));
image=double(image);
image = padarray(image,[25 25],0);
se = offsetstrel('ball',5,5);
image = (imdilate(image,se));

t2map = ones(size(image));

for i=1:length(t2map)
    t2map(i,:) = t2map(i,:).*exp(-i/50);
end

Image = fftshift(fft2(image));
T2map = ifftshift(ifft2(t2map));

ImagePer = Image.*t2map;

imagePer = ifft2(ImagePer);

figure
imagesc(image)
axis equal off
colormap(bone)
title('A smiling face')

%%

figure
imagesc((abs(Image)))
caxis([0 25])
axis equal off
colormap(bone)
title('The FFT of a smiling face (the "k-space")')
%%

figure
imagesc(t2map)
axis equal off
colormap(bone)
title('An exponential decay in the k-space PE direction')

figure
imagesc((abs(T2map)))
caxis([0 1])
axis equal off
colormap(bone)
title('The FFT of an exponential decay in the k-space PE direction')

figure
imagesc((abs(ImagePer)))
caxis([0 25])
axis equal off
colormap(bone)
%caxis([0 100])
title('The FFT of a smiling face (the "k-space") with an exponential decay in the k-space PE direction')

figure
imagesc((abs(imagePer)))
axis equal off
colormap(bone)
title('A smiling face with an exponential decay in the k-space PE direction')