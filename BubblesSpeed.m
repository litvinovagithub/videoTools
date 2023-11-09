clear all;
close all;
filename='D:\work_matlab\bubblesSpeedJet\Q7.6f46P145cut.avi';
vid = VideoReader(filename);
vidWidth = vid.Width;
vidHeight = vid.Height;
vidFrameRate = vid.FrameRate;
vidFrameTimingStep=1/vidFrameRate;
period=0:vidFrameTimingStep:vid.Duration;
vidnumOfFrames = vid.NumFrames;
framesRange=[1,vidnumOfFrames];
framesNumber=framesRange(2);
frames = read(vid, framesRange);
frames=vid2gray(frames,vidHeight ,vidWidth, vidnumOfFrames );
framesImcomlement=imcomplement(frames);
for i=2:framesNumber
binFrame=imbinarize(framesImcomlement(:,:,i));
%imshow(binFrame);
tmp=bwareafilt(binFrame,[0, 30]);
bw=binFrame-tmp;
imshow(framesImcomlement(:,:,i)-framesImcomlement(:,:,i-1));

end