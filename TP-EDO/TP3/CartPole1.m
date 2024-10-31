env = rlPredefinedEnv("CartPole-Discrete")
obsInfo = getObservationInfo(env)
actInfo = getActionInfo(env)
%rng(0)
% network
net = [
    featureInputLayer(obsInfo.Dimension(1))
    fullyConnectedLayer(32)
    reluLayer
    fullyConnectedLayer(length(actInfo.Elements))
    ];
net = dlnetwork(net);
summary(net)
plot(net)
% critic
critic = rlVectorQValueFunction(net,obsInfo,actInfo);
criticOptions = rlOptimizerOptions( ...
    LearnRate=1e-3, ...
    GradientThreshold=1);
% agent
agentOptions = rlDQNAgentOptions(...%CriticOptimizerOptions=criticOptions,...
    ExperienceBufferLength=1e5,...
    MiniBatchSize=256,...
    TargetSmoothFactor=1,...
    TargetUpdateFrequency=4,...
    UseDoubleDQN=false);
agent = rlDQNAgent(critic,agentOptions);

% training
trainOpts = rlTrainingOptions(...
    MaxEpisodes=500, ...
    MaxStepsPerEpisode=500, ...
    Verbose=false, ...
    Plots="training-progress",... 
    ScoreAveragingWindowLength = 15,...
    StopTrainingCriteria="AverageReward",...
    StopTrainingValue=460);
% plot
plot(env)

trainingStats = train(agent,env,trainOpts);

% simulate
simOptions = rlSimulationOptions(MaxSteps=500);
experience = sim(env,agent,simOptions);
totalReward = sum(experience.Reward)