%function [xPath]=graph_path(graphVector,idxStart,idxGoal)
%This function follows the backpointers from the node with index  @x   idxGoal in
% @x   graphVector to the one with index  @x   idxStart node, and returns the 
%coordinates (not indexes) of the sequence of traversed elements.
function [xPath]=graph_path(graphVector,idxStart,idxGoal)

% Initialize with the goal node x-coords and backpointer
nodeX = graphVector(idxGoal).x;
xPath = nodeX;
nodeBP = graphVector(idxGoal).backpointer;

% Step through each backpointer until start node is reached
while (nodeBP ~= idxStart)
    nodeX = graphVector(nodeBP).x;
    xPath(:,size(xPath,2) + 1) = nodeX;
    nodeBP = graphVector(nodeBP).backpointer;
end

% Add the start node to xPath
nodeX = graphVector(nodeBP).x;
xPath(:,size(xPath,2) + 1) = nodeX;
nodeBP = graphVector(nodeBP).backpointer;

% Reverse xPath to show start->goal ordering
xPath = fliplr(xPath);

end

