%function [uOpt]=clfcbf_control(xEval,world,potential)
%Compute $u^*$ according to    @  (  eq:clfcbf-qp \@@italiccorr ), where $m$ is
%given by the variable @boxIvory2 potential.repulsiveWeight
function [uOpt]=clfcbf_control(xEval,world,potential)

%This function should use qp_minEffortFix from Question~ q:minEffortFix, by
%building $A_ attr$, $b_ attr$ according to $ $ in    @  (  eq:CLF \@@italiccorr
%), $A_ barrier$, $b_ barrier$ according to $ $ in    @  (  eq:CBF \@@italiccorr
%).

%Get number of spheres
NSpheres = size(world,2);
ABarrier = zeros(NSpheres, 2);
bBarrier = zeros(NSpheres, 1);

uRef = -1*potential_attractiveGrad(xEval,potential);

%For every sphere in world
for iSphere = 1:NSpheres
    
    %find ABarrier, where Abarrier = -gradDi(x) transposed
    ABarrier(iSphere,:) = -1*sphere_distanceGrad(world(:,iSphere),xEval)';
    %find bBarrier, where bBarrier = -repulsiveWeight*Di(x)
    bBarrier(iSphere,1) = -1*potential.repulsiveWeight*sphere_distance(world(:,iSphere),xEval);
    
end

%Calculate the QP using given function

uOpt = qp_supervisor(ABarrier,bBarrier,uRef);
end



