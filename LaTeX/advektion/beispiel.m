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

function V = beispiel(epsilon, h, N)
    % Setup Properties and Initial Conditions        
    % space dimensions [x0, xN]
    x0 = [-2,2];
    % grid ratios
    lambda = 1 + epsilon;
    dx  = h;
    dt  = lambda*h;
    % space vector
    x = x0(1)+dx:dx:x0(2);
    % initial values
    u0 = sin(pi*x);

    % Call Numerical Method
    V = upwind(u0, lambda, N);
    V = [x' V'];
end

epsilon = 1e-1;
h       = 1e-2;
N       = 220;

V = beispiel(epsilon, h, N);
save 'V_sinus_eps_0.1_h_0.01.dat' V

epsilon = 1e-1;
h       = 1e-3;
N       = 220;

V = beispiel(epsilon, h, N);
save 'V_sinus_eps_0.1_h_0.001.dat' V

epsilon = 1e-2;
h       = 1e-2;
N       = 220;

V = beispiel(epsilon, h, N);
save 'V_sinus_eps_0.01_h_0.01.dat' V