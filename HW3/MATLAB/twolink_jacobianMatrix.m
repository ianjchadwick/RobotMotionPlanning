%function [Jtheta]=twolink_jacobianMatrix(theta)
%Compute the matrix representation of the Jacobian of the position of the end
%effector with respect to the joint angles as derived in Question 
%q:jacobian-matrix.
function [Jtheta]=twolink_jacobianMatrix(theta)
thetaOne = theta(1, 1);
thetaTwo = theta(2, 1);
Jtheta = [(-5*sin(thetaOne))-(5*sin(thetaOne + thetaTwo)), -5*sin(thetaOne + thetaTwo) ;  (5*cos(thetaOne)+5*cos(thetaOne + thetaTwo)), 5*cos(thetaOne + thetaTwo)];