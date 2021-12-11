import graph
import heapq


class PQueue:
    def __init__(self):
        self.elements: list[tuple[float, int]] = []

    def empty(self) -> bool:
        return not self.elements

    def push(self, item: int, priority: float):
        heapq.heappush(self.elements, (priority,item))

    def pop(self) -> int:
        return heapq.heappop(self.elements)[1]



def safest_escape(graph, start):
    queue = PQueue()
    closed = []
    startID = int
    # find node_id for matching start node
    for node in graph:
        if node.coords == start:
            startID = node.node_id
            break
    graph[startID-1].cost = 0
    queue.push(startID, 0)

    while not queue.empty():
        nbestidx = queue.pop() - 1






# For testing purposes
if __name__ == "__main__":

    obstacles = [[[1, 1], 1, 2], [[1,1], 2, 1]]
    exits = [[0, 0], [3, 3]]
    shooters = [[0, 0], [3,3]]

    grid = graph.grid_construct(4, obstacles)
    print(grid)
    [grid2, nodeList] = graph.graph_initialize(grid)
    print(grid2)
    graph.node_get_neighbors(grid2, nodeList)
    graph.node_set_d_exit(nodeList, exits)

    grid3 = grid2
    graph.shooter_wavefront(nodeList, shooters)

    node = 1

    q = PQueue()
    q.push(node, 0)

    print(nodeList[q.pop()-1].node_id)


    for node in nodeList:
        grid3[node.coords[0]][node.coords[1]] = node.safety

    print(grid3)

