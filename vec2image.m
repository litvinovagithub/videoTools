function [im]=vec2image(vecCols, W,H)
number=size(vecCols,1);
images=zeros(W,H,number,'uint8');
vecCols=uint8(imag(vecCols));
for i=1:number
    for j=1:H
    images(:,j,i)=vecCols(i,(j-1)*W+1:j*W);
    end
imshow(uint8(images(:,:,i)'*10));
end
im=images;
end