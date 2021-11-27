%Maps an angle theta to a point on the circle S1 from a rotational matrix 
%and the unit vector [1;0]

function point=circle_phi(theta)
%get rotation matrix for theta
rotTheta = rot2d(theta);

%mutliply by unit vector and output circle
point = rotTheta*[1;0];
end