function [f]=vidGraythreshAverage(grayVid)
sizeVid=size(grayVid);
arr=zeros(1,sizeVid(3));
for i=1:sizeVid(3)
arr(i)=graythresh(grayVid(:,:,i));
end
f=mean(arr);
end