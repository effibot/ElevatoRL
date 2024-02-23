function a = epsgreedy(s, w, eps, gridx, gridv, M, N, A)
Adim = length(A);
if rand < eps
    a = randi(Adim);
else
    q = zeros(Adim, 1);
    for a = 1:Adim
        q(a) = w'*getFeatures(s, a, gridx, gridv, M, N, Adim);
    end
    a = find(q == max(q), 1, 'first');
end
