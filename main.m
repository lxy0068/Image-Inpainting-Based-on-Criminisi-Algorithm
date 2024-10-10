clc;
clear;
close all;

imagepath =imread( 'hua.bmp');   % 原图像，用于计算PSNR
maskpath =imread('huamask.bmp');   % 破损图像
fillColor=[255,255,0];   % 破损图像中标定的破损区域RGB颜色值
qukuai_size = 5;   % 选择填充区块大小3*3，5*5，7*7，9*9，...
disp('开始图像修复')
disp('......')
tic   % 计时开始点
[Psnr,inpaintedImg] =RGB_Criminisi(imagepath, maskpath, fillColor, qukuai_size);
disp('图像修复结束')
toc   % 计时结束点
Psnr
inpaintedImg=uint8(inpaintedImg);
subplot(1,2,1)
imshow(maskpath);
title('待修复图像');
subplot(1,2,2)
imshow(inpaintedImg);
title('CDD-KSVD算法修复结果');
