%function [flagTheta]=twolink_isCollision(theta,points)
%For each specified configuration, returns  true if  any of the links of the
%manipulator collides with  any of the points, and  false otherwise. Use the
%function polygon_isCollision to check if each link of the manipulator is in
%collision.
function [flagTheta]=twolink_isCollision(theta,points)

NTheta = size(theta,2);
NPoints = size(points,2);
flagTheta = zeros(1,NTheta);

%Create the vertices for the location of the transformed two link 
%manipulator for each theta in theta array
for thetaInd = 1:NTheta
    [effectorPos, vertices1Transf, vertices2Transf] = twolink_kinematicMap(theta(:,thetaInd));
    %Find all the points where there is a collision with the links in the
    %specified configuration
    flagVertices1 = polygon_isCollision(vertices1Transf, points);
    flagVertices2 = polygon_isCollision(vertices2Transf, points);

    %If either of the flagVertices arrays have a collision with any of the 
    %points mark the configuration in the flagTheta output array as having a collision (1).
    for pointInd=1:NPoints
        if flagVertices1(pointInd)
            flagTheta(thetaInd) = 1;
        elseif flagVertices2(pointInd)
            flagTheta(thetaInd) = 1;
        end
    end
    
    flagTheta = logical(flagTheta);
      
end
%For this question,  do not consider self-collision (i.e., if the two polygons
%overlap but they do not cover any of the points, then it is not a collision).
