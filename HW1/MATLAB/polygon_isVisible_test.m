%function polygon_isVisible_test()
%This function should perform the following operations: enumerate  an array 
%testPoints with dimensions [ 2 $ $  5] containing points generated uniformly at
%random using rand and scaled to approximately occupy the rectangle $[0,5]
%[-2,2]$ (i.e., the $x$ coordinates of the points should fall between $0$ and
%$5$, while the $y$ coordinates between $-2$ and $2$).  the coordinates 
%vertices1 and  vertices2 of two polygons from twolink_polygons.  two  logical
%vectors  flag1 and  flag2 by calling polygon_isVisible using  testPoints and,
%respectively,  vertices1 and  vertices2 as argument. item:test-polygon For each
%polygon  vertices1,  vertices2, display a separate figure using the following:
%enumerate  the array  testPointsWithPolygon by concatenating  testPoints with
%the coordinates of the polygon (i.e., the coordinates of the polygon become also
%test points).  the polygon (use polygon_plot). item:test-visibility For each
%vertex $v$ in the polygon: enumerate  the visibility of each point in 
%testPointsWithPolygon with respect to that polygon (using polygon_isVisible). 
%lines from the vertex $v$ to each point in  testPointsPolygon according in green
%if the corresponding point is visible, and in red otherwise. enumerate enumerate
% the order of the vertices in  vertices1,  vertices2 using the function fliplr. 
%item item:test-polygon above with the reversed edges. enumerate
function polygon_isVisible_test()
xcoords = 0 + 5*rand(1,5);
ycoords = -2 + 4*rand(1,5);
testPoints = [xcoords ; ycoords];
[vertices1 vertices2] = twolink_polygons;

%First figure with vertices1
figure(1)

%create array with test points and vertices
testPointsWithPolygon = [vertices1 testPoints];

%Plot polygon
polygon_plot(vertices1, 'k');

numVertices = size(vertices1, 2);
numPoints = size(testPointsWithPolygon,2);

%create flag array
flags = zeros(1,numPoints);

%for each vertex, check to see if the points are visible with and mark
%the result in a flag array then use the flag array to draw the lines.
for iVertices = 1:numVertices
    
    flags = polygon_isVisible(vertices1, iVertices, testPointsWithPolygon);
    for iPoints = 1:numPoints
        plotLinesFlag(vertices1(:,iVertices), testPointsWithPolygon(:,iPoints), ~flags);
    end
end

%Second figure with vertices2
figure(2)

%create array with test points and vertices
testPointsWithPolygon = [vertices2 testPoints];

%Plot polygon
polygon_plot(vertices2, 'k');

numVertices = size(vertices2, 2);
numPoints = size(testPointsWithPolygon,2);

%create flag array
flags = zeros(1,numPoints);

%for each vertex, check to see if the points are visible with and mark
%the result in a flag array then use the flag array to draw the lines.
for iVertices = 1:numVertices
    
    flags = polygon_isVisible(vertices2, iVertices, testPointsWithPolygon);
    for iPoints = 1:numPoints
        plotLinesFlag(vertices2(:,iVertices), testPointsWithPolygon(:,iPoints), ~flags);
    end
end

%Third figure with flipped vertices1
figure(3)

%create array with test points and flipped vertices
flippedVertices1 = fliplr(vertices1);

testPointsWithPolygon = [flippedVertices1 testPoints];

%Plot polygon
polygon_plot(flippedVertices1, 'k');

numVertices = size(flippedVertices1, 2);
numPoints = size(testPointsWithPolygon,2);

%create flag array
flags = zeros(1,numPoints);

%for each vertex, check to see if the points are visible with and mark
%the result in a flag array then use the flag array to draw the lines.
for iVertices = 1:numVertices
    
    flags = polygon_isVisible(flippedVertices1, iVertices, testPointsWithPolygon);
    for iPoints = 1:numPoints
        plotLinesFlag(flippedVertices1(:,iVertices), testPointsWithPolygon(:,iPoints), ~flags);
    end
end

%Third figure with flipped vertices1
figure(4)

%create array with test points and flipped vertices
flippedVertices2 = fliplr(vertices2);

testPointsWithPolygon = [flippedVertices2 testPoints];

%Plot polygon
polygon_plot(flippedVertices2, 'k');

numVertices = size(flippedVertices2, 2);
numPoints = size(testPointsWithPolygon,2);

%create flag array
flags = zeros(1,numPoints);

%for each vertex, check to see if the points are visible with and mark
%the result in a flag array then use the flag array to draw the lines.
for iVertices = 1:numVertices
    
    flags = polygon_isVisible(flippedVertices2, iVertices, testPointsWithPolygon);
    for iPoints = 1:numPoints
        plotLinesFlag(flippedVertices2(:,iVertices), testPointsWithPolygon(:,iPoints), ~flags);
    end
end


%The function should display four separate figures in total, each one with a
%single polygon and lines from each vertex in the polygon, to each point.
