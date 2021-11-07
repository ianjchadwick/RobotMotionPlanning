%function torus_plotCharts()
%For each one of the chart domains $U_i$ from the previous question: enumerate  a
% @x   grid structure with fields  @x   xx and  @x   yy that define a grid of
%regular point in $U_i$. Use  @x   NGrid=33.  the function grid_eval with
%argument  @x   grid and torus_phi.  the surface described by the values in  @x  
%grid.F using the Matlab function surf. enumerate
function torus_plotCharts()
%Create two chart domains U1 and U2 to represent the torus
U1 = -0.2 + (0:33)*((2*pi+0.2)/33);
U2 = 0 + (0:33)*((2*pi+0.2)/33);

grid.xx = U1;
grid.yy = U2;
grid.F = zeros(33,33,3);

func = @torus_phi;

result = grid_eval(grid,func);
surf(result.F(:, :, 1), result.F(:, :, 2), result.F(:, :, 3), 'FaceAlpha', 0.75)
% fill3(result.F(:, :, 1), result.F(:, :, 2), result.F(:, :, 3), 'r')

end


%Use the commands  @x   hold on and  @x   hold off to show all the charts on the
%same figure. To better show the overlap between the charts, you can use
%different colors each one of them, and the  @x     FaceAlpha  ,0.75 option for
%surf.
