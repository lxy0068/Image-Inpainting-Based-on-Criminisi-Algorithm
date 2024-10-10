
%**************************************************************************
%全局搜索，寻找最佳匹配块(彩色图像)
%全局搜索过程中不会出现找不到最佳匹配块的情况
%**************************************************************************


function Block=whole_match(zx,zy,img,Wpatch,fillColor)
%zx,zy为图像的大小

aa=size(Wpatch,1);
bb=size(Wpatch,2);%得到的待修复块的实际大小

sx=zx-aa+1;
sy=zy-bb+1;%确定搜索范围的最大值

all=aa*bb;%一维的大小
min=1.0000e+10;%赋初值

%计算找到的匹配块与待修复块在已知像素点处的距离（只是已知像素点）
for i=1:sx
    for j=1:sy
        Mpatch=img(i:i+aa-1,j:j+bb-1,:);%得到图像中和待修复块同样大小的块(Match patch)
        posunme=Mpatch(:,:,1)==fillColor(1)&Mpatch(:,:,2)==fillColor(2)&Mpatch(:,:,3)==fillColor(3);
        if any(posunme(:))%说明有破损点，不作为待修复块的最佳匹配块
            continue;
        end
        Err=0;
        for gg=1:aa*bb
            %遍历块中的每一个像素点
            pf=Wpatch(gg)==fillColor(1)&Wpatch(gg+all)==fillColor(2)&Wpatch(gg+2*all)==fillColor(3);
            if pf   %说明该位置像素有破损，不参与距离的计算
                continue;
            end
                cha=Wpatch(gg)-Mpatch(gg);Err=Err+cha*cha;
                 cha=Wpatch(gg+all)-Mpatch(gg+all);Err=Err+cha*cha;
                  cha=Wpatch(gg+2*all)-Mpatch(gg+2*all);Err=Err+cha*cha;
        end
        if Err<min
            min=Err;%取使得误差最小的块，并记住它们在图像中的起始位置
            hk=i;
            lk=j;
        end
    end
end
rows=hk:hk+aa-1;
cols=lk:lk+bb-1;%误差最小的块就是最佳匹配块 
Block=form_patch(rows,cols,zx);