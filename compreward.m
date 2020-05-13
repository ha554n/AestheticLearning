function comprw = compreward(comp,param)
%sets up the first dimensional gaussian to simplify the sampling of
%complexity reward from gaussian of gaussians
compr_s=param.compRsigma;%stdv
compr_mu=param.compRmu;%mu
p1 = -.5 * ((comp - compr_mu)/compr_s) .^ 2;%part one of gaussian equation
f = exp(p1); %output of function
B=param.compRb;
byB=f*B;%scales the height of the peak
% sumB=sum(byB);%?
meanB=mean(byB);
comprw=byB-meanB;%mean of zero by subtracting mean from all values
addwhat=param.compRmean-mean(comprw);%right now param.compRmean=0, mean(comprw)before here is 4.35e-16. just a catch for me to know what I am setting the mean as.
comprw=comprw+addwhat;%so here becomes -8.5e18 
