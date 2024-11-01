function [NextObs, Reward, IsDone, NextState] = GliderStepFunction(Action, State)
%Custom step function for the glider env, computes the pos for one step

% Consts

% Gravity
g = 9.81;

%Sample time
h=0.05;
% Drag coefficient
drag = 1.5*10^(-4);

% Lift coefficient
lift = 0.0077;

% y treshold for the glider i.e. the glider should never go under y = 0
yTreshold = 0;

% x objective for the landing 
xObjective = 840;

% Reward each time step the glider is not landed yet
%distV = abs(State(3)-24.4572);
%distTheta = abs(State(4)+0.0078);
RewardForApproch = ...
    (xObjective-(xObjective-State(1)))/(State(2)+0.001); %The smaller the altitude, bigger the reward
% Penalty if the glider landed
PenaltyForCrashing = -10000;
PenaltyForCrashingX = -300000
RewardForLanding = 300000*(1-((xObjective-State(1))/xObjective));

% Perform RK4 to calculate next state.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NextState = RK4_2(g,h,Action,State);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copy next state to next observation.
NextObs = NextState;

% Check terminal condition.
Theta = NextObs(4)
abs(NextObs(4)) < 0.1
Y = NextObs(2);
X = NextObs(1);
%Theta = NextObs(4);
IsDone = (Y <= yTreshold) | X > (xObjective+10);
Landed = (Y < yTreshold) & (abs(NextObs(4)) < 0.1);

% Calculate reward.
if ~IsDone
    Reward = RewardForApproch
else
    
    if Landed
        if abs(X-xObjective)<100
            Reward = 900000
        end
        Reward = RewardForLanding
    end
    if X > (xObjective+10)
        Reward = PenaltyForCrashingX
    else
        Reward = PenaltyForCrashing
    end
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
    NextState(5)=Action;
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
    dy = zeros(5,1);
    
    dy(1) = State(3)*cos(State(4));
    dy(2) = State(3)*sin(State(4));
    dy(3) = -g*sin(State(4)) - Md(Action)*State(3)^2;
    dy(4) = -g*cos(State(4))/State(3) + Ml(Action)*State(3);
    dy(5) = 0;
end
