%function twolink_freeSpaceGraph()
%The function performs the following steps enumerate  the contents of  @x  
%twolink_freeSpace_data.mat.  grid2graph.  the resulting  @x   vectorGraph struct
%array in the file  @x   twolink_freeSpace_graph.mat. enumerate
function twolink_freeSpaceGraph()

load("twolink_freeSpace_data.mat", "grid")

vectorGraph = grid2graph(grid)

save("twolink_freeSpace_Graph.mat",'vectorGraph');