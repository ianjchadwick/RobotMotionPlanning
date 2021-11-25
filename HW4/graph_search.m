%function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)
%Implements the  @x   A* algorithm, as described by the pseudo-code in Algorithm 
%alg:astar.
function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)

% Set a maximum limit of iterations in the main  @x   A* loop on line 
%it:astar-main-loop of Algorithm  alg:astar. This will prevent the algorithm from
%remaining stuck on malformed graphs (e.g., graphs containing a node as a
%neighbor of itself), or if you make some mistake during development.
