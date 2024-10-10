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

% 求等照度线值
[Ix(:,:,3),Iy(:,:,3)] = gradient(img(:,:,3));
[Ix(:,:,2),Iy(:,:,2)] = gradient(img(:,:,2));
[Ix(:,:,1),Iy(:,:,1)] = gradient(img(:,:,1));
Ix = sum(Ix,3)/(3*255); Iy = sum(Iy,3)/(3*255);
temp = Ix; Ix = -Iy; Iy = temp;  % 旋转90度

%------------------------------------------------------------------------
%求得梯度值
[ix(:,:,3),iy(:,:,3)] = gradient(img(:,:,3));
[ix(:,:,2),iy(:,:,2)] = gradient(img(:,:,2));
[ix(:,:,1),iy(:,:,1)] = gradient(img(:,:,1));
ix = sum(ix,3)/(3*255); iy = sum(iy,3)/(3*255);
%------------------------------------------------------------------------

% 初始化置信度项C和数据项D值
C = double(sourceRegion);
D = repmat(-.1,sz);

% 修复（直到所有的破损区域都被修复完成）
while any(fillRegion(:))
  % 寻找边缘
  dR = find(conv2(double(fillRegion),[1,1,1;1,-8,1;1,1,1],'same')>0);
  [Nx,Ny] = gradient(double(~fillRegion));
  N = [Nx(dR(:)) Ny(dR(:))]; 
  N(~isfinite(N))=0; 
  
  % 计算置信度项值
  for k=dR'
    Hp = qukuai_9(sz, k, qukuai_size);
    q = Hp(~(fillRegion(Hp)));
    C(k) = sum(C(q))/numel(Hp);  
  end
  
 % 计算优先权
   D(dR) = abs(Ix(dR).*N(:,1)+Iy(dR).*N(:,2)) /255;
   priorities =C(dR).*D(dR); 
  
  
 % 找到优先权最大的块 Hp
  [~,ndx] = max(priorities(:));
  p = dR(ndx(1));
  %---------------------
 
  [Hp,rows,cols] = qukuai_9(sz,p,qukuai_size);   %9x9块大小
  toFill=fillRegion(Hp);  
  Wpatch=img(rows,cols,:); %得到待修复块
  
  %------------------------------------------------------------------------
  %采用全局搜索，寻找最佳匹配块 
   Hq=whole_match(z1,z2,img,Wpatch,fillColor);
  %------------------------------------------------------------------------
  
  % 更新填充区域
  fillRegion(Hp(toFill)) = false;
  
  % 更新C(p)值和等照度线值
  C(Hp(toFill))  = C(p);
  Ix(Hp(toFill)) = Ix(Hq(toFill));
  Iy(Hp(toFill)) = Iy(Hq(toFill));
  
  %-----------------------------------------------------------------------
  %更新梯度值
  ix(Hp(toFill)) = ix(Hq(toFill));
  iy(Hp(toFill)) = iy(Hq(toFill));
  %----------------------------------------------------------------------
  
  
  % 从Hq复制图像信息到Hp
  ind(Hp(toFill)) = ind(Hq(toFill));
  img(rows,cols,:) = ind2img(ind(rows,cols),origImg);  
 
end

inpaintedImg=img;

A=double(img0);
B=double(inpaintedImg);

Psnr=PSNR(A,B);