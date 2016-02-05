% Perform the upwind method given by
%
%       v(n+1,i) = v(n,i) - lambda(i)*(v(n,i) - v(n,i-1))
%
% Parameter
%       u0     - initial value function
%       lambda - grid aspect ratio times velocity, possibly space dependent
%       N      - number of iterations
function V = upwind(u0, lambda, N)
    I = length(u0);
    V = zeros(N, I);
    V(1,:) = u0;
    for n = 1:N-1
        V(n+1,:) = V(n,:) - lambda(:) .* (V(n,:) - shift(V(n, :), 1));
    end
end