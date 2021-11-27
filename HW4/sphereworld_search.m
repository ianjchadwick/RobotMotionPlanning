%function sphereworld_search(NCells)
%enumerate  the variables  @x   xStart,  @x   xGoal from      Marker
%file_provided [sphereworld.mat]  @x   sphereworld.mat  each of the three values
%for  @x   NCells: enumerate  the function sphereworld_freeSpace_graph for the
%given value of  @x   NCell.  each goal in  @x   xGoal: enumerate 
%graph_search_startGoal from every starting location in  @x   xStart to that
%goal.  the world using sphereworld_plot, together with the resulting
%trajectories. enumerate enumerate enumerate
function sphereworld_search(NCells)

load("sphereworld.mat");

graph = sphereworld_freeSpace_graph(NCells);
colorList = ['b', 'g', 'r', 'c', 'm'];
hold on
sphereworld_plot(world,xGoal);
for idxGoal=1:2
    for idxStart=1:5
        xPath = graph_search_startGoal(graph, xStart(:,idxStart), xGoal(:,idxGoal));
        plot(xPath(1,:),xPath(2,:),colorList(idxStart))
    end
end


%In total, this function should produce six different images (three choices for 
%@x   NCell times two goals).
