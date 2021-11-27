%function [vertexEffectorDot]=twolink_jacobian(theta,thetaDot)
%Implement the map for the Jacobian of the position of the end effector with
%respect to the joint angles as derived in Question  q:jacobian-effector.
function [vertexEffectorDot]=twolink_jacobian(theta,thetaDot)
NTheta = size(theta,2);

vertexEffectorDot = zeros(2, NTheta);

for indTheta=1:NTheta
    thetaOne = theta(1, indTheta);
    thetaTwo = theta(2, indTheta);
    
    jacobian = [(-5*sin(thetaOne))-(5*sin(thetaOne + thetaTwo)), -5*sin(thetaOne + thetaTwo) ;  (5*cos(thetaOne)+5*cos(thetaOne + thetaTwo)), 5*cos(thetaOne + thetaTwo)];
    
    vertexEffectorDot(:,indTheta) = jacobian*thetaDot(:,indTheta);
       
    
end

end
