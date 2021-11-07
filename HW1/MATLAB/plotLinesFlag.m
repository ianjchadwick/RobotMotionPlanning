% plotLinesFlag (pointsStart, pointsEnd, flags)
%Plot lines going from pointsStart to pointsEnd that depends on flags. Each
%element in flag corresponds to a column in pointsStart and one in
%pointsEnd. If an element in flag is true, the corresponding line is
%plotted in red, if false it is plotted in green.

function plotLinesFlag(pointsStart, pointsEnd, flags)
numPoints = size(pointsStart,2);
hold on;

for iPoints = 1:numPoints
    if flags(1, iPoints)
        color = 'r';
    else
        color = 'g';
    end
    xCoords = [pointsStart(1, iPoints) pointsEnd(1,iPoints)];
    yCoords = [pointsStart(2, iPoints) pointsEnd(2, iPoints)];
    
    plot(xCoords, yCoords, color);
end
hold off;
