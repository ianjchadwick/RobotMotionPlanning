%function [grid_struct]=grid_eval(grid_struct,fun)
%This function evaluates the function fun (which should be a function handle) on
%each point defined by the grid.
function [grid_struct]=grid_eval(grid_struct,fun)

%get dimensions of the grid
szMesh=[length(grid_struct.xx) length(grid_struct.yy)];

%get output size of fun (at the origin, just as a test point)
szOutput=size(fun(zeros(2,1)),1);

%allocate output
funEvaluated=zeros([szMesh szOutput]);

%double for loop to evaluate the function
for iMesh=1:szMesh(1)
    for jMesh=1:szMesh(2)
        funEvaluated(iMesh,jMesh,:)=fun([grid_struct.xx(iMesh);grid_struct.yy(jMesh)]);
    end
end

grid_struct.F=funEvaluated;