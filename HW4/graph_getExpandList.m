%function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)
%Finds the neighbors of element  @x   idxNBest that are not in  @x   idxClosed
%(line  it:expansion in Algorithm  alg:astar).
function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)

%Get the input node's neighbors and the size of the array
nodeNeighbors = graphVector(idxNBest).neighbors;
nNeighbors = size(nodeNeighbors,1);

%Inidialize list to hold nodes
idxExpand = [];

%Check each neighbor against the list idxClosed and if not already in the
%list, add them to the idxExpand list
for iNeighbor=1:nNeighbors
    
    %Get next neighbor in list
    neighbor = nodeNeighbors(iNeighbor,1);
    
    %Check to see if it's in closed list and if not add it to output list
    if ~ismember(neighbor, idxClosed)
        currentSize = size(idxExpand,1);
        idxExpand(currentSize+1,1) = neighbor;
    end
end

    
%Ensure that the vector  @x   idxBest is not included in the list of neighbors
%(i.e., avoid self-loop edges in the graph).
