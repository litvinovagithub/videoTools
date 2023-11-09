clear all;   
%[period1,len1]=analyscavitation('Q5.6f36P60.avi');
[period2,len2,~,coef]=analyscavitationblackstationary('smooth41Hz_fin.avi');
plot(period2,len2);
periodLen=size(period2,2);
dur=periodLen/20000;
N=periodLen; 
x=1:1:periodLen;
meanLen=mean(len2);
mass=zeros(1,periodLen);
len1=len2;
t=0:dur/N:dur;% 1/5000 = 0,0002 and dur 0,25 => 0,25 / 0,0002 = 1250
sss=size(len1);%sig=readmatrix('length.mat');
%fourier transform
F=fft(len1);
F=F(1:(N/2+1));
F=abs(F);
F_x=0:1:N/2;
subplot(3,1,2);
plot(F_x/dur,F/dur/N*2);
% axis([0 dur 0 max(len1)]);
subplot(3,1,1);
plot((1:1:periodLen)*0.00005,len2*coef,'r-');%Отрисовка исходной функции
axis([0 dur 0 max(len1)*coef]);
subplot(3,1,3);
medium_=len1;
medium_(medium_==0)=[];
plot(x*0.00005,len1*coef,'b-');
axis([0 dur 0 max(medium_)*coef]);
%axis([0 5000*0.00005 0 80]);
Mean1=mean(medium_);