%function torus_twolink_plotJacobian()
%For each one of the curves used in Question~ q:torusDrawChartsCurves, do the
%following: itemize  line_linspace to compute the array @boxIvory2 thetaPoints
%for the curve;  each one of the configurations given by the columns of
%@boxIvory2 thetaPoints: enumerate  twolink_plot to plot the two-link
%manipulator.  twolink_jacobian to compute the velocity of the end effector, and
%then use quiver to draw that velocity as an arrow starting from the end
%effector's position. enumerate itemize The function should produce a total of
%four windows (or, alternatively, a single window with four subplots), each
%window (or subplot) showing all the configurations of the manipulator
%superimposed on each other. You can insert a @boxIvory2 pause command in the
%loop for drawing the manipulator, in order to obtain a ``movie-like''
%presentation of the motion.
function torus_twolink_plotJacobian()

%Initialize all the values of a
a1 = [3/4*pi;0];
a2 = [3/4*pi; 3/4*pi];
a3 = [-3/4*pi;3/4*pi];
a4 = [0;3/4*pi];
b = [-1;-1];
nPoints = 31;

hold on
figure(1);

thetaPoints = line_linspace(a1,b,0,1,nPoints);

for thetaInd=1:nPoints
    twolink_plot(thetaPoints(:,thetaInd), 'g', thetaPoints(:,thetaInd));
end

hold on
figure(2);

thetaPoints2 = line_linspace(a2,b,0,1,nPoints);

for thetaInd=1:nPoints
    twolink_plot(thetaPoints2(:,thetaInd), 'g', thetaPoints2(:,thetaInd));
end

hold on
figure(3);

thetaPoints3 = line_linspace(a3,b,0,1,nPoints);

for thetaInd=1:nPoints
    twolink_plot(thetaPoints3(:,thetaInd), 'g', thetaPoints3(:,thetaInd));
end

hold on
figure(4);

thetaPoints4 = line_linspace(a4,b,0,1,nPoints);

for thetaInd=1:nPoints
    twolink_plot(thetaPoints4(:,thetaInd), 'g', thetaPoints4(:,thetaInd));
end
hold on

end

% ~For each window (or subplot), use the color of the corresponding curve as used
%in Question~ q:torusDrawChartsCurves.
