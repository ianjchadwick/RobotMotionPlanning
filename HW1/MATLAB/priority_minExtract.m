%function [pQueue,key,cost]=priority_minExtract(pQueue)
%Extract the element with minimum cost from the queue.
function [pQueue,key,cost]=priority_minExtract(pQueue)
Qlength = size(pQueue,1);
Qempty = ((Qlength == 0) || ((size(pQueue,2) == 0)));

%if the Queue is empty return
if Qempty
    [];
%     pQueue = [];
%     key = [];
%     cost = [];
    return

%If there is only one element in the Queue, return that.
elseif Qlength == 1
    key = pQueue(1).key;
    cost = pQueue(1).cost;
    pQueue(1) = [];
    return

% Otherwise search the whole Queue for the smallest element and return the
% key and cost associated with those and remove that element.
else
    %Start with the first element's cost and index
    minIndex = 1;
    minCost = pQueue(1).cost;
    %Compare cost to cost of each other element and update the cost and
    %index to the new element if the cost is less
    for index = 1:Qlength
        if pQueue(index).cost < minCost
            minIndex = index;
            minCost = pQueue(index).cost;
        end
    end
    
    %Return the and remove the lowest cost element
    key = pQueue(minIndex).key;
    cost = pQueue(minIndex).cost;
    pQueue(minIndex) = [];
end