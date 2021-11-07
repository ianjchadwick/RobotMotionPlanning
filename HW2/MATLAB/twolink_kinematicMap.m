%function [vertexEffectorTransf,vertices1Transf,vertices2Transf]=twolink_kinematicMap(theta)
%The function returns the coordinate of the end effector, plus the vertices of
%the links, all transformed according to $ _1, _2$.
function [vertexEffectorTransf,vertices1Transf,vertices2Transf]=twolink_kinematicMap(theta)
%Get values from input
theta1 = theta(1,1);
theta2 = theta(2,1);

%generate initial vertices for two-link manipulator
[vertices1, vertices2] = twolink_polygons();


%Rotation matrix B1 in reference to world
wR_B1 = rot2d(theta1);

%Rotation matrix B2 in reference to world
wR_B2 = rot2d(theta2);

vertices1Transf = wR_B1*vertices1;

vertices2Transf = wR_B1*wR_B2*vertices2 + wR_B1*[5 ; 0];

vertexEffectorTransf = wR_B1*wR_B2*[5 ; 0] + wR_B1*[5 ; 0];

end



%Use the results from Question  q:kinematicMapDerivation to guide your
%implementation. This function must use twolink_polygons to obtain the vertices
%of the polygons of the matrix, and it must use rot2d from Question  q:rot2d.
%Note that here we are simply computing the vertices of the transformed polygons,
%without plotting them. The next function will be used to plot the transformed
%vertices.
