function [I,vidHeight,vidWidth,vidFrameTimingStep,vidFrameRate,vidnumOfFrames]=vid2dmdMatrix(filename)
vid = VideoReader(filename);
vidWidth = vid.Width;
vidHeight = vid.Height;
vidFrameRate = vid.FrameRate;
vidFrameTimingStep=1/vidFrameRate;
period=0:vidFrameTimingStep:vid.Duration;
vidnumOfFrames = vid.NumFrames;
framesRange=[1,vidnumOfFrames];
frames = read(vid, framesRange);
frames=vid2gray(frames,vidHeight ,vidWidth, vidnumOfFrames );
framesImcomlement=imcomplement(frames);
intensFrameMatrx=zeros(vidHeight*vidWidth,vidnumOfFrames);
for i=1:vidnumOfFrames
    frame=frames(:,:,i);
    for j=1:vidHeight
     intensFrameMatrx((j-1)*vidWidth+1:j*vidWidth, i)=frame(j,:);
    end
end
I=intensFrameMatrx;
end