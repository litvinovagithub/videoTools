clear all;
close all;
filename='D:\work_matlab\bubblesSpeedJet\Q7.6f46P145cut_edit_cb.avi';
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
for i=1:framesNumber
imwrite(frames(:,:,i),'framesQ7.6f46P145cut_edit_cb', 'bmp');
end