function [InitialObservation, InitialState] = GliderResetFunction()
% Reset function to place custom glider environment into a random
% initial state.

%rng(76);86 76 106


% X
X0 = 0;
% Y rand
Y0 = 60 + randi([-1,2])*10;
% V rand
V0 = 10 + (rand-1/2)*10;
% theta rand
theta0 = randi([-9,6])*pi/36; % [-45;30]°
% wing
wing0 = 2;

% Return initial environment state variables as logged signals.
InitialState = [X0;Y0;V0;theta0;wing0];%;wch0
InitialObservation = InitialState;
end