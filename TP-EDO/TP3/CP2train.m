function [newAgent,trainStats] = CP2train(agent,env)
% [NEWAGENT,TRAINSTATS] = mytrain(AGENT,ENV) train AGENT within ENVIRONMENT
% with the training options specified on the Train tab of the Reinforcement Learning Designer app.
% mytrain returns trained agent NEWAGENT and training statistics TRAINSTATS.

% Reinforcement Learning Toolbox
% Generated on: 10-Jan-2024 18:38:33

%% Create training options
trainOptions = rlTrainingOptions();
trainOptions.MaxEpisodes = 500;
trainOptions.MaxStepsPerEpisode = 500;
trainOptions.ScoreAveragingWindowLength = 15;
trainOptions.StopTrainingCriteria = "AverageReward";
trainOptions.StopTrainingValue = 460;

%% Make copy of agent
newAgent = copy(agent);

%% Perform training
trainStats = train(newAgent,env,trainOptions);
end