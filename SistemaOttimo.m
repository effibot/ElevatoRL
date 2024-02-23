function xdot = SistemaOttimo(t,y)

x1 = y(1)-5;
x2 = y(2);
x = [x1;x2];

A = [0 1;0 0];
B = [0;1];

u = -x1-sqrt(2)*x2;

xdot = A*x+B*u;