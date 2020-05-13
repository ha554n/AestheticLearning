function mval = motivation(comp,param)
%similar to comprw, sets up a gaussian distribution for the first part of
%sampling motivation

mot_s=param.mvalSigma;%stdv
mot_mu=param.mvalMu;%mu
x=comp;%use complexity value and put into equation below
p1 = -.5 * ((x - mot_mu)/mot_s) .^ 2;%part one of equation
f = exp(p1); %output of function
B=0.5;%scales the peak to half the height
byB=f*B;
A=0.1;%just makes the peak higher to 0.6.. max why not 1?
byA=byB+A;
mval=byA;