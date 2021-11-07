%function [dPointsSphere]=sphere_distance(sphere,points)
%Computes the signed distance between points and the sphere, while taking into
%account whether the sphere is hollow or filled in.
function [dPointsSphere]=sphere_distance(sphere,points)

%Remember that the radius of the sphere is negative for hollow spheres

%Get number of points
pointsNum = size(points,2);
dPointsSphere = zeros(1,pointsNum);

center = sphere.xCenter;
centerX1 = center(1,1);
centerX2 = center(2,1);
radius = abs(sphere.radius);
radiusSign = sign(sphere.radius);

%Find distance between point and circle for each point 
for iPoints = 1:pointsNum
    pointX1 = points(1,iPoints);
    pointX2 = points(2,iPoints);
    
    %Find the distance between the sphere edge and the point and store in
    %in the array
    dist = sqrt((pointX1-centerX1)^2 + (pointX2-centerX2)^2) - radius;
    
    %Check to see if the point is inside obstacle and make distance
    %negative if it is and positive otherwise
    distSign = sign(dist);
    
    if radiusSign ~= distSign
        if distSign > 0
            dist = dist*-1;
        end
    else
        dist = abs(dist);
    end
    
    dPointsSphere(1, iPoints) = dist;
    
end
