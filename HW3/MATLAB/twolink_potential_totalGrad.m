%function [gradUTheta]=twolink_potential_totalGrad(thetaEval,world,potential)
%Compute the gradient of the potential $U$ pulled back through the kinematic map
%of the two-link manipulator, i.e., $ _vec17E  U(  Wp_ eff(vec17E ))$.
function [gradUTheta]=twolink_potential_totalGrad(thetaEval,world,potential)

%Convert angles of twolink manipulator thetaEval to x coords, xEval
[xEval,~,~] = twolink_kinematicMap(thetaEval);

%Get the transposed Jacobian matrix for thetaEval
jacobian = twolink_jacobianMatrix(thetaEval)';


%Find the total potential gradient at xEval
gradUTheta = jacobian*potential_totalGrad(xEval,world,potential);