%function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)
%Implements the  @x   A* algorithm, as described by the pseudo-code in Algorithm 
%alg:astar.
function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)

% Initialize priority queue, closed node list, and values for start node
pqOpen = priority_prepare();
idxClosed = [];
graphVector(idxStart).backpointer = [];
graphVector(idxStart).g = 0;
%Add start node to the queue
pqOpen = priority_insert(pqOpen,idxStart,0);
idxExpand = [];

while ~isempty(pqOpen)
    [pqOpen, idxNBest, ~] = priority_minExtract(pqOpen);
    idxClosed(size(idxClosed,2)+1) = idxNBest;
    
    if idxNBest == idxGoal
        break;
    end
    
    idxExpand = graph_getExpandList(graphVector, idxNBest, idxClosed);
    sizeExpand = size(idxExpand,1);
    
    for idx=1:sizeExpand
        [graphVector, pqOpen] = graph_expandElement(graphVector, idxNBest,idxExpand(idx,1), idxGoal, pqOpen);     
    end
    
end

xPath = graph_path(graphVector, idxStart, idxGoal);




% Set a maximum limit of iterations in the main  @x   A* loop on line 
%it:astar-main-loop of Algorithm  alg:astar. This will prevent the algorithm from
%remaining stuck on malformed graphs (e.g., graphs containing a node as a
%neighbor of itself), or if you make some mistake during development.
