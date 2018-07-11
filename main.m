clc
clear

[filename, pathname] = ...
    uigetfile({'*.tiff';'*.tif';'*.*'},'File Selector');
Fig = fullfile(pathname, filename);

%% 

f = imread(Fig);
f = im2double(f);
F = fft2(double(f));
imshow(F);
[m,n,ch]  = size(F);
if ch == 3
    img = rgb2gray(F);
end
figure;
imshow(Fig);
title('原始图像');
% DCT transform
img_dct = dct2(F); 
I = zeros(m,n);
% High frequency shielding
I(1:m/3, 1:n/3)=1; 
Ydct = img_dct .* I;
% Inverse DCT transform
img_dct = uint8(idct2(Ydct)); 
% Output the result
figure
imshow(img_dct);
title('去噪之后');
% psnr_dct = eval_psnr(F, img_dct);
%%