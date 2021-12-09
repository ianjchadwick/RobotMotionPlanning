import sys
import numpy as np
import collections


""" 
Create a node object with fields: 
node_id = integer
coords = list with x-y coordinates [x,y]
d_exit = manhattan distance to nearest exit. initialized at maxsize
safety = distance from a shooter location
neighbors = list of neighbors by node_id
cost = g(x) movement cost from "moves so far"
"""
class Node:
    def __init__(self, node_id = int(), coords = [int(), int()]):
        self.node_id = node_id
        self.coords = coords
        self.d_exit = sys.maxsize
        self.safety = sys.maxsize
        self.neighbors = []
        self.cost = 0
        self.backpointer = int()


"""
Implement a Queue for wavefront algorithm
"""
class Queue:
    def __init__(self):
        self.elements = collections.deque()

    def empty(self) -> bool:
        return not self.elements

    def enque(self, x):
        self.elements.append(x)

    def pop(self):
        return self.elements.popleft()




def shooter_wavefront(nodeList, shooter_locations=list[int()]):
    for shooter in shooter_locations:
        Q = Queue()
        nodeList[shooter-1].safety = 0
        Q.enque(shooter)
        closed = []
        while not Q.empty():
            n = Q.pop()
            closed.append(n)
            wavefront = nodeList[n-1].safety + 1

            for neighbor in nodeList[n-1].neighbors:
                if neighbor not in closed:
                    if nodeList[neighbor-1].safety > wavefront:
                        nodeList[neighbor - 1].safety = wavefront
                    Q.enque(neighbor)


"""
Inputs: size of grid, list describing obstacle location and dimension
Output: grid with 1s representing free space and 0 for blocked spaces

Create a 'size' x 'size' square ndarray with ones to represent free space and zeros for the spaces blocked by obstacles.
The x-axis is the vertical axis and the y-axis is the horizontal axis.
Obstacles are represented as a list where each 'obstacle' list is composed of the top left starting coordinate and the 
length in the x and y directions [ [x,y], xLength, yLength]. The Output is a an array representation of a grid where 1s 
represent free space and 0s are spaces blocked by obstacles
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


# Determines that manhattan distance between two points on a grid where the points are a list of [x,y] coordinates
def distance_manhattan(point1, point2):
    distance = abs(point1[0]-point2[0]) + abs(point1[1]-point2[1])
    return distance


"""
Inputs: nodeList -> a list of node objects, exitList -> a list of [x,y] coordinates of exits
Output: updated d_exit values for nodes in nodeList

Find the distance to the closest exit (d_exit) from a list of [x,y] coordinate pairs corresponding to exits in exitList
and update the node's d_exit with that value
"""
def node_set_d_exit(nodeList, exitList):
    for node in nodeList:
        for element in exitList:
            d_exit = distance_manhattan(node.coords, element)
            if d_exit < node.d_exit:
                node.d_exit = d_exit

"""
Inputs: grid -> with node numbers, nodeList -> list of node objects
Output: updates neighbors attribute for each node in nodeList representing the edge list for that node

Uses updated grid that has node numbers corresponding to their location in each open cell and nodeList to populate each 
node's neighbors attribute with a list of neighbors by node_id starting CW -> N, E, S, W. These represent the edges 
between each node
"""
def node_get_neighbors(grid,nodelist):

    gridSize = len(grid) - 1
    for node in nodelist:
        nodeX = node.coords[0]
        nodeY = node.coords[1]

        # Add neighbor's node_id from grid if non-zero
        # check N
        if nodeX != 0 and grid[nodeX-1][nodeY] !=0:
            node.neighbors.append(grid[nodeX-1][nodeY])
        # check E
        if nodeY != gridSize and grid[nodeX][nodeY+1] !=0:
            node.neighbors.append(grid[nodeX][nodeY+1])
        # check S
        if nodeX != gridSize and grid[nodeX+1][nodeY] !=0:
            node.neighbors.append(grid[nodeX+1][nodeY])
        # check W
        if nodeY != 0 and grid[nodeX][nodeY - 1] != 0:
            node.neighbors.append(grid[nodeX][nodeY - 1])


"""
Input: Grid with 1s and 0s
Output: The modified grid and a list of nodes representing the free space

Uses a grid where 1s are free space and 0s are blocked spaces to create a list of nodes for each free space where 
the node_id-1 is the list index for that node and to replace the 1s in the grid with the number of the node_id that 
represents that space.
"""
def node_initialize(grid):
    size = len(grid)
    nodeNum = 1

    nodeList = []

    for x in range(0, size):
        for y in range(0, size):
            if grid[x][y] == 1:
                grid[x][y] = nodeNum
                node = Node(nodeNum, [x, y])
                nodeList.append(node)
                nodeNum = nodeNum + 1
    return [grid, nodeList]


# For testing purposes
if __name__ == "__main__":

    obstacles = [[[1, 1], 1, 2], [[1,1], 2, 1]]
    exits = [[0, 0], [3, 3]]
    shooters = [[0, 2]]

    testnode = Node(1, [0, 0])
    testnode.backpointer = 0
    grid = grid_construct(4, obstacles)
    print(grid)
    [grid2, nodeList] = node_initialize(grid)
    print(grid2)
    node_get_neighbors(grid2, nodeList)
    node_set_d_exit(nodeList, exits)

    grid3 = grid2
    shooter_wavefront(nodeList, [3, 13])

    for node in nodeList:
        grid3[node.coords[0]][node.coords[1]] = node.safety

    print(grid3)



