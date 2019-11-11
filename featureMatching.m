function matchOutput=featureMatching(img1,img2,x0,y0,roisize,threshold)

rect=[x0-floor(roisize/2),y0-floor(roisize/2),roisize-1,roisize-1];

cropimg1=imcrop(img1,rect);
cropimg2=imcrop(img2,rect);

gp1=makeGaussianPyramid(cropimg1,7);
gp2=makeGaussianPyramid(cropimg2,7);
lp1=makeLaplacianPyramid(gp1);
lp2=makeLaplacianPyramid(gp2);
keyPoints1=findKeyPoints(lp1,5,2);
keyPoints2=findKeyPoints(lp2,5,2);
matchOutput=zeros(size(keyPoints1,1),2);
[~,siftVectors1]=getSiftFeatures(gp1,keyPoints1,17,36);
[~,siftVectors2]=getSiftFeatures(gp2,keyPoints2,17,36);
normalizedsiftVectors1=normalizeHist(siftVectors1);
normalizedsiftVectors2=normalizeHist(siftVectors2);
localArea=150;
for i =1:size(keyPoints1,1)
    maxVal=-5;
    bestMatch=0;
    for j=1:size(keyPoints2,1)
        if abs(keyPoints2(j,1)-keyPoints1(i,1))<=floor(localArea/2) && abs(keyPoints2(j,2)-keyPoints1(i,2))<=floor(localArea/2)
            corr=bhattacharya(normalizedsiftVectors1(i,4:end),normalizedsiftVectors2(j,4:end));
            if corr>=maxVal
                maxVal=corr;
                bestMatch=j;
            end
        end
    end
    if maxVal>=threshold
        matchOutput(i,1)=bestMatch;
        matchOutput(i,2)=maxVal;
    end
end
keyPoints2(:,1)=keyPoints2(:,1)+size(cropimg2,2);
figure(20);
imgfinal=[cropimg1,cropimg2];
% montage([cropimg1,cropimg2]);
imshow(imgfinal);
hold on;

drawCircles(keyPoints1);
drawCircles(keyPoints2);
drawLines(keyPoints1,keyPoints2,matchOutput);
title("Matched Features");
annotation('textbox',[.60 .8 .3 .2],'String','Press any key to continue','EdgeColor','none')
hold off;
pause;
close all;
            
        