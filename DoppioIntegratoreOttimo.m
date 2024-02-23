close all
clear all
clc

global m x10

m = 1;      %massa
x10 = -2;   %condizione iniziale

[t,y] = ode45('SistemaOttimo',[0 10],[x10;0]);

x1 = y(:,1);
x2 = y(:,2);

figure(1);
hold on
box on
axis([-3 1 -1 1])
axis equal
line([-3 1],[0 0])
plot(x10,0,'ro')
text(x10,-0.15,'x_i','FontSize',18)
plot(0,0,'ro')
text(0,-0.15,'x_f','FontSize',18)
for i = 1:length(t)
 if i>1
    delete(h1);
    delete(h2);
 end
    h1 = patch([x1(i)+0.1,x1(i)+0.1,x1(i)-0.1,x1(i)-0.1],[0,0.2,0.2,0],'g');
    h2 = plot(x1(i),0.1,'k+');
    pause(0.1)
end