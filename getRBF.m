function x = getRBF(s, a, sigma, gridx, gridv, M, N, A)
Adim = length(A);
nCells = (M + 1)^2;
d = Adim*N*nCells;
x = zeros(d, 1);

for i1 = 1 : N
    for i2 = 1 : M+1
        for i3 = 1 : M+1
            ind = sub2ind([M+1 M+1 N Adim], i3, i2, i1, a);
            x(ind) = exp(-1/sigma^2*norm(s - [gridx(i1,i2); ...
                gridv(i1,i3)])^2);
        end
    end
end

