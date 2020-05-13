function [uvector,bal,comp]=pickstim(param)
%sets up a sensory distribtuion and returns a pair from this distribution

howmany=param.samples;%how many samples
stdbal=param.balStdv;%standard deviation of balance distribution
stdcomp=param.compStdv;%standard deviation of complexity distribution
mubal=param.balMu;%balance mean
mucomp=param.compMu;%complexity mean
varbal=(stdbal.^2);%variance of balance distribution
varcomp=(stdcomp.^2);%variance of complexity distribution
cv=param.cov;%covariance between the two distributions, between -1 and 1
cv_calc=cv*(stdbal*stdcomp);%covariance calculation
S = [varbal cv_calc; cv_calc varcomp];%sigma matrix
MU = [mubal,mucomp];%mean matrix
rcell={};%initialize cell which is filled 1 sample at a time
iter= 1;
skips=0;%store how many skipped for reference
tic;
%loop samples rmvnrnd until both values are between 0 and 1
while size(rcell)<howmany%runs loop till # of samples collected one at a time
    r = mvnrnd(MU, S, 1); %collect one sample, outside function 
    cn=r<0 | r>1;%check if r is greater than zero and less than 1
    if any(cn)%if any condition above true, skip this
        skips=skips+1;%just for bookkeeping
    end
        if ~any(cn)%if conditions are not met, means within range
            rcell{iter,1}=r;%send it over to the cell because met condition
            iter=iter+1;%should be a smarter way to do this using 'howmany'
        end
end
uvector=cell2mat(rcell);%just converts it to matrix for usage
bal=uvector(:,1);
comp=uvector(:,2);
end
