function kuai=form_patch(rows,cols,z)

%知道块在图像中所占的行和列的范围，得到块中每个像素点在图像中的位置（第多少个像素）
%便于引用

numhang=length(rows);
numlie=length(cols);
HJ=zeros(numhang,numlie);
LJ=zeros(numhang,numlie);
for ii=1:numlie
    HJ(:,ii)=rows;%行铺成的矩阵
end
for jj=1:numhang
    LJ(jj,:)=cols;%列铺成的矩阵
end
kuai=(LJ-1)*z+HJ;%得到待修复块（在图像中的具体位置）