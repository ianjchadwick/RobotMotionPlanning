%function [flag]=edge_isCollision(vertices1,vertices2)
%Returns  true if the two edges intesect.  Note: if the two edges overlap but are
%colinear, or they overlap only at a single endpoint, they are not considered as
%intersecting (i.e., in these cases the function returns  false). If one of the
%two edges has zero length, the function should always return the result that
%edges are non-intersecting.

%I found a really good explanation on how to approach the problem at this
%website which I used to help make my function: https://matlabgeeks.com/tips-tutorials/computational-geometry/find-intersection-of-two-lines-in-matlab/
function [flag]=edge_isCollision(vertices1,vertices2)
%Initialize variables
flag = false;
pointP = vertices1(:,1);
vectorR = vertices1(:,2) - pointP;
pointQ = vertices2(:,1);
vectorS = vertices2(:,2) - pointQ;

%Error Check to ensure that the R and S vectors are not 0 vectors
nonzeroR = (vectorR(1,1) ~= 0 || vectorR(2,1) ~=0);
nonzeroS = (vectorS(1,1) ~= 0 || vectorS(2,1) ~=0);


if nonzeroR && nonzeroS
    %Find the values of the 2D-cross products r x s, (q-p) x s and (q-p) x r
    r_cross_s = cross2(vectorR,vectorS);
    q_p_cross_s = cross2((pointQ-pointP),vectorS);
    q_p_cross_r = cross2((pointQ-pointP),vectorR);

    %Solve for the parameters of the lines
    paramT = q_p_cross_s/r_cross_s;
    paramU = q_p_cross_r/r_cross_s;

    %if the cross product of r x s is 0, they don't intersect
    if r_cross_s ~= 0
        
        %if t and u are both in the interval [0,1] then they intersect at
        %the point p + t*r
        intervalofT = (paramT>=0) && (paramT<=1);
        intervalofU = (paramU>=0) && (paramU<=1);
        
        if intervalofT && intervalofU
        intersection = pointP + paramT*vectorR;
        
        %Check to see if the intersection is at the end points of either
        %segment if they are return the false flag, otherwise change the
        %flag to true.
        EqualToP1 = (vertices1(1,1) == intersection(1,1)) && (vertices1(2,1) == intersection(2,1));
        EqualtoP2 = (vertices1(1,2) == intersection(1,1)) && (vertices1(2,2) == intersection(2,1));
        EqualtoQ1 = (vertices2(1,1) == intersection(1,1)) && (vertices2(2,1) == intersection(2,1));
        EqualtoQ2 = (vertices2(1,2) == intersection(1,1)) && (vertices2(2,2) == intersection(2,1));
        
        if EqualToP1
            return
        elseif EqualtoP2
            return
        elseif EqualtoQ1
            return
        elseif EqualtoQ2
            return
        else
            flag = true;
         end
        end
    end
end

%Helper function to find the 2-D cross product of two vectors V and W given
%as Vx*Wy - Vy*Wx where V and W are column vectors with X,Y coordinates
function vectorZ = cross2(vectorV,vectorW)
    vectorZ = (vectorV(1,1)*vectorW(2,1))-(vectorV(2,1)*vectorW(1,1));
    
%The function should be able to handle any orientation of the edges (including
%both vertical and horizontal). Note that the ``overlap'' case needs to be
%checked up to floating-point precision.
