function [balanceweightskeeper,complexityweightskeeper,valuekeeper,deltakeeper,rewardkeeper]=learningeq(averagerw,uvector,motivation,param)
%the learning algorithm, has two modes, either with motivation or without
%as a factor. without motivation, runs a gradient descent algorithm. With
%motivation, the gradient descent is modified by multiplying value and
%reward with motivation.

weights=param.initWts;
fprintf('the initial weights are set to %d, %d \n',weights(1),weights(2))
switch param.MOT
    case 'on'
        for run=1:param.samples%meaning doing STOCHASTIC gradient descent
        %calc
        epsilon=param.alpha;
        value=motivation(run)*weights*uvector(run,:)';%multiplying by motivation here
        reward=motivation(run)*averagerw(run);%multiplying by motivation here
        delta=reward-value;
        weights=weights+(epsilon*delta*uvector(run,:));
        %storage
        balanceweightskeeper(run)=weights(1);
        complexityweightskeeper(run)=weights(2);
        valuekeeper(run)=value;
        deltakeeper(run)=delta;
        rewardkeeper(run)=reward;
        end
        fprintf('motivation ON \n')

    case 'off'
        for run=1:param.samples
        epsilon=param.alpha;
        reward=averagerw(run);
        value=weights*uvector(run,:)';
        delta=reward-value;
        weights=weights+(epsilon*delta*uvector(run,:));
        balanceweightskeeper(run)=weights(1);
        complexityweightskeeper(run)=weights(2);
        valuekeeper(run)=value;
        deltakeeper(run)=delta;
        rewardkeeper(run)=reward;
        end
        fprintf('motivation off \n')
end
