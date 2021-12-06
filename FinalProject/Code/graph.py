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
Obstacles are represented as a list of tuples where each 'obstacle' tuple is composed of the top left starting 
coodinate and the length in the x and y directions [ [x,y], xLength, yLength] 
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

# For testing purposes
if __name__ == "__main__":

    obstacles = [[[1, 1], 1, 2], [[1,1], 2, 1]]

    grid = grid_construct(4, obstacles)

    print(grid)