import sys
import pygame
from pygame.locals import KEYDOWN, K_q
import graph

# CONSTANTS:
SCREENSIZE = WIDTH, HEIGHT = 800, 600
BLACK = (0, 0, 0)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
GREEN = (0, 128, 0)
PURPLE = (128, 0, 128)
ORANGE = (255, 140, 0)
GREY = (160, 160, 160)

# OUR GRID MAP:
obstacles = [[[1, 1], 1, 3],
             [[1, 1], 4, 1],
             [[3, 3], 2, 1],
             [[1, 5], 4, 1],
             [[1, 7], 1, 2],
             [[4, 7], 1, 2],
             [[6, 0], 1, 5],
             [[6, 4], 2, 1],
             [[6, 6], 1, 3],
             [[8, 6], 1, 1]]
exits = [[3, 8], [8, 0]]
shooters = [[0, 6]]
size = 9
start = [1, 4]

graph.graph = graph.Graph(size, obstacles, exits)
graph.graph.graph_initialize()
graph.graph.node_get_neighbors()
graph.graph.node_set_d_exit()
graph.graph.shooter_wavefront(shooters)
safest_shortest_path = graph.graph.safest_escape_path(start)
a_star_shortest_path = graph.graph.regular_a_star(start)

cellMAP = graph.grid_construct(size, obstacles)

for node in safest_shortest_path:
    coordinate = graph.graph.nodes[node-1].coords
    cellMAP[coordinate[0]][coordinate[1]] = 2

for node in a_star_shortest_path:
    coordinate = graph.graph.nodes[node-1].coords
    cellMAP[coordinate[0]][coordinate[1]] = 3

for shooter in shooters:
    if type(shooter) == list:
        cellMAP[shooter[0]][shooter[1]] = 4
    else:
        cellMAP[shooter] = 4

cellMAP[start[0]][start[1]] = 5

for location in exits:
    if type(location) == list:
        cellMAP[location[0]][location[1]] = 6
    else:
        cellMAP[location] = 6


_VARS = {'surf': False, 'gridWH': 400,
         'gridOrigin': (200, 100), 'gridCells': cellMAP.shape[0], 'lineWidth': 2}


def main():
    pygame.init()
    _VARS['surf'] = pygame.display.set_mode(SCREENSIZE)
    while True:
        checkEvents()
        _VARS['surf'].fill(GREY)
        drawSquareGrid(
         _VARS['gridOrigin'], _VARS['gridWH'], _VARS['gridCells'])
        placeCells()
        pygame.display.update()


# NEW METHOD FOR ADDING CELLS :
def placeCells():
    # GET CELL DIMENSIONS...
    cellBorder = 6
    celldimX = celldimY = (_VARS['gridWH']/_VARS['gridCells']) - (cellBorder*2)
    # DOUBLE LOOP
    for row in range(cellMAP.shape[0]):
        for column in range(cellMAP.shape[1]):
            # Is the grid cell tiled ?
            if(cellMAP[column][row] == 0):
                drawWallCell(
                    _VARS['gridOrigin'][0] + (celldimY*row)
                    + cellBorder + (2*row*cellBorder) + _VARS['lineWidth']/2,
                    _VARS['gridOrigin'][1] + (celldimX*column)
                    + cellBorder + (2*column*cellBorder) + _VARS['lineWidth']/2,
                    celldimX, celldimY)
            if (cellMAP[column][row] == 3):
                drawAStarPathCell(
                    _VARS['gridOrigin'][0] + (celldimY * row)
                    + cellBorder + (2 * row * cellBorder) + _VARS['lineWidth'] / 2,
                    _VARS['gridOrigin'][1] + (celldimX * column)
                    + cellBorder + (2 * column * cellBorder) + _VARS['lineWidth'] / 2,
                    celldimX, celldimY)
            if (cellMAP[column][row] == 2):
                drawSafePathCell(
                    _VARS['gridOrigin'][0] + (celldimY * row)
                    + cellBorder + (2 * row * cellBorder) + _VARS['lineWidth'] / 2,
                    _VARS['gridOrigin'][1] + (celldimX * column)
                    + cellBorder + (2 * column * cellBorder) + _VARS['lineWidth'] / 2,
                    celldimX, celldimY)
            if (cellMAP[column][row] == 4):
                drawShooterCell(
                    _VARS['gridOrigin'][0] + (celldimY * row)
                    + cellBorder + (2 * row * cellBorder) + _VARS['lineWidth'] / 2,
                    _VARS['gridOrigin'][1] + (celldimX * column)
                    + cellBorder + (2 * column * cellBorder) + _VARS['lineWidth'] / 2,
                    celldimX, celldimY)
            if (cellMAP[column][row] == 5):
                drawStartCell(
                    _VARS['gridOrigin'][0] + (celldimY * row)
                    + cellBorder + (2 * row * cellBorder) + _VARS['lineWidth'] / 2,
                    _VARS['gridOrigin'][1] + (celldimX * column)
                    + cellBorder + (2 * column * cellBorder) + _VARS['lineWidth'] / 2,
                    celldimX, celldimY)
            if (cellMAP[column][row] == 6):
                drawExitCell(
                    _VARS['gridOrigin'][0] + (celldimY * row)
                    + cellBorder + (2 * row * cellBorder) + _VARS['lineWidth'] / 2,
                    _VARS['gridOrigin'][1] + (celldimX * column)
                    + cellBorder + (2 * column * cellBorder) + _VARS['lineWidth'] / 2,
                    celldimX, celldimY)

# Draw filled rectangle at coordinates
def drawWallCell(x, y, dimX, dimY):
    pygame.draw.rect(
     _VARS['surf'], BLACK,
     (x, y, dimX, dimY)
    )

def drawShooterCell(x, y, dimX, dimY):
    pygame.draw.rect(
     _VARS['surf'], RED,
     (x, y, dimX, dimY)
    )

def drawStartCell(x, y, dimX, dimY):
    pygame.draw.rect(
     _VARS['surf'], BLUE,
     (x, y, dimX, dimY)
    )

def drawSafePathCell(x, y, dimX, dimY):
    pygame.draw.rect(
     _VARS['surf'], PURPLE,
     (x, y, dimX, dimY)
    )

def drawAStarPathCell(x, y, dimX, dimY):
    pygame.draw.rect(
     _VARS['surf'], ORANGE,
     (x, y, dimX, dimY)
    )

def drawExitCell(x, y, dimX, dimY):
    pygame.draw.rect(
     _VARS['surf'], GREEN,
     (x, y, dimX, dimY)
    )


def drawSquareGrid(origin, gridWH, cells):

    CONTAINER_WIDTH_HEIGHT = gridWH
    cont_x, cont_y = origin

    # DRAW Grid Border:
    # TOP lEFT TO RIGHT
    pygame.draw.line(
      _VARS['surf'], BLACK,
      (cont_x, cont_y),
      (CONTAINER_WIDTH_HEIGHT + cont_x, cont_y), _VARS['lineWidth'])
    # # BOTTOM lEFT TO RIGHT
    pygame.draw.line(
      _VARS['surf'], BLACK,
      (cont_x, CONTAINER_WIDTH_HEIGHT + cont_y),
      (CONTAINER_WIDTH_HEIGHT + cont_x,
       CONTAINER_WIDTH_HEIGHT + cont_y), _VARS['lineWidth'])
    # # LEFT TOP TO BOTTOM
    pygame.draw.line(
      _VARS['surf'], BLACK,
      (cont_x, cont_y),
      (cont_x, cont_y + CONTAINER_WIDTH_HEIGHT), _VARS['lineWidth'])
    # # RIGHT TOP TO BOTTOM
    pygame.draw.line(
      _VARS['surf'], BLACK,
      (CONTAINER_WIDTH_HEIGHT + cont_x, cont_y),
      (CONTAINER_WIDTH_HEIGHT + cont_x,
       CONTAINER_WIDTH_HEIGHT + cont_y), _VARS['lineWidth'])

    # Get cell size, just one since its a square grid.
    cellSize = CONTAINER_WIDTH_HEIGHT/cells

    # VERTICAL DIVISIONS: (0,1,2) for grid(3) for example
    for x in range(cells):
        pygame.draw.line(
           _VARS['surf'], BLACK,
           (cont_x + (cellSize * x), cont_y),
           (cont_x + (cellSize * x), CONTAINER_WIDTH_HEIGHT + cont_y), 2)
    # # HORIZONTAl DIVISIONS
        pygame.draw.line(
          _VARS['surf'], BLACK,
          (cont_x, cont_y + (cellSize*x)),
          (cont_x + CONTAINER_WIDTH_HEIGHT, cont_y + (cellSize*x)), 2)


def checkEvents():
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            sys.exit()
        elif event.type == KEYDOWN and event.key == K_q:
            pygame.quit()
            sys.exit()


if __name__ == '__main__':
    main()