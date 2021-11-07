%function [uOpt,DeltaOpt]=qp_minEffort(AAttr,bAttr,ABarrier,bBarrier,mPenalty)
%Solves the optimization problem in    @  (  eq:CBF \@@italiccorr ) for the given
%parameters.
function [uOpt,DeltaOpt]=qp_minEffort(AAttr,bAttr,ABarrier,bBarrier,mPenalty)
