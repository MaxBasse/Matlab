function [NextObs, Reward, IsDone, NextState] = GliderNewStepFunction(Action, State)
%Custom step function for the glider env, computes the pos for one step

% Consts

% Gravity
g = 9.81;

%Sample time
h=0.05;

% y treshold for the glider i.e. it should never go under y = 0
yTreshold = 0;


% y maximum for the glider i.e it should stay under y=20
yMaximum =10;

% x minimum for the glider i.e it must crash after x = 400 
xMinimum = 210;

% theta maximum for the glider i.e how straight we want it to glide
thetaMaximum =1.2;

%-----------

%Variable to compute the reward
distY = yMaximum-State(2);
distTheta = abs(State(4)-thetaMaximum);
w = sign(abs(2-Action));
a = 5; k = 30;
RewardForNotLanding = ...
State(1)*distY*abs(1-State(4)) - k*max(0,(Action-k)*w);

PenaltyForCrashing = -1e5;

% Perform RK4 to calculate next state.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NextState = RK4_2(g,h,Action,State);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copy next state to next observation.
NextObs = NextState;

% Check terminal condition.

IsDone = NextState(2) < yTreshold;

% Calculate reward.
if ~IsDone
    Reward = RewardForNotLanding;
else
    Reward= PenaltyForCrashing;
end

end
%----------------------------------
function NextState = RK4_2(g,h,Action,State)

    Y1=State;%(1:4)
    k1=rhs2(g,Action,Y1);
    Y2=State+h/2*k1;
    k2=rhs2(g,Action,Y2);
    Y3=State+h/2*k2;
    k3=rhs2(g,Action,Y3);
    Y4=State+h*k3;
    k4=rhs2(g,Action,Y4);
    Y=State+h*(k1+2*k2+2*k3+k4)/6;
    NextState=Y;
end
%----------------------------------
function dy = rhs2(g,Action,State)

    Md=[1.3520e-04 % -5  deg
        1.0848e-04 %  0  deg
        1.0336e-04 %  2.5 deg
        1.2752e-04 %  5  deg
        1.8384e-04 %  7.5 deg
        2.7936e-04 % 10 deg
        6.2384e-04]; % 15 deg
    Ml=[-0.0011
        0.0077
        0.0121
        0.0164
        0.0202
        0.0229
        0.0265];
    dy = zeros(4,1);
    
    dy(1) = State(3)*cos(State(4));
    dy(2) = State(3)*sin(State(4));
    dy(3) = -g*sin(State(4)) - Md(Action)*State(3)^2;
    dy(4) = -g*cos(State(4))/State(3) + Ml(Action)*State(3);
end
