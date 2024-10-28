function [NextObs, Reward, IsDone, NextState] = GliderStepFunction(Action, State)
%Custom step function for the glider env, computes the pos for one step

% Consts

% Gravity
g = 9.81;

% Drag coefficient
drag = 1.5*10^(-4);

% Lift coefficient
lift = 0.0077

% y treshold for the glider i.e. the glider should never go under y = 0
yTreshold = 0;

% x objective for the landing 
xObjective = 300;


%TODO
end