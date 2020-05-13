function balrw2 =  balreward2(balrw,param)
%this funtion takes every point on the balreward line, sets it as a mean of
%a distribution and then picks up a sample from that distribution given our
%variance
for ln=1:length(balrw)
balrw_mu = balrw(ln);
balrw_sigma = param.balRsigma;
balrw_pd = makedist('Normal',balrw_mu,balrw_sigma);%make distribution
balrw2(ln)=random(balrw_pd,1,1);
end
balrw2=balrw2';

