function kuai=form_patch(rows,cols,z)

%֪������ͼ������ռ���к��еķ�Χ���õ�����ÿ�����ص���ͼ���е�λ�ã��ڶ��ٸ����أ�
%��������

numhang=length(rows);
numlie=length(cols);
HJ=zeros(numhang,numlie);
LJ=zeros(numhang,numlie);
for ii=1:numlie
    HJ(:,ii)=rows;%���̳ɵľ���
end
for jj=1:numhang
    LJ(jj,:)=cols;%���̳ɵľ���
end
kuai=(LJ-1)*z+HJ;%�õ����޸��飨��ͼ���еľ���λ�ã�