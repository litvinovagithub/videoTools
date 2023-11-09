function [f,funCol]=bubbleFilter(arrY,arrX,coef)
arrY=arrY';
arrX=arrX';
i=1;
size1=size(arrY);
funCol=size1(2);
difArr=abs(diff(arrY));
[~,col]=find(difArr>coef);
pointMass=[arrX; arrY];
s=size(col,2);
if (~isempty(col)) 
   while(~isempty(col))
   x= [arrX(1,col(i));arrY(1,col(i))]';
   aloneMass=pointMass;
   aloneMass(:,1:col(i))=[];
   aloneMass=aloneMass';
   [D,I] = pdist2(aloneMass,x,'euclidean','Smallest',2); 
   if (round(D(1,1))<coef)
   nearPxl=aloneMass(I(1,1),:);
   [~,num]=find(pointMass(1,:)==nearPxl(1,1));
  if (~isempty(find(col<num+1,1)))
      col(col<num+1)=[];
  end
       continue;
   else
            funCol=col(i);
       break;
    end
   
   end
    
    newArr=arrY(1:funCol);
    f=newArr';
 
else
  f=arrY';
  
end
end
% function [f,funcol]=bubbleFilter(arrY,arrX,coef)
% arrY=arrY';
% size1=size(arrY);
% funcol=size1(2);
% difarr=abs(diff(arrY));
% [~,col]=find(difarr>coef);
% if (~isempty(col)) 
%     funcol=col(1);
%     newArr=arrY(1:col(1));
%     f=newArr';
%  
% else
%   f=arrY';
%   
% end
% end