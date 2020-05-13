function comprw2 = compreward2(comprw,param)
%for every point in comprw gaussian, sets that as a mean and makes a distribution,
%then randomly picks a number from that distribution. 
for ln=1:length(comprw)
comprw2_mu = comprw(ln);
comprw2_sigma = param.compR2sigma;
comprw2_pd = makedist('Normal',comprw2_mu,comprw2_sigma);%make distribution
comprw2(ln,1)=random(comprw2_pd,1,1);
end
% comprw2=comprw2';