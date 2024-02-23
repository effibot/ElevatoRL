function x = getFeatures(s, a, gridx, gridv, M, N, A)

nCells = (M + 1)^2;
d = A*N*nCells;
x = zeros(d, 1);

for ii = 1 : N
    xxx = gridx(ii, :);
    vvv = gridv(ii, :);
    ix = find(s(1) >= xxx(1:end-1) & s(1) <= xxx(2:end), 1, 'first');
    iv = find(s(2) >= vvv(1:end-1) & s(2) <= vvv(2:end), 1, 'first');
    ind = sub2ind([M + 1, M + 1, N, A], ix, iv, ii, a);
    x(ind) = 1;
end

