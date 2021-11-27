%function twolink_plotCollision(theta,points)
%This function should: enumerate  the points specified by  @x   points as black
%asterisks.  twolink_isCollision for determining if each configuration is a
%collision or not.  twolink_plot to plot the manipulator for all configurations,
%using a red color when the manipulator is in collision, and green otherwise.
%enumerate
function twolink_plotCollision(theta,points)
NTheta = size(theta,2)
NPoints = size(points,2);

hold on;
%Find collisions for all the configurations and the points.
[flagTheta]=twolink_isCollision(theta,points);

%Plot each of the configurations and mark the ones in collision in red
%otherwise mark them in green
for thetaInd=1:NTheta
    if flagTheta(thetaInd)
        twolink_plot(theta(:,thetaInd), 'r')
    else
        twolink_plot(theta(:,thetaInd), 'g')
    end
end

%Plot all the points with a black asterisk
for pointInd=1:NPoints
    plot(points(1,pointInd), points(2, pointInd), 'k*')
end

hold off

end
