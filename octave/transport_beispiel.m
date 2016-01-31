% Perform upwind method given by
%
%    v(n+1,i) = v(n,i) - lambda (v(n,i) - v(n,i-1))
%
% u0     - initial value function
% lambda - grid aspect ratio (time / space)
% N      - number of iterations
function V = upwind(u0, lambda, N)
    I = length(u0);
    V = zeros(N, I);
    V(1,:) = u0;
    for n = 1:N-1
        V(n+1,:) = V(n,:) - lambda * (V(n,:) - shift(V(n, :), 1));
    end
end

function V = beispiel(eta, h, N)
    % Setup Properties and Initial Conditions        
    % space dimensions [x0, xN]
    x0 = [-2,2];
    % grid ratios
    lambda = 1 + eta;
    dx  = h;

    % space vector
    x = x0(1)+dx:dx:x0(2);
    % initial values
    u0 = sin(pi*x);

    % Call Numerical Method
    V = upwind(u0, lambda, N);
    V = [x' V'];
end

step_fn = @(err,eta) floor((log(err) .- log(eps)) ./ log(1 + 2*eta));

errors = [0.1 1 6 100];

eta = 1e-1;
h   = 1e-2;

steps = step_fn(errors, eta);
N = steps(4);

V = beispiel(eta, h, N);
V = V(:, [1 steps]);
save 'data/V_sinus_eps_0.1_h_0.01.dat' V

h   = 1e-3;

V = beispiel(eta, h, N);
V = V(:, [1 steps]);
save 'data/V_sinus_eps_0.1_h_0.001.dat' V

eta   = 5e-2;
steps = step_fn(errors, eta);
N = steps(4);

V = beispiel(eta, h, N);
V = V(:, [1 steps]);
save 'data/V_sinus_eps_0.05_h_0.001.dat' V

eta   = 1e-2;
steps = step_fn(errors, eta);
N = steps(4);

V = beispiel(eta, h, N);
V = V(:, [1 steps]);
save 'data/V_sinus_eps_0.01_h_0.001.dat' V