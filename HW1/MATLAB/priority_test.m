%function priority_test()
% A function to test the functionality of pQueue functions. This function
% intializes an empty queue, adds 3 elements to the queue, extracts the
% minimum element, adds another element, checks to see if an element is
% present and finally removes all elements with repeated extractions. The
% function priority_print prints the contents of the queue after each step.
function priority_test()
%Initialize Queue
priorityQ = priority_prepare;
priority_print(priorityQ);

'Insert Oranges, 4.5'
priorityQ = priority_insert(priorityQ, 'Oranges', 4.5);
priority_print(priorityQ);

'Insert Apples, 1'
priorityQ = priority_insert(priorityQ, 'Apples', 1);
priority_print(priorityQ);

'Insert Bananas, 2.7'
priorityQ = priority_insert(priorityQ, 'Bananas', 2.7);
priority_print(priorityQ);

'Extract Min'
[priorityQ, extractKey, extractCost] = priority_minExtract(priorityQ)
priority_print(priorityQ);

'Insert Canaloupe, 3'
priorityQ = priority_insert(priorityQ, 'Cantaloupe', 3);
priority_print(priorityQ);

'Is Oranges a member?'
member = priority_isMember(priorityQ, 'Oranges')

'Extracting remaining contents'
%Extracts contents until the queue is empty
while(size(priorityQ,2)~=0)
    [priorityQ extractKey extractCost] = priority_minExtract(priorityQ)
    priority_print(priorityQ);
end

%function priority_print()
%Helper function to print the contents of the priority queue to the console.
function priority_print(pQueue)
    QLen = size(pQueue,1);
    'Queue Contents:'
    %error check to make sure queue is not empty
    if (QLen == 0) || (size(pQueue, 2) == 0)
       pQueue
       return;
    else
        %prints contents of each index of the queue
        for Qindex = 1:QLen
            pQueue(Qindex)
        end
    end
    
