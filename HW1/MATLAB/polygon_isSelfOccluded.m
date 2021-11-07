%function [flagPoint]=polygon_isSelfOccluded(vertex,vertexPrev,vertexNext,point)
%Given the corner of a polygon, checks whether a given point is self-occluded or
%not by that polygon (i.e., if it is ``inside'' the corner's cone or not). Points
%on boundary (i.e., on one of the sides of the corner) are not considered
%self-occluded.  Note that to check self-occlusion from one vertex, knowing the
%two lines formed with the previous and next vertices (and their ordering) is
%sufficient.
function [flagPoint]=polygon_isSelfOccluded(vertex,vertexPrev,vertexNext,point)

%Error check to see if the vertex is different from the previous ane next
%vertices or if it's the same as the test point
prevVertexSame = (vertex(1,1) == vertexPrev(1,1) && vertex(2,1) == vertexPrev(2,1));
nextVertexSame = (vertex(1,1) == vertexNext(1,1) && vertex(2,1) == vertexNext(2,1));
testPointSame = (vertex(1,1) == point(1,1) && vertex(2,1) == point(2,1));

%Return NaN if prevVertex or nextVertex is the same
if  prevVertexSame || nextVertexSame
    flagPoint = NaN;
    return
end

%Check to see if the point is the same as the vertex and return false if it
%is
if testPointSame
    flagPoint = false;
    return
end

%Calculate the unsigned angle of the polygon and the unsigned angle of the
%angle made with the point and the vertex
polygonAngle = edge_angle(vertex, vertexPrev, vertexNext, 'unsigned');
pointAngle = edge_angle(vertex, point, vertexNext, 'unsigned');

%If the angle of the polygon is greater or equal to the angle formed with
%the point, it is not self-occluded and return false, otherwise it is self-
%occluded and return true.
if pointAngle <= polygonAngle
    flagPoint = false;
else
    flagPoint = true;
end

%Use the function edge_angle to check the angle between the segment  vertex--
%point and the segments  vertex-- vertexPrev and  vertex-- vertexNext. The
%function returns  NaN if  vertex1 or  vertex2 coincides with  vertex0.
