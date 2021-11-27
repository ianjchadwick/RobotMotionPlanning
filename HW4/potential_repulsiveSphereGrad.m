%function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)
%Compute the gradient of $U_ rep$ for a single sphere, as given by    @  ( 
%eq:repulsive-gradient \@@italiccorr ).
function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)

%This function must use the outputs of sphere_distanceSphere.

%Get Dinfluence from the sphere struct
distInfluence = sphere.distInfluence;

%Calculate the distance between point and sphere
dist = sphere_distance(sphere, xEval);

%Calculate the distance gradient
distGrad = sphere_distanceGrad(sphere, xEval);

%variable to represent case 1: 0 < dist(x) < distInfluence 
firstCase = (dist > 0) && (distInfluence > dist);

if firstCase
    gradURep = -1*(1/dist - 1/distInfluence)*distGrad/dist^2;
elseif dist > distInfluence
    gradURep = [0;0];
else
    gradURep = NaN;
end