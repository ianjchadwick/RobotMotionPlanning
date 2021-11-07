%function [gradU]=potential_totalGrad(xEval,world,potential)
%Compute the gradient of the total potential, $ U= U_ attr+  @ @ _i U_ rep,i$,
%where $ $ is given by the variable  @x   potential.repulsiveWeight
function [gradU]=potential_totalGrad(xEval,world,potential)

NSpheres = size(world,2);

%Get attractive potential gradient 
UAttrGrad = potential_attractiveGrad(xEval,potential);

%Get repulsive weight
repWeight = potential.repulsiveWeight;

%Find the sum of all repulsive gradients for NSpheres in world
URepGradSum = 0;

for iSphere = 1:NSpheres
    URepGradSum = URepGradSum + potential_repulsiveSphereGrad(xEval,world(1,iSphere));
end

URepGrad = repWeight*URepGradSum;

gradU = UAttrGrad + URepGrad;
