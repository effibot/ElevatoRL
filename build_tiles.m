function [gridx, gridv] = build_tiles(lby, uby,lbv,ubv, M, N)

% Offset di uno lungo x e di 3 lungo y
off = [1; 3];
off = off./max(off);

% Spostamento delle griglie per aver griglie non sovrapposte lungo x
dx = (uby - lby)/M;
TX = lby - dx:dx:uby;

% Spostamento delle griglie per aver griglie non sovrapposte lungo y
dv = (ubv - lbv)/M;
TV = lbv - dv:dv:ubv;

gridx = zeros(N, length(TX));
gridv = zeros(N, length(TV));
%Ciasuna riga di grix da indicazione sulle x delle griglie
gridx(1, :) = TX;
gridv(1, :) = TV;

for ii = 2 : N
    % off(1)*dx/N*(ii-1) massimo spostamento consentito
    gridx(ii, :) = TX + off(1)*dx/N*(ii-1);
    gridv(ii, :) = TV + off(2)*dv/N*(ii-1);
end
