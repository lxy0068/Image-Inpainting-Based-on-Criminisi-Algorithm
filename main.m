clc;
clear;
close all;

imagepath =imread( 'hua.bmp');   % ԭͼ�����ڼ���PSNR
maskpath =imread('huamask.bmp');   % ����ͼ��
fillColor=[255,255,0];   % ����ͼ���б궨����������RGB��ɫֵ
qukuai_size = 5;   % ѡ����������С3*3��5*5��7*7��9*9��...
disp('��ʼͼ���޸�')
disp('......')
tic   % ��ʱ��ʼ��
[Psnr,inpaintedImg] =RGB_Criminisi(imagepath, maskpath, fillColor, qukuai_size);
disp('ͼ���޸�����')
toc   % ��ʱ������
Psnr
inpaintedImg=uint8(inpaintedImg);
subplot(1,2,1)
imshow(maskpath);
title('���޸�ͼ��');
subplot(1,2,2)
imshow(inpaintedImg);
title('CDD-KSVD�㷨�޸����');
