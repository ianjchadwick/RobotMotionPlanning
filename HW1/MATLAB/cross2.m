% The 2-D cross product of two vectors V and W given as Vx*Wy -Vy*Wx
% where V and W are column vectors
function z = cross2(V,W)
    z = (V(1,1)*W(2,1))-(V(2,1)*W(1,1));
    