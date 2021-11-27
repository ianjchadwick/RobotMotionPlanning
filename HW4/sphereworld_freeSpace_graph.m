%function [graphVector]=sphereworld_freeSpace_graph(NCells)
%The function performs the following steps: enumerate  the file      Marker
%file_provided [sphereworld.mat]  @x   sphereworld.mat.  a structure  @x   grid
%with fields  @x   xx and  @x   yy, each one containing  @x   NCells values
%linearly spaced values from  @x   -10 to  @x   10.  the field  @x   grid.F
%following the format expected by grid2graph in Question  q:gridgraph, i.e., with
%a  @x   true if the space is free, and a  @x   false if the space is occupied by
%a sphere at the corresponding coordinates. The best way to manipulate the output
%of potential_total (for checking collisions with the spheres) while using it in
%conjunction with grid_eval (to evaluate the collisions along all the points on
%the grid); note that the choice of the attractive potential here does not
%matter.  grid2graph.  the resulting  @x   graphVector structure. enumerate
function [graphVector]=sphereworld_freeSpace_graph(NCells)

load("sphereworld.mat");

grid = grid_init(NCells);
potential = struct('xGoal', xGoal(:,2), 'shape', 'conic', 'repulsiveWeight', 0.01);

potHandle = @(xEval) potential_total(xEval, world, potential);

grid = grid_eval(grid,potHandle);

for idxRow=1:NCells
    for idxCol=1:NCells
        grid.F(idxRow,idxCol) = ~isnan(grid.F(idxRow,idxCol));
    end
end

graphVector = grid2graph(grid);

