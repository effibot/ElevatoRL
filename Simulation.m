% Simulation SARSA- Elegibility traces whit control bang bang
clc
clear 
close all
load ElevatorData
%%
% Init Elevatr Enviroment
env = ElevatorConcrete;
% Constant of increments

K=1;
% Action List

action = K*[-1,0,1];
%Plotting Enviroment
%env.plot;
env.PlotValue = 0;
i=2;
isTerminal = false;

s = episode(1,1:2);
a = episode(1,3);

listStates = [];
for i = 1: size(episode,1)-2
    expand = linspace(episode(i,1),episode(i+1,1),5).';
    listStates = vertcat(listStates,expand);
    
end
%%


m = 1;      %massa
x10 = 0;   %condizione iniziale

[t,y] = ode45('SistemaOttimo',[0 10],[x10;0]);

listStateOptimal = y(:,1);
%%
env.plotState(listStates,listStateOptimal);
