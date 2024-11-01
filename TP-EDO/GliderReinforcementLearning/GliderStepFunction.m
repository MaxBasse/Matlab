function [NextObs, Reward, IsDone, NextState] = GliderStepFunction(Action, State)
%Custom step function for the glider env, computes the pos for one step

% Consts

% Gravity
g = 9.81;

%Sample time
h=0.05;

% y treshold for the glider i.e. it should never go under y = 0
yTreshold = 0;


% y maximum for the glider i.e it should stay under y=20
yMaximum =20;

% x minimum for the glider i.e it must crash after x = 400 
xMinimum = 300;

% theta maximum for the glider i.e how straight we want it to glide
thetaMaximum =pi/6;

%-----------

%Variable to compute the reward
Y = State(2);
X=State(1);
Theta = State(4);

if X<250 && Y<yMaximum
    RewardForLanding = X^2; %Rewarded for heading down at the beginning
elseif Y<yMaximum   %If low altitude
    if abs(Theta)<thetaMaximum %Rewarded only if not oscillating
        RewardForLanding=X*1e4/(abs(Y)+0.01)^2;
    else
        RewardForLanding = -1e5/X^2; %or it's penalized
    end
else %If high altitude it's penalized
    RewardForLanding=-X^2;
end

% If the glider crashed, it's rewarded only after a certain x
if X<xMinimum
    PenaltyForCrashing = -1e6*X;
else
    PenaltyForCrashing = X^2;
end


% Perform RK4 to calculate next state.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NextState = RK4_2(g,h,Action,State);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copy next state to next observation.
NextObs = NextState;

% Check terminal condition.

IsDone = Y < yTreshold;


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
end
