function mval2 = motivation2(mval,param)
%makes a random distribution with the mval as a mean and then picks a point
%from that distribution.

for ln=1:length(mval)
mval2_mu = mval(ln);
mval2_sigma = param.mval2Sigma;
mval2_pd = makedist('Normal',mval2_mu,mval2_sigma);%make distribution
mval2(ln)=random(mval2_pd,1,1);
end
mval2=mval2';

