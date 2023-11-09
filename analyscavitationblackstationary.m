function [p__,l__,vidFrameTimingStep,coef]=analyscavitationblackstationary(filename)
vid = VideoReader(filename);
absoluteSpace=1.215; % in mm
vidWidth = vid.Width;
vidHeight = vid.Height;
cavityMaxLenStep=round(vidWidth*0.8);
vidFrameRate = vid.FrameRate;
vidFrameTimingStep=1/vidFrameRate;
period=0:vidFrameTimingStep:vid.Duration;
vidnumOfFrames = vid.NumFrames;
cuvetLen=zeros(1,vidnumOfFrames);
framesRange=[1,vidnumOfFrames];
frames = read(vid, framesRange);
frames=vid2gray(frames);
framesImcomlement=imcomplement(frames);
framesImcomlement=uint8(framesImcomlement);
tmpGray=mean(framesImcomlement,3);
tmpGray=uint8(tmpGray);
imshow(tmpGray);
title('Press "Enter" and click on TWO extreme points of the wing chord, press enter to confirm select');
pause;
[wingLenX, wingLenY,~]=impixel(tmpGray);
% wingLenX=[1087;609];
% wingLenY=[93;275];
checkPixels(wingLenY);
chordLenMM=input('Input length of the wing chord in mm:');%y
chordLenPxls=sqrt((wingLenX(1)-wingLenX(2))^2+(wingLenY(1)-wingLenY(2))^2);
space=round(chordLenPxls*absoluteSpace/chordLenMM); %space in pixels
coef=chordLenMM/chordLenPxls;
% %  coef=0.1444;
% %  space=round(absoluteSpace/coef);
imshow(tmpGray);%veryimportant
title('Press "Enter" and click on ONE start pixel of the cavity growth, press enter to confirm select');
pause;
[startX, startY,~]=impixel(tmpGray);
%  startX=151;
%  startY=86;
framesImcomlement(1:250,1:startX,:)=0;
tmpGray(1:250,1:startX)=0;
% % % % framesImcomlement(135:250,1:852,:)=0;
% % % % tmpGray(135:250,1:852)=0;
% % % framesImcomlement(1:250,1:startX,:)=0;
% % % tmpGray(1:250,1:startX)=0;
% % % framesImcomlement(170:250,1:852,:)=0;
% % % tmpGray(170:250,1:852)=0;
% % % framesImcomlement(1:100,1:852,:)=0;
% % % tmpGray(1:100,1:852)=0;
thresholdIntensityOfAll=vidGraythreshAverage(framesImcomlement);
%framesImcomlement(0:startX,,:)=0;
findWing=deleteWing(tmpGray);
 for i=1:vidnumOfFrames
 frame = framesImcomlement(:,:,i);
 filtFrame=medfilt2(frame,[6,6]);
 finalFrame=filtFrame-findWing;
 finalFrame=uint8(finalFrame);
 finalFrame=imbinarize(finalFrame,thresholdIntensityOfAll);
 %imshow(finalFrame);
 finalFrame1=finalFrame;
 lineX=0;
 lineY=0;

 %%организовать массив контура нижнего
 secondX=zeros(1,1000);
 secondY=zeros(1,1000);
 coord=zeros(1000,2);
 coord(1,:)=[startY, startX];
 secondX(1)=startX;
 secondY(1)=startY;
 count=0;
 for k=2:cavityMaxLenStep
 secondX(k)=startX+k;
 [rowOnly, ~]=find(finalFrame(:,secondX(k))>0);%[rowOnly, ~]=find(CavitationBound(:,secondX(k))==1);
 if (isempty(rowOnly)) 
     count=count+1; 
     if (count==space)
         break; 
     end 
 else 
     secondY(k)=max(rowOnly);
     coord(k,:)=[secondY(k),secondX(k)];
%       if (i==537) finalFrame(secondY(k),secondX(k),1)=1;%важный окмментарий
%       imshow(finalFrame);     end                %важный комментарий 
 end
 end
 dopX=nonzeros(coord(:,2));%ненулевое значение x
 indxDop=find(coord(:,2));%индекс ненулевого x
 dopY=coord(indxDop(:,1),1);%у соотв ненулевому х
 [dopY,bubbleIndx]=bubbleFilter(dopY,dopX,space);
 dopX=dopX(1:bubbleIndx,1);
 sizeDopX=size(dopX);
 helpY=dopY';
 helpX=dopX';
%  for u=1:sizeDopX(1)
%  finalFrame(helpY(u),helpX(u),1)=255;% finalFrame(helpy,helpx,1)=255;
%  end
 lengthlast=0;
 x1=dopX(1,1);
 y1=dopY(1,1);
 x2=dopX(end);
 y2=dopY(end);
if (abs(x1-x2)>0)
 [~,~,cuvetLen(i)] =rangeLine(x1,y1,x2,y2);
end 
 if (i>921&&i<935)
    imshowpair(finalFrame, frames(:,:,i),'montage');
    imshowpair(finalFrame, frames(:,:,i)); 
    line([x2,x1],[y2,y1],'Color','red');
 end
  end
p__=1:1:vidnumOfFrames;
l__=cuvetLen;
end