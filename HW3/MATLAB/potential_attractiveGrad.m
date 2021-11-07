%function [gradUAttr]=potential_attractiveGrad(xEval,potential)
%Evaluate the gradient of the attractive potential $ U_ attr$ at a point  xEval.
%The gradient is given by the formula If  potential.shape is equal to  'conic',
%use $p=1$. If  potential.shape is equal to  'quadratic', use $p=2$.
function [gradUAttr]=potential_attractiveGrad(xEval,potential)

shape = potential.shape;
xGoal = potential.xGoal;
pointX1 = xEval(1,1);
pointX2 = xEval(2,1);


distance = sqrt((pointX1- xGoal(1,1))^2 + (pointX2- xGoal(2,1))^2);

if strcmp(shape,'conic')
    if xEval == xGoal
        gradUAttr = 0;
    else
        gradUAttr = (xEval - xGoal)/distance;
    end
elseif strcmp(shape,'quadratic')
    gradUAttr = 2*(xEval - xGoal);
end