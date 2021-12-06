import numpy as np
import math


""" 
Create a node object with fields: 
node_id = integer
coords = list with x-y coordinates [x,y]
d_exit = manhattan distance to nearest exit. initialized at -1
safety = distance from a shooter location
neighbors = list of neighbors by node_id
"""
class Node:

    def __init__(self, node_id = 0, coords = [0,0]):
        self.node_id = node_id
        self.coords = coords
        self.d_exit = -1
        self.safety = 0
        self.neighbors = []


"""
Create a 'size' x 'size' square ndarray with ones to represent free space and zeros for the spaces blocked by obstacles.
The x-axis is the vertical axis and the y-axis is the horizontal axis.
Obstacles are represented as a list of tuples where each 'obstacle' tuple is composed of the top left starting 
coodinate and the length in the x and y directions [ [x,y], xLength, yLength]
Output is a an array representation of a grid where 1s represent free space and 0s are spaces blocked by obstacles
"""
def grid_construct(size, obstacles):
    grid = np.ones([size, size], dtype=int)

    for obstacle in obstacles:
        xStart = obstacle[0][0]
        yStart = obstacle[0][1]
        xLength = obstacle[1]
        yLength = obstacle[2]

        for x in range(xStart, xStart+xLength):
            for y in range(yStart, yStart+yLength):
                grid[x][y] = 0

    return grid


"""Uses a grid where 1s are free space and 0s are blocked spaces to create a list of nodes for each free space where 
the node_id-1 is the list index for that node and to replace the 1s in the grid with the number of the node_id that 
represents that space.
Output: the modified grid and a list of nodes representing the free space"""
def node_construct(grid):
    size = len(grid)
    nodeNum = 1

    nodeList = []

    for x in range(0,size):
        for y in range(0,size):
            if grid[x][y] == 1:
                grid[x][y] = nodeNum
                node = Node(nodeNum, [x,y])
                nodeList.append(node)
                nodeNum = nodeNum +1
    return [grid, nodeList]


# For testing purposes
if __name__ == "__main__":

    obstacles = [[[1, 1], 1, 2], [[1,1], 2, 1]]

    grid = grid_construct(4, obstacles)
    print(grid)
    [grid2, nodeList] = node_construct(grid)
    print(grid2)
    print(nodeList[2].node_id)