%% environment
ObsInfo = rlNumericSpec([4 1]);
ObsInfo.Name = "CartPole States";
ObsInfo.Description = 'x, dx, theta, dtheta';
ActInfo = rlFiniteSetSpec([-10 10]);
ActInfo.Name = "CartPole Action";

env = rlFunctionEnv(ObsInfo,ActInfo,"CP2StepFunction","CP2ResetFunction");
obsInfo = getObservationInfo(env)
actInfo = getActionInfo(env)
%% network

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
%% training

[agent2,trainStats] = CP2train(agent,env);
save agent2.mat agent2
