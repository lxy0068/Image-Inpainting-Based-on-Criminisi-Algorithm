%----------------------------------------------------------------------
%PSNR÷µ¥Û–°
%-------------------------------------------------------------------------
function PSNR=PSNR(u,v)
[m,n]=size(u(:,:,1));
a=0;
for i=1:m
    for j=1:n
         t(i,j,1)=u(i,j,1)-v(i,j,1);
         a=a+t(i,j,1)^2;
    end
end
mse=a/(m*n);
PSNR_R=10*log10(255^2/mse);

b=0;
for i=1:m
    for j=1:n
         t(i,j,2)=u(i,j,2)-v(i,j,2);
         b=b+t(i,j,2)^2;
    end
end
mse=b/(m*n);
PSNR_G=10*log10(255^2/mse);

c=0;
for i=1:m
    for j=1:n
         t(i,j,3)=u(i,j,3)-v(i,j,3);
         c=c+t(i,j,3)^2;
    end
end
mse=c/(m*n);
PSNR_B=10*log10(255^2/mse);

PSNR=(PSNR_R+PSNR_G+PSNR_B)/3;