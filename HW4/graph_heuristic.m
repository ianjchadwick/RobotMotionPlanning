%function [hVal]=graph_heuristic(graphVector,idxX,idxGoal)
%Computes the heuristic  @x   h given by the Euclidean distance between the nodes
%with indexes  @x   idxX and  @x   idxGoal.
function [hVal]=graph_heuristic(graphVector,idxX,idxGoal)

%Get X1 and X2 values for the start node X and the goal node
x1Node = graphVector(idxX).x(1,1);
x2Node = graphVector(idxX).x(2,1);
x1Goal = graphVector(idxGoal).x(1,1);
x2Goal = graphVector(idxGoal).x(2,1);

%Use distance formula to calculate the distance between them.
hVal = sqrt((x1Node-x1Goal)^2 + (x2Node - x2Goal)^2);
end





