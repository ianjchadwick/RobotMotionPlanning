%function [U]=potential_total(xEval,world,potential)
%Compute the function $U=U_ attr+  @ @ _iU_ rep,i$, where $ $ is given by the
%variable  @x   potential.repulsiveWeight
function [UEval]=potential_total(xEval,world,potential)

NSpheres = size(world,2);

%Get potential repulsive weight
repWeight = potential.repulsiveWeight;

%Get attractive potential
UAttr = potential_attractive(xEval,potential);

%Initialize URepSum
URepSum = 0;

%Sum all repulsive potentials for NSpheres in world
for iSphere = 1:NSpheres
    URepSum = URepSum + potential_repulsiveSphere(xEval,world(1,iSphere));
end

URep = repWeight*URepSum;

UEval = UAttr + URep;




