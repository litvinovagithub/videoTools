function [p__,l__,vidFrameTimingStep]=analyscavitationstationary(filename)
vid = VideoReader(filename);
range_pix=7;
x1=0;
x2=0;
y2=0;
y1=0;
vidWidth = vid.Width;
vidHeight = vid.Height;
vidFrameRate = vid.FrameRate;
vidFrameTimingStep=1/vidFrameRate;
period=0:vidFrameTimingStep:vid.Duration;
vidnumOfFrames = vid.NumFrames;
sumFrame = zeros(vidHeight,vidWidth,3);
lengthFull=zeros(1,vidnumOfFrames);
cuvetLen=zeros(1,vidnumOfFrames);
framesRange=[1,vidnumOfFrames];
frames = read(vid, framesRange);
framesImcomlement=imcomplement(frames);
tmp=sum(framesImcomlement,4)/vidnumOfFrames;
tmpGray=im2gray(uint8(tmp));
imshow(tmpGray);
[startX, startY,~]=impixel(tmpGray);
findWing=deleteWing(tmpGray);%вообще то здесь findwing
 for i=1:vidnumOfFrames
 frame = imcomplement(frames(:,:,:,i));
%  [x1,y1,p]=impixel(frame);
%  [x2,y2,p]=impixel(frame);
 filtFrame=medfilt2(im2gray(frame),[6,6]);
 finalFrame=filtFrame-findWing;
 finalFrame=uint8(finalFrame);
 finalFrame1=finalFrame;
 finalFrame=im2gray(finalFrame);
 
 %start_pixels=finalFrame(375:390,96:104,1);
% indxStartPixels=find(start_pixels>5);
 %isStart=size(indxStartPixels); 
 lineX=0;
 lineY=0;
 %if  (isStart(1)>16||((i>1) && lengthFull(i-1)~=0)) % все таки надо конец после имшоу
 

 %%организовать массив контура нижнего
 secondX=zeros(1,1000);
 secondY=zeros(1,1000);
 coord=zeros(1000,2);
 coord(1,:)=[startY, startX];
 secondX(1)=startX;
 secondY(1)=startY;
 count=0;
 for k=2:900
 secondX(k)=startX+k;
 [rowOnly, ~]=find(finalFrame(:,secondX(k))>5);%[rowOnly, ~]=find(CavitationBound(:,secondX(k))==1);
 if (isempty(rowOnly)) 
     count=count+1; 
     if (count==15)
         break; 
     end 
 else 
     secondY(k)=max(rowOnly);
     coord(k,:)=[secondY(k),secondX(k)];
%       if (i==2829) finalFrame(secondY(k),secondX(k),1)=255;%важный окмментарий
%       imshow(finalFrame);     end                %важный комментарий 
 end
 end
 dopX=nonzeros(coord(:,2));%ненулевое значение x
 indxDop=find(coord(:,2));%индекс ненулевого x
 dopY=coord(indxDop(:,1),1);%у соотв ненулевому х
 [dopY,bubbleIndx]=bubbleFilter(dopY);
 dopX=dopX(1:bubbleIndx,1);
 sizeDopX=size(dopX);
 helpY=dopY';
 helpX=dopX';
 for u=1:sizeDopX(1)
 finalFrame(helpY(u),helpX(u),1)=255;% finalFrame(helpy,helpx,1)=255;
 end
 lengthlast=0;
 x1=dopX(1,1);
 y1=dopY(1,1);
 x2=dopX(end);
 y2=dopY(end);
if (abs(x1-x2)>0)
 [~,~,cuvetLen(i)] =rangeLine(x1,y1,x2,y2);
end 
%  end% if условие самое длинное
%  RI = imref2d(size(finalFrame)); 
%  RI.XWorldLimits=[0, 16];
%  RI.YWorldLimits=[0, 8];
 %subplot('Position',[0.1, 0.5, 0.75, 0.4]);
 imshow(finalFrame);%imshowpair(CavitationBound,finalFrame,RI); %важный комментарий
 %if (i==385)% if (i>1688&& i<1980)

 line([x2,x1],[y2,y1]);

% end 
% % %  len=size(cuvetLen);
% % %  shotrate=1:1:len(2);%ОЧ ВАЖНЫЙ КОММ ИЗ ТРЕХ %%
% % %  subplot('Position',[0.1, 0.15, 0.75, 0.2]);
% % %  plot(shotrate,cuvetLen);
  end
p__=1:1:5001;
l__=cuvetLen;
end