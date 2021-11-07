%function [flag] = polygon_isFilled(vertices)
%Boolean which takes an array of X,Y coordinates (vertices) and uses the equation
%(X2-X1)*(Y2+Y1) and sums up the values. If the value is greater than zero
%then returns 'false' for Clockwise and ' true' for Counter-Clockwise if otherwise.
%Credit to
%https://www.element84.com/blog/determining-the-winding-of-a-polygon-given-as-a-set-of-ordered-points
%for explanation

function [flag]= polygon_isFilled (vertices)
numberOfVertices = length(vertices);
edgeValue = 0;
for i = 1:(numberOfVertices - 1)
     edgeValue = edgeValue + ((vertices(1,i+1)-vertices(1,i))*(vertices(2,i+1)+(vertices(2,i))));
end
    edgeValue = edgeValue + ((vertices(1,1)-vertices(1,numberOfVertices))*(vertices(2,1)+vertices(2,numberOfVertices)));
    
if edgeValue>0
    flag = false;
else
    flag = true;
end
