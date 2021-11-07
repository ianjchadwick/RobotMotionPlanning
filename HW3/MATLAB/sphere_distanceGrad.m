%function [gradDPointsSphere]=sphere_distanceGrad(sphere,points)
%Computes the gradient of the signed distance between points and the sphere,
%consistently with the definition of sphere_distance.
function [gradDPointsSphere]=sphere_distanceGrad(sphere,points)

numPoints = size(points, 2);
gradDPointsSphere = zeros(2,numPoints);
gradSign = sign(sphere.radius);

%Find center of sphere and signed distance from sphere for each point
sphereCenter = sphere.xCenter;

%Insert the gradient into array gradDPointsSphere Using the equation
%Del dSphere = (point-center)/distance(center,point).
for iPoints = 1:numPoints
    if points(:,iPoints) == sphereCenter
        gradDPointsSphere(:,iPoints) = [0;0];
    else
        gradDPointsSphere(:,iPoints) = gradSign*(points(:,iPoints) - sphereCenter)/norm(sphereCenter - points(:,iPoints));
    end
end
