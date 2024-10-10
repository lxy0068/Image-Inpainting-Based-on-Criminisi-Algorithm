function [Psnr,inpaintedImg] =RGB_Criminisi(imagepath, maskpath, fillColor, qukuai_size)
img0=imagepath;
fillImg=maskpath;
img = double(fillImg);
fillRegion=img(:,:,1)==fillColor(1)&img(:,:,2)==fillColor(2)&img(:,:,3)==fillColor(3);

origImg = img;
ind = img2ind(img);
%-----------------------------------------------------
sz = [size(img,1) size(img,2)];
z1=size(img,1);
z2=size(img,2);
sourceRegion = ~fillRegion;

% ����ն���ֵ
[Ix(:,:,3),Iy(:,:,3)] = gradient(img(:,:,3));
[Ix(:,:,2),Iy(:,:,2)] = gradient(img(:,:,2));
[Ix(:,:,1),Iy(:,:,1)] = gradient(img(:,:,1));
Ix = sum(Ix,3)/(3*255); Iy = sum(Iy,3)/(3*255);
temp = Ix; Ix = -Iy; Iy = temp;  % ��ת90��

%------------------------------------------------------------------------
%����ݶ�ֵ
[ix(:,:,3),iy(:,:,3)] = gradient(img(:,:,3));
[ix(:,:,2),iy(:,:,2)] = gradient(img(:,:,2));
[ix(:,:,1),iy(:,:,1)] = gradient(img(:,:,1));
ix = sum(ix,3)/(3*255); iy = sum(iy,3)/(3*255);
%------------------------------------------------------------------------

% ��ʼ�����Ŷ���C��������Dֵ
C = double(sourceRegion);
D = repmat(-.1,sz);

% �޸���ֱ�����е��������򶼱��޸���ɣ�
while any(fillRegion(:))
  % Ѱ�ұ�Ե
  dR = find(conv2(double(fillRegion),[1,1,1;1,-8,1;1,1,1],'same')>0);
  [Nx,Ny] = gradient(double(~fillRegion));
  N = [Nx(dR(:)) Ny(dR(:))]; 
  N(~isfinite(N))=0; 
  
  % �������Ŷ���ֵ
  for k=dR'
    Hp = qukuai_9(sz, k, qukuai_size);
    q = Hp(~(fillRegion(Hp)));
    C(k) = sum(C(q))/numel(Hp);  
  end
  
 % ��������Ȩ
   D(dR) = abs(Ix(dR).*N(:,1)+Iy(dR).*N(:,2)) /255;
   priorities =C(dR).*D(dR); 
  
  
 % �ҵ�����Ȩ���Ŀ� Hp
  [~,ndx] = max(priorities(:));
  p = dR(ndx(1));
  %---------------------
 
  [Hp,rows,cols] = qukuai_9(sz,p,qukuai_size);   %9x9���С
  toFill=fillRegion(Hp);  
  Wpatch=img(rows,cols,:); %�õ����޸���
  
  %------------------------------------------------------------------------
  %����ȫ��������Ѱ�����ƥ��� 
   Hq=whole_match(z1,z2,img,Wpatch,fillColor);
  %------------------------------------------------------------------------
  
  % �����������
  fillRegion(Hp(toFill)) = false;
  
  % ����C(p)ֵ�͵��ն���ֵ
  C(Hp(toFill))  = C(p);
  Ix(Hp(toFill)) = Ix(Hq(toFill));
  Iy(Hp(toFill)) = Iy(Hq(toFill));
  
  %-----------------------------------------------------------------------
  %�����ݶ�ֵ
  ix(Hp(toFill)) = ix(Hq(toFill));
  iy(Hp(toFill)) = iy(Hq(toFill));
  %----------------------------------------------------------------------
  
  
  % ��Hq����ͼ����Ϣ��Hp
  ind(Hp(toFill)) = ind(Hq(toFill));
  img(rows,cols,:) = ind2img(ind(rows,cols),origImg);  
 
end

inpaintedImg=img;

A=double(img0);
B=double(inpaintedImg);

Psnr=PSNR(A,B);