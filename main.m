% Elevator - Reinforcment Learning

% The reinforcement learning problem is getting an optimal policy for controlling
% an elevator. In particular, the actions are represented by the possible increases
% of the forces that allow the movement of the lift, which for simplicity has been
% considered to have a unitary mass, while the states are all the possible positions
% that the lift can assume in space. Given the high cardinality of the states and
% the continuous nature of the problem, we have chosen to solve this problem with the
% application of the SARSA_ET typical of the functional approximation.
clc
clear
close all

%% Init

% Initial Point

yStart = 0;
% Constant of increments

K=1;
% Action List

action = K*[-1,0,1];
% Lower and UpperBound to y position

lby = -2;
uby = 8;
% Lower and UpperBound to velocity

lbv = -6;
ubv = 6;
% Grid Dimension

M =20;
% Number of grid

N = 5;
% Number of episodes

numEpisodes = 1e5;

epsilon = 1e-2;
alpha =1.e-2;
gamma = 1;
lambda = 0.7;

% Number of Cells
nCells = (M+1)^2;
d = length(action)*N*nCells;
% Costruction of tiles
% To build tiles we need to bound y position between intial and final
% point. Due to the nature of the problem we have to consider bounded
% velocity to safety of the people in the elevator

[gridx, gridv] = build_tiles(lby, uby,lbv,ubv, M, N);

% Init Elevatr Enviroment
env = ElevatorConcrete;

%Plotting Enviroment
%env.plot;

% History of all episodes
episode=[];
%% TRAINING PHASE - IMPLEMENTING SARSA ET ALGORITHM
w = zeros(d,1);

for ii = 1:numEpisodes
    z = zeros(d,1);
    s = [0,0];
    a = epsgreedy(s, w, epsilon, gridx, gridv, M, N, action);
    isTerminal = false;
    steps = 0;
    if ii == numEpisodes
        episode(end+1,:) = [s,a,0,0];
    end
    while ~isTerminal
        
        steps = steps + 1;
        x = getFeatures(s,a,gridx,gridv,M,N,length(action));
        [sp, r, isTerminal] = env.step(s,action(a),0);
        if isTerminal
            delta = r-w'*x;
            this.act = 0;
        else
            ap = epsgreedy(sp, w, epsilon, gridx, gridv, M, N, action);
            xp = getFeatures(sp,ap,gridx,gridv,M,N,length(action));
            delta = r+gamma*w'*xp-w'*x;
        end
        z = gamma*lambda*z+x;
        w = w+alpha*delta*z;
        s = sp;
        a = ap;
        
        env.PlotValue = 1;
        if ii == numEpisodes
                episode(end+1,:) = [s,a,r,env.act];
                pause(0.1)
                env.PlotValue = 1;
                env.State = [s(1),s(2)];
                env.plot        
        end
    end
    disp([ii, steps])
end
save ElevatorData episode


