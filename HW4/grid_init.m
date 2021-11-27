% Initializes a grid with fields xx and yy, each one containing NCells
% values linearly spaced from -10 to 10 for HW4 2.1

function [grid] = grid_init(NCells)
spacing = linspace(-10, 10, NCells);
grid = struct("xx", spacing, "yy", spacing);



