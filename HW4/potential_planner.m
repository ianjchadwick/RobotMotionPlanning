%function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)
%This function uses a given control field (@boxIvory2 plannerParameters.control)
%to implement a generic potential-based planner with step size @boxIvory2
%plannerParameters.epsilon, and evaluates the cost along the returned path. The
%planner must stop when either the number of steps given by @boxIvory2
%plannerParameters.NSteps is reached, or when the norm of the vector given by
%@boxIvory2 plannerParameters.control is less than $10^-3$ (equivalently,
%@boxIvory2 1e-3).
function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)

%Total numer of allowed steps
NSteps = plannerParameters.NSteps;
%Initialize var to track number of steps taken
stepCount = 1;
%Intialize var to check if goal is reached
goalThreshold = 5e-3;
%Initialize step size and xGoal
epsilon = plannerParameters.epsilon;
xGoal = potential.xGoal;
%Intiailize arrays
xPath = zeros(2,NSteps);
xPath(:,1) = xStart;
UPath = zeros(1,NSteps);

%Create function handle for the potential function evaluated at each xPath
%beginning with xStart
UPotenFunc = plannerParameters.U;
UPath(:,1) = UPotenFunc(xStart,world,potential);

%Create control function handle to determine where planner should move
controlCurrent = plannerParameters.control;

%Loop until allowed number of steps is reached
while stepCount < NSteps
    
    %Determine distance from current location to goal
    currentDist = norm(xPath(:,stepCount) - xGoal);
    
    %If we're close enough already, the next step and U are NaN, else calculate
    %next step in xPath and U at that location.
    if currentDist <= goalThreshold
        xPath(:,stepCount+1) = NaN;
        UPath(:,stepCount+1) = NaN;
    else
        xPath(:,stepCount+1) = xPath(:,stepCount)+ epsilon*controlCurrent(xPath(:,stepCount),world,potential);
        UPath(:,stepCount+1) = UPotenFunc(xPath(:,stepCount+1),world,potential);
    end
    %Increment the step counter
   stepCount = stepCount+1;
end

end




