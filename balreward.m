function balrw = balreward(bal,param)
%sets up a linear reward function, in which each point will become a
%gaussian
bal_slope=param.bal_slope;
balAstandard=1;
balBstandard=-0.5;
bal_A=balAstandard*bal_slope;%by multiplying by these two, it makes sure intercept is zero given any slope
bal_B=balBstandard*bal_slope;
addwhat=param.balRmean;%to shift the mean
balrw=(bal_A*bal)+bal_B+addwhat;


end

%% misc notes

%changing the mean 
%there are two ways to change the mean, either to alter the y intercept:
% addwhat=param.balRmean;
% balrw=(bal_A*bal)+bal_B+addwhat;
%ex. x-0.5+0.25, mean=0.25
%this changes the x intercept. The other way is to increase the a,
%which also changes the x-intercept similarily.
%dividewhat=param.balRmean
%a=0.5/param.balRmean
%as long as the x-intercept is kept 0.5, integral(mean) will be zero.
%however, as it moves to left or right, then the slope starts affecting the
%mean, it affects it more towards positive when intercept is less than
%0.5, and more towards negative when intercept is greater than 0.5. of
%course only for integral between 0-1

%if want to modulate slope, but keep intercept at 0.5.
% ax-b=0, if x=0.5, then a(0.5)-b=0, so b=a/2. 
%the other way is to set it standard of a=1 and b=1/2, then all you have to
%do is to multiply both by the same slope. 

