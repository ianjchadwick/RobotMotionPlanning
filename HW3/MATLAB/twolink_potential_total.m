%function [UTheta]=twolink_potential_total(thetaEval,world,potential)
%Compute the potential $U$ pulled back through the kinematic map of the two-link
%manipulator, i.e., $U(  Wp_ eff(vec17E ))$, where $U$ is defined as in Question 
%q:total-potential, and $  Wp_ eff( )$ is the position of the end effector in the
%world frame as a function of the joint angles $vec17E = _1\\ _2$.
function [UTheta]=twolink_potential_total(thetaEval,world,potential)

%Convert angles of twolink manipulator thetaEval to x coords, xEval
[xEval,~,~] = twolink_kinematicMap(thetaEval);

%Find the total potential U at xEval
UTheta = potential_total(xEval, world, potential);

end

