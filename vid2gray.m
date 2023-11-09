function [v]=vid2gray(vid, H, W, Lon)
sizeVid=size(vid);
vidUINT8= zeros(H,W,Lon, 'uint8');
for i=1:sizeVid(4)
vidUINT8(:,:,i)=im2gray(vid(:,:,1,i));
end
v=vidUINT8;
end