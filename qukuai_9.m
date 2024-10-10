function [Hp,rows,cols] = qukuai_9(sz, p, qukuai_size)
x = floor(rem(p,sz(1)));
y = floor(p/sz(1))+1;%�õ����޸��������ĵ����ڵ�λ��
w = floor(qukuai_size/2);%��İ뾶��9*9��С�Ŀ飬��İ뾶Ϊ4��
rows = max(1,x-w):min(x+w,sz(1));
cols = max(1,y-w):min(y+w,sz(2));
numhang = length(rows);
numlie = length(cols);
HJ = zeros(numhang,numlie);
LJ = zeros(numhang,numlie);
for ii = 1:numlie
    HJ(:,ii) = rows;%���̳ɵľ���
end
for jj = 1:numhang
    LJ(jj,:) = cols;%���̳ɵľ���
end
Hp = (LJ-1)*sz(1)+HJ;%�õ����޸��飨��ͼ���еľ���λ�ã�