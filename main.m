im=imread("manor.png");
im=rgb2gray(im);
% gp=makeGaussianPyramid(im,7);
% lp=makeLaplacianPyramid(gp);
% %plotting Gaussian Pyramid
% maxX=size(gp{1},2)+size(gp{2},2);
% maxY=1024;
% figure(1);
% pos=[0,0,size(gp{1},2)/maxX,size(gp{1},1)/maxY];
% y=1;
% h=0;
% subplot('Position',pos);
% imshow(gp{1});
% title(['Scale= ',num2str(1)]);
% annotation('textbox',[.05 0.8 .3 .2],'String','Press any key','EdgeColor','none')
% for i=2:7
%     x=pos(1)+pos(3);
%     h=size(gp{i},1)/maxY;
%     y=y-h;
%     
%     w=size(gp{i},2)/maxX;
%     pos1=[x,y,w,h];
%     subplot('Position',pos1);
%     imshow(gp{i});
%     title(['Scale= ',num2str(2^(i-1))]);
% end
% pause;
% close all
% 
% % plotting laplacian pyramid
% figure(2);
% pos=[0,0,size(lp{1},2)/maxX,size(lp{1},1)/maxY];
% y=1;
% h=0;
% subplot('Position',pos);
% imshow(lp{1},[]);
% title(['Scale= ',num2str(1)]);
% annotation('textbox',[.05 0.8 .3 .2],'String','Press any key','EdgeColor','none')
% for i=2:6
%     x=pos(1)+pos(3);
%     h=size(lp{i},1)/maxY;
%     y=y-h;
%     w=size(lp{i},2)/maxX;
%     pos1=[x,y,w,h];
%     subplot('Position',pos1);
%     imshow(lp{i},[]);
%     title(['Scale= ',num2str(2^(i-1))]);
% end
% pause;
% close all
% % Q3 Find keypoints 
% keyPoints=findKeyPoints(lp,5,3);
% numberKeyPoints = size(keyPoints);
% numberKeyPoints = numberKeyPoints(1);
% disp(numberKeyPoints);
% figure(10);
% imshow(im);
% annotation('textbox',[.60 .8 .3 .2],'String','Press any key to continue','EdgeColor','none')
% title('SIFT Key-Points');
% hold on;
% drawCircles(keyPoints);
% 
% hold off;
% pause;
% close all;
% %choosing a random keypoint to show its gradient magnitude,orientation and
% %gaussian weighted magnitude
% randompt=randi([1,size(keyPoints,1)]);
% [patch,gx,gy,gm,go,gwm]=getGradients(gp,keyPoints(randompt,:),17);
% figure(3);
% subplot(2,2,1);
% imshow(patch);
% title("17 x 17 patch");
% subplot(2,2,2);
% imshow(gm,[]);
% title("Gradient Magnitude");
% annotation('textbox',[.40 .8 .3 .2],'String','Press any key to continue','EdgeColor','none')
% subplot(2,2,3);
% imshow(gwm,[]);
% title("Gaussian Weighted Gradient Magnitude");
% [X,Y]=meshgrid(1:size(gm,1),1:size(gm,2));
% subplot(2,2,4);
% quiver(X,Y,gx,gy);
% title("Gradient Orientation");
% pause;
% close all;
% %Get Sift Vectors and plot Histograms
% [histogram,siftvectors]=getSiftFeatures(gp,keyPoints,17,36);
% figure(3);
% subplot(1,2,1);
% 
% bar(histogram(randompt,:));
% title("histogram of orientations");
% annotation('textbox',[.60 .8 .3 .2],'String','Press any key to continue','EdgeColor','none');
% subplot(1,2,2);
% bar(siftvectors(randompt,4:end));
% title("Shifted histogram of orientations");
% 
% pause;
% close all;
% normalizedsiftVectors=normalizeHist(siftvectors);
%Q6 and 7 taking an ROI in the image, applying transformations to it followed by
%feature matching for three different transformations
offset1=[12,12];
% offset2=[5,5];
center=round(size(im)/2);
X0=500;
Y0=500;
thetas=[5,12];
scales=[1.05,0.85];
for i=1:numel(thetas)
    X0=center(2)-offset1(2);
    Y0=center(1)-offset1(1);
    theta=thetas(i);
    s=scales(i);
    newImg=transImg(im,X0,Y0,theta,s);
    figure(12);
    subplot(1,2,1);
    imshow(im);
    hold on;
    plot(Y0,X0,'*g');
    title("Original Image");
    subplot(1,2,2);
    imshow(newImg);
    hold on;
    plot(Y0,X0,'*g');
    title(['rotation= ',num2str(theta),'degree',', Scaling=',num2str(s)]);
    pause;
    close all;
    roisize=512;
    threshold=0.85;
    matchOutput=featureMatching(im,newImg,X0,Y0,roisize,threshold);
end
  



