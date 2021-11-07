%function [flagPoints]=polygon_isCollision(vertices,testPoints)
%Checks whether the a point is in collsion with a polygon (that is, inside for a
%filled in polygon, and outside for a hollow polygon).
function [flagPoints]=polygon_isCollision(vertices,testPoints)

%Intialize variables and arrays
numVertices = size(vertices,2);
numPoints = size(testPoints,2);
minVertX = vertices(1,1);
maxVertX = vertices(1,1);
minVertY = vertices(1,2);
maxVertY = vertices(1,2);
intersectCount = 0;

%find minimum and maximum x-value of all vertices
for iVert = 1:numVertices
    if minVertX > vertices(1,iVert)
        minVertX = vertices(1,iVert);
    end
    if maxVertX < vertices(1,iVert)
        maxVertX = vertices(1,iVert);
    end
end

%find minimum and maximum y-value of all vertices
for iVert = 1:vertices
    if minVertY > vertices(2,iVert)
        minVertY = vertices(2,iVert);
    end
    if maxVertY < vertices(2,iVert)
        maxVertY = vertices(2,iVert);
    end
end

insidePoints = zeros(1,numPoints);
%Initialize a new vertices vector with the first point concatenated onto
%the end to prevent indexing errors
wrappedVertices = [vertices vertices(:, 1)];


for iPoints = 1:numPoints
    
    point = testPoints(:, iPoints);
    %simulate an infinite ray from the point to the right by creating a
    %line segment from the point to another point with the same Y value at 
    %maxVertX+1
    pointMax = [maxVertX+1 ; point(2,1)];
    pointRay = [point pointMax];
    
    %Checks to see if either the x or y coordinate of the point is outside
    %the maximum or minimum x or y coordinate of all of the vertices. If
    %so, then the point cannot be inside the polygon.
    notOutsideXflag = ~(testPoints(1,iPoints) < minVertX) || (testPoints(1,iPoints) > maxVertX);
    notOutsideYflag = ~(testPoints(2,iPoints) < minVertY) || (testPoints(2,iPoints) > maxVertY);

    if notOutsideXflag || notOutsideYflag
        for iCollisionTest = 1:numVertices
            testEdge = [wrappedVertices(:, iCollisionTest) wrappedVertices(:, iCollisionTest+1)];
            collision = edge_isCollision(testEdge, pointRay);
            intersectCount = intersectCount + collision;
        end
        
        %check to see if number of collisions is even and if it is, then
        %the point is outside the polygon
        isEven = (mod(intersectCount, 2) == 0);
        
        if isEven
            insidePoints(1,iPoints) = false;
        else
            insidePoints(1,iPoints) = true;
        end
    else
        insidePoints(1,iPoints) = false;
    end
    
end

    %Check to see if it's a filled or hollow polygon
    isFilled = polygon_isFilled(vertices);
    
    %If it's filled flip invert insidePoints otherwise return
    %insidePoints as is
    if isFilled
        flagPoints = insidePoints;
    else
        for iInsidePoints = 1:numPoints
            flagPoints(1,iInsidePoints) = ~insidePoints(1,iInsidePoints);
        end
    end
