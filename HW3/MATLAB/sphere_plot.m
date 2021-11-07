%function sphere_plot(sphere,color)
%This function draws the sphere (i.e., a circle) with radius  sphere.r and the
%specified color, and another circle with radius  sphere.rInfluence in gray.
function varargout = sphere_plot(sphere,color)

%Get number of spheres in array
sphereNum = size(sphere, 2);

%loop for every sphere in array
for iSphere = 1:sphereNum
%geometrical radius
radius=abs(sphere(iSphere).radius);
%filled-in or hollow
radiusSign=sign(sphere(iSphere).radius);
if radiusSign>0
    faceColor=[0.8 0.8 0.8];
else
    faceColor=[1 1 1];
end
%geometry radius of influence
radiusInfluence=radius+radiusSign*sphere(iSphere).distInfluence;
%plotting of the sphere and sphere of influence
plotHandle1=plotCircle(sphere(iSphere).xCenter(1),sphere(iSphere).xCenter(2),radius,'EdgeColor',color,'FaceColor',faceColor);
plotHandle2=plotCircle(sphere(iSphere).xCenter(1),sphere(iSphere).xCenter(2),radiusInfluence,'EdgeColor',[0.5 0.5 0.5]);

if nargout>0
    varargout{1}=[plotHandle1;plotHandle2];
end
end


function plotHandle=plotCircle(xCenter,yCenter,radius,varargin)
radius=abs(radius);
diameter = radius*2;
xCorner = xCenter-radius;
yCorner = yCenter-radius;
plotHandle = rectangle('Position',[xCorner yCorner diameter diameter],'Curvature',[1,1],varargin{:});
