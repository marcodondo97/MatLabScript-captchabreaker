function [s] = Generate()
%generete 5 integers random captcha number
x = randi([10000 99999]);
% generate white image 50x150
A = 255 * ones(50, 150, 'uint8');

%create image adding text, noise and line with low contrast
YourText = string(x);
A= imnoise(A,'salt & pepper',1);
figure('visible','off');
imshow(A);
line([ 1, 150;],[ 30, 30],'Color','yellow','LineWidth',6)
hText = text(40,25,YourText,'Color',[1 1 1],'FontSize',18);
hFrame = getframe(gca)
%save image
imwrite(hFrame.cdata,'StrongCaptcha.png','png')
close all;

%chek if the image has been generated succesfully
otherFullFileName = fullfile( 'StrongCaptcha.png')
if isfile(otherFullFileName)
    s=1;
else
    s=0;
end
end
