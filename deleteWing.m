function [d] = deleteWing(grayAverage)
%% %%-visualization of function work
[maxIntVect, Ind]=max(grayAverage);
tmp=grayAverage; %copy of the full average
maxInt=max(maxIntVect);
grayAverage(grayAverage<0.85*maxInt)=0;
imshow(grayAverage);
wingEdge=im2uint8(edge(tmp,"sobel"));
imshow(wingEdge);
zeroWing=tmp-grayAverage-wingEdge;
imshow(zeroWing);
bin=imbinarize(zeroWing);%image before areaopen
imshow(bin);
clear=bwareafilt(bin,2);%image after areaopen
%%imshow(clear);
differ=logical(bin-clear);%logical types
imshow(differ);
zeroWing(find(differ))=0;
zeroWing=medfilt2(zeroWing, [6, 6]);
tmpmedfilt=medfilt2(tmp,[6, 6]);
d=tmpmedfilt-zeroWing;
imshow(d);
end