%function [pQueue]=priority_insert(pQueue,key,cost)
%Add an element to the queue.
function [pQueue]=priority_insert(pQueue,key,cost)
Qlength = size(pQueue,1);

pQueue(Qlength+1,1).key = key;
pQueue(Qlength+1,1).cost = cost;
