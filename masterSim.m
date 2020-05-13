clear;
tic;

%% Overview

%This script serves as the master controller for the simulation, all of the parameters are set here 

%% conditions
runname='illustrative';
figures='on';%show figures?
savefigs='off';
savedata='off';%saves figures and data matrices
param.MOT='on';%motivation is a paramter that influences multiple steps, therefore it is set at a higher level
%% parameters
%parameters must be hand coded here

% pickstim
param.samples=30000;%number of iterations
param.balStdv=0.2;%balance standard deviation
param.compStdv=0.2;%complexity standard deviation
param.balMu=0.5;%balance mean
param.compMu=0.5;%complexity mean
param.cov=-0.5;%covariance between balance and complexity
% compreward
param.compRsigma=0.1;%complexity reward stdv
param.compRmu=0.75;%complexity reward mean as a function of comp
param.compRb=1;%scales the height
param.compRmean=0;%what we want the final mean of the comprw distribution to be
%compreward2
param.compR2sigma=0.1;%sigma of 2nd gaussian

%balreward
param.bal_slope=1.2;%slope of linear reward function
param.balRmean=0;% mean of balance reward function

%balreward2
param.balRsigma=0.1;%stdv of gaussians in reward function

%motivation
param.mvalSigma=0.1;%stdv of motivation function
param.mvalMu=0.65;%mean of motivation function

%motivation2
param.mval2Sigma=0.001;%stdv of gaussians built on mval 

param.alpha=0.01;%learning rate
param.initWts=[0,0];%initial weights
param.note=['inital weight is',num2str(param.initWts)];
disp(param)
%% functions
%functions that are used in the simulation, see within function for
%defintions of what they do
[uvector,bal,comp]=pickstim(param); %this function takes the parameters to set up the initial sensory distribution
comprw=compreward(comp,param);%sets up first part of sampling reward function for complexity
% comprw=tcomprw(comp,param);% uncomment to make slope same as balance equation
comprw2=compreward2(comprw,param);%second part of sampling reward functionf or complexity
balrw=balreward(bal,param);%sets up first part of sampling reward function for balance
balrw2=balreward2(balrw,param);%second part of sampling reward function for balance
mval=motivation(comp,param);%first part of sampling reward function for motivation
mval2=motivation2(mval,param);%second part of sampling reward function for motivation
averagerw=averagereward(balrw2,comprw2);%compute average reward
[balanceweights,complexityweights,valuekeeper,deltakeeper,rewardkeeper]=learningeq(averagerw,uvector,mval2,param);%learning algorithm
% valuefig(balanceweights,complexityweights,uvector)%optional returns value
% figure
%% save data
if strcmp(savedata,'on')
filename=sprintf('%s.mat',runname);
save(filename,'bal','comp','comprw','comprw2','balrw','balrw2','mval','mval2','averagerw','balanceweights','complexityweights','deltakeeper','rewardkeeper','valuekeeper','uvector','param','runname')
end
toc;
%% plots %%
switch figures
    case 'on'
        %% balance and complexity distribution
        figure;
        plot(bal,comp,'c.')
        xlabel('Balance')
        ylabel('Complexity')
        title(sprintf('U distribution-%s',runname))
        if strcmp(savefigs,'on')
        figurename=sprintf('%s_balcompdist.fig',runname);
        savefig(figurename)
        end
        %% comlexity to reward
        figure;
        plot(comp,comprw2,'g.')
        xlabel('complexity')
        ylabel('reward')
        title(sprintf('complexity to reward-%s',runname))
        legend([['sum ', num2str(sum(comprw2))],[' mean ', num2str(round(mean(comprw2),2))]])
        if strcmp(savefigs,'on')
        figurename=sprintf('%s_compreward.fig',runname);
        savefig(figurename)
        end
        %% complexity to motivation
     if strcmp(param.MOT,'on')
        figure;
        plot(comp,mval2,'r.')
        xlabel('complexity')
        ylabel('motivation')
        title(sprintf('complexity to motivation-%s',runname))
        if strcmp(savefigs,'on')
        figurename=sprintf('%s_compmotivation.fig',runname);
        savefig(figurename)
        end
     end
        %% initial balance and complexity weights
        figure;
        plot(1:param.samples*0.1,balanceweights(1:param.samples*0.1),'b')
        hold on;
        plot(1:param.samples*0.1,complexityweights(1:param.samples*0.1),'r')
        title(sprintf('initial balance and complexity weights-%s',runname))
        legend('balance','complexity')
        xlabel('Time (Iterations)')
        ylabel('Weight')
        hold off;
        if strcmp(savefigs,'on')
            figurename=sprintf('%s_initial_balcompweights.fig',runname);
            savefig(figurename)
        end
        %% balance and complexity weights
        figure;
        plot(1:length(bal),balanceweights,'b')
        hold on;
        plot(1:length(comp),complexityweights,'r')
        title(sprintf('balance and complexity weights-%s',runname))
        legend('balance','complexity')
        hold off;
        if strcmp(savefigs,'on')
        figurename=sprintf('%s_balcompweights.fig',runname);
        savefig(figurename)
        end
        %% phase-phase plot
        figure;
        scatter(balanceweights,complexityweights,10,1:length(balanceweights))
        xlabel('balance weights')
        ylabel('complexity weights')
        title(sprintf('phase-%s',runname))
        colormap summer
        if strcmp(savefigs,'on')
        figurename=sprintf('%s_balcompphase.fig',runname);
        savefig(figurename)
        end
        %% balance to reward
        figure;
        plot(bal,balrw2,'b.')
        xlabel('balance')
        ylabel('reward')
        title(sprintf('balance to reward-%s',runname))
        legend([['sum ', num2str(sum(balrw2))],[' mean ', num2str(round(mean(balrw2),2))]])
        if strcmp(savefigs,'on')
        figurename=sprintf('%s_balreward.fig',runname);
        savefig(figurename)
        end
       
    case 'off'
        %do nothing;
end

