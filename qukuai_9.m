function [Hp,rows,cols] = qukuai_9(sz, p, qukuai_size)
x = floor(rem(p,sz(1)));
y = floor(p/sz(1))+1;%得到待修复区域中心点所在的位置
w = floor(qukuai_size/2);%块的半径（9*9大小的块，块的半径为4）
rows = max(1,x-w):min(x+w,sz(1));
cols = max(1,y-w):min(y+w,sz(2));
numhang = length(rows);
numlie = length(cols);
HJ = zeros(numhang,numlie);
LJ = zeros(numhang,numlie);
for ii = 1:numlie
    HJ(:,ii) = rows;%行铺成的矩阵
end
for jj = 1:numhang
    LJ(jj,:) = cols;%列铺成的矩阵
end
Hp = (LJ-1)*sz(1)+HJ;%得到待修复块（在图像中的具体位置）