function [ex]=checkPixels(arr)
if (size(arr,1)~=2)
ME=MException('MyComponent:noSuchVariable','Input of pixels is incorrect. Try again and choose two pixels coordinates');
throw(ME);
end
end