
%**************************************************************************
%ȫ��������Ѱ�����ƥ���(��ɫͼ��)
%ȫ�����������в�������Ҳ������ƥ�������
%**************************************************************************


function Block=whole_match(zx,zy,img,Wpatch,fillColor)
%zx,zyΪͼ��Ĵ�С

aa=size(Wpatch,1);
bb=size(Wpatch,2);%�õ��Ĵ��޸����ʵ�ʴ�С

sx=zx-aa+1;
sy=zy-bb+1;%ȷ��������Χ�����ֵ

all=aa*bb;%һά�Ĵ�С
min=1.0000e+10;%����ֵ

%�����ҵ���ƥ�������޸�������֪���ص㴦�ľ��루ֻ����֪���ص㣩
for i=1:sx
    for j=1:sy
        Mpatch=img(i:i+aa-1,j:j+bb-1,:);%�õ�ͼ���кʹ��޸���ͬ����С�Ŀ�(Match patch)
        posunme=Mpatch(:,:,1)==fillColor(1)&Mpatch(:,:,2)==fillColor(2)&Mpatch(:,:,3)==fillColor(3);
        if any(posunme(:))%˵��������㣬����Ϊ���޸�������ƥ���
            continue;
        end
        Err=0;
        for gg=1:aa*bb
            %�������е�ÿһ�����ص�
            pf=Wpatch(gg)==fillColor(1)&Wpatch(gg+all)==fillColor(2)&Wpatch(gg+2*all)==fillColor(3);
            if pf   %˵����λ�����������𣬲��������ļ���
                continue;
            end
                cha=Wpatch(gg)-Mpatch(gg);Err=Err+cha*cha;
                 cha=Wpatch(gg+all)-Mpatch(gg+all);Err=Err+cha*cha;
                  cha=Wpatch(gg+2*all)-Mpatch(gg+2*all);Err=Err+cha*cha;
        end
        if Err<min
            min=Err;%ȡʹ�������С�Ŀ飬����ס������ͼ���е���ʼλ��
            hk=i;
            lk=j;
        end
    end
end
rows=hk:hk+aa-1;
cols=lk:lk+bb-1;%�����С�Ŀ�������ƥ��� 
Block=form_patch(rows,cols,zx);