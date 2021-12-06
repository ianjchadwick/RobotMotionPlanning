%function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
%This function expands the vertex with index  @x   idxX (which is a neighbor of
%the one with index  @x   idxNBest) and returns the updated versions of  @x  
%graphVector and  @x   pqOpen.
function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
    % Get values and lists from NBest node
    gNBest = graphVector(idxNBest).g;
    NNBest = graphVector(idxNBest).neighbors;
    NcostNBest = graphVector(idxNBest).neighborsCost;
    
    % Find the index of key X in neighbors list to get cost from cost list
    Nidx = 0;
    for idx=1:size(NNBest)
        if NNBest(idx) == idxX
            Nidx = idx;
        end
    end
    % Use that index to get the cost to move to x from the neighborCost list
    cost = NcostNBest(Nidx);
    
    % Check to see if the node is a not member of the priorityQueue and add
    % it to the queue with updated values for g and backpointer.
    if  ~priority_isMember(pqOpen, idxX)
        % Set cost
        graphVector(idxX).g = gNBest + cost;
        % Set backpointer
        graphVector(idxX).backpointer = idxNBest;
        % Calculate f(x) = h(x) + g(x)
        priority = graph_heuristic(graphVector,idxX,idxGoal) + graphVector(idxX).g;
        % Insert into Queue with priority f(x)
        pqOpen = priority_insert(pqOpen, idxX, priority);
    % Otherwise if it is already in the Queue and the cost to move there is
    % less than the current g(x) at x, update the cost and backpointer for
    % x
    elseif (gNBest + cost) < graphVector(idxX).g
        graphVector(idxX).g = cost + gNBest;
        graphVector(idxX).backpointer = idxNBest;
    end 
end

%This function corresponds to lines  it:expansion-start-- it:expansion-end in
%Algorithm  alg:astar.
