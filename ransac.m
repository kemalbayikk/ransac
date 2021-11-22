function ransacFunction(pointNumber,totalTry)
xRandoms = randi(pointNumber,pointNumber,1);
yRandoms = randi(pointNumber,pointNumber,1);
plot(xRandoms(:),yRandoms(:),'r.');
hold on;
minDist1 = 0;
minDist1X1 = 0;
minDist1X2 = 0;
minDist1Y1 = 0;
minDist1Y2 = 0;

minDist2 = 0;
minDist2X1 = 0;
minDist2X2 = 0;
minDist2Y1 = 0;
minDist2Y2 = 0;

minDist3 = 0;
minDist3X1 = 0;
minDist3X2 = 0;
minDist3Y1 = 0;
minDist3Y2 = 0;
%TÜM NOKTALAR BELİRLENDİ
for n = 1:totalTry
randomPointOne = randi(pointNumber,1,1);
randomPointSecond = randi(pointNumber,1,1);
while randomPointOne == randomPointSecond
    randomPointOne = randi(pointNumber,1,1);
    randomPointSecond = randi(pointNumber,1,1);
end
%RANDOM X VE Y İNDEKSLERİ İLE DOĞRU OLUŞTURMAK İÇİN İKİ TANE NOKTA
%BELİRLENDİ
dist = 0.0;
sumDist = 0.0;
if n == 1
    for i = 1:pointNumber
        dist = findDistance(xRandoms(i),xRandoms(randomPointOne),xRandoms(randomPointSecond),yRandoms(i),yRandoms(randomPointOne),yRandoms(randomPointSecond));
        sumDist = sumDist + dist;
    end
    minDist1 = sumDist;
    minDist1X1 = xRandoms(randomPointOne);
    minDist1X2 = xRandoms(randomPointSecond);
    minDist1Y1 = yRandoms(randomPointOne);
    minDist1Y2 = yRandoms(randomPointSecond);
elseif n == 2
    for i = 1:pointNumber
        dist = findDistance(xRandoms(i),xRandoms(randomPointOne),xRandoms(randomPointSecond),yRandoms(i),yRandoms(randomPointOne),yRandoms(randomPointSecond));
        sumDist = sumDist + dist;
    end
    while sumDist == minDist1
        for i = 1:pointNumber
            dist = findDistance(xRandoms(i),xRandoms(randomPointOne),xRandoms(randomPointSecond),yRandoms(i),yRandoms(randomPointOne),yRandoms(randomPointSecond));
            sumDist = sumDist + dist;
        end
    end
    minDist2 = sumDist;
    minDist2X1 = xRandoms(randomPointOne);
    minDist2X2 = xRandoms(randomPointSecond);
    minDist2Y1 = yRandoms(randomPointOne);
    minDist2Y2 = yRandoms(randomPointSecond);
elseif n == 3
    for i = 1:pointNumber
        dist = findDistance(xRandoms(i),xRandoms(randomPointOne),xRandoms(randomPointSecond),yRandoms(i),yRandoms(randomPointOne),yRandoms(randomPointSecond));
        sumDist = sumDist + dist;
    end
    while sumDist == minDist1 || sumDist == minDist2
        for i = 1:pointNumber
            dist = findDistance(xRandoms(i),xRandoms(randomPointOne),xRandoms(randomPointSecond),yRandoms(i),yRandoms(randomPointOne),yRandoms(randomPointSecond));
            sumDist = sumDist + dist;
        end
    end
    minDist3 = sumDist;
    minDist3X1 = xRandoms(randomPointOne);
    minDist3X2 = xRandoms(randomPointSecond);
    minDist3Y1 = yRandoms(randomPointOne);
    minDist3Y2 = yRandoms(randomPointSecond);
else
    for i = 1:pointNumber
            dist = findDistance(xRandoms(i),xRandoms(randomPointOne),xRandoms(randomPointSecond),yRandoms(i),yRandoms(randomPointOne),yRandoms(randomPointSecond));
            sumDist = sumDist + dist;
    end
    if sumDist < minDist1
        minDist1 = sumDist;
        minDist1X1 = xRandoms(randomPointOne);
        minDist1X2 = xRandoms(randomPointSecond);
        minDist1Y1 = yRandoms(randomPointOne);
        minDist1Y2 = yRandoms(randomPointSecond);
    elseif sumDist < minDist2  && sumDist ~= minDist1
        minDist2 = sumDist;
        minDist2X1 = xRandoms(randomPointOne);
        minDist2X2 = xRandoms(randomPointSecond);
        minDist2Y1 = yRandoms(randomPointOne);
        minDist2Y2 = yRandoms(randomPointSecond);
    elseif sumDist < minDist3 && sumDist ~= minDist2 && sumDist ~= minDist1
        minDist3 = sumDist;
        minDist3X1 = xRandoms(randomPointOne);
        minDist3X2 = xRandoms(randomPointSecond);
        minDist3Y1 = yRandoms(randomPointOne);
        minDist3Y2 = yRandoms(randomPointSecond);
    end
end
end
slopeLineOne = findSlope(minDist1X1,minDist1X2,minDist1Y1,minDist1Y2);
yInterceptLineOne = findyIntercept(minDist1X1,minDist1Y1,slopeLineOne);

slopeLineTwo = findSlope(minDist2X1,minDist2X2,minDist2Y1,minDist2Y2);
yInterceptLineTwo = findyIntercept(minDist2X1,minDist2Y1,slopeLineTwo);

slopeLineThree = findSlope(minDist3X1,minDist3X2,minDist3Y1,minDist3Y2);
yInterceptLineThree = findyIntercept(minDist3X1,minDist3Y1,slopeLineThree);


title("blue line slope = "+slopeLineOne+" blue line y-intercept = "+yInterceptLineOne+"    red line slope = "+slopeLineTwo+" red line y-intercept = "+yInterceptLineTwo+"    black line slope = "+slopeLineThree+" black line y-intercept = "+yInterceptLineThree  );

plot([minDist1X1 minDist1X2],[minDist1Y1 minDist1Y2],'color','blue');
plot([minDist2X1 minDist2X2],[minDist2Y1 minDist2Y2],'color','red');
plot([minDist3X1 minDist3X2],[minDist3Y1 minDist3Y2],'color','black');

disp("blue line slope = "+slopeLineOne+" blue line y-intercept = "+yInterceptLineOne+"    red line slope = "+slopeLineTwo+" red line y-intercept = "+yInterceptLineTwo+"    black line slope = "+slopeLineThree+" black line y-intercept = "+yInterceptLineThree  )
end


function distance = findDistance(x0,x1,x2,y0,y1,y2)
    distance = abs((x2-x1)*(y1-y0) - (x1-x0)*(y2-y1)) / sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
end

function slope = findSlope(x1,x2,y1,y2)
    slope = (y2-y1) / (x2-x1);
end

function y_intercept = findyIntercept(x1,y1,slope)
    b = y1 - x1*slope;
    y_intercept = b;
end