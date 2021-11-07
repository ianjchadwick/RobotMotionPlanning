%function [flagPoints]=polygon_isVisible(vertices,indexVertex,testPoints)
%Checks whether a point $p$ is visible from a vertex $v$ of a polygon. In order
%to be visible, two conditions need to be satisfied: enumerate  point $p$ should
%not be self-occluded with respect to the vertex $v$\\ (see
%polygon_isSelfOccluded).  segment $p$--$v$ should not collide with  any of the
%edges of the polygon (see edge_isCollision). enumerate
function [flagPoints]=polygon_isVisible(vertices,indexVertex,testPoints)

%Initialize variables and starting arrays
testPointLength = size(testPoints,2);
numVertices = size(vertices,2);
cornerVertex = vertices(:,indexVertex);
flagPoints = ones(1,testPointLength);

%Initialize a new vertices vector with the first point concatenated onto
%the end to prevent indexing errors
wrappedVertices = [vertices vertices(:, 1)];

%Initialize variables to use for self-occlusion tests to find the previous
%and next vertices
if indexVertex == 1
    prevVertex = vertices(:,numVertices); 
else
    prevVertex = vertices(:, indexVertex-1);
end

if indexVertex == numVertices
    nextVertex = vertices(:,1); 
else
    nextVertex = vertices(:, indexVertex+1);
end

%For each test point check to see if it is self-occluded, or if it results
%in a collision with any edge
for itestP = 1:testPointLength
    point = testPoints(:, itestP);
    
    %create an edge to represent the line from the point to the vertex
    pointVertexVect = [point cornerVertex];
    
    %check the test point to input vertex edge against each edge of the
    %polygon for a collison
    for iCollisionTest = 1:numVertices
        testEdge = [wrappedVertices(:, iCollisionTest) wrappedVertices(:, iCollisionTest+1)];
        collision = edge_isCollision(testEdge, pointVertexVect);
        
        %If a collision is detected, update the flagPoints array to false
        %for that point's index
        if collision
            flagPoints(1, itestP) = false;
        end
    end
    
    %Then check to see if the point is self-occluded from the test vertex
    occluded = polygon_isSelfOccluded(cornerVertex, prevVertex, nextVertex, point);
    
    %If self-occluded, update the flagPoints arrat to false for that
    %point's index
    if occluded
       flagPoints(1, itestP) = false;
    end
end


%Note that, with the definitions of edge collision and self-occlusion given in
%the previous questions, a vertex should be visible from the previous and
%following vertices in the polygon.
