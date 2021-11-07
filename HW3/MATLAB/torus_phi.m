%function [xTorus]=torus_phi(theta)
%Implements equation    @  (  eq:chartTorus \@@italiccorr ).
function [xTorus]=torus_phi(theta)
%get the length of the input
NTheta = size(theta,2);
xTorus = zeros(3,NTheta);

for thetaInd=1:NTheta
    %Get theta1 and theta2 for current theta index
    thetaOne = theta(1,thetaInd);
    thetaTwo = theta(2,thetaInd);
    
    %create block diagnal matrix with 2D rotational matrix from theta one
    diag = blkdiag(rot2d(thetaTwo),1);
    
    xTorus(:,thetaInd)=diag*([1 0;0 0;0 1]*circle_phi(thetaOne) + [3;0;0]);
end
end