% ============================================================================
%                          Auxiliary Functions
% ============================================================================

function v = prev(u)
    I = length(u);
    v = zeros(size(u));
    v(1) = u(I);
    v(2:I) = u(1:I-1);
end

function u0 = initial_value_step_function(x, a, b)
    u0 = (a <= x) .* (x <= b);
end

function a = velocity_hat(x, eps=0.4)
    y = x .* (abs(x) <= 1) + ones(size(x)) .* (abs(x) > 1);
    a = 1 + eps * (1 - abs(y));
end

% ============================================================================
%                   Properties and Initial Conditions
% ============================================================================

% space dimensions [x0, xN]
x0 = [-2,2];

% step sizes
dx  = 0.01;
cfl = 0.9;
dt  = cfl*dx;

% how many time steps to be done
N   = 1000;

% space vector
x = linspace(x0(1),x0(2),1+(x0(2)-x0(1))/dx);

% advection velocity
a = velocity_hat(x, 0.3);

% initial values
u0 = 0.8 * initial_value_step_function(x, -2, -1.5);

% ============================================================================
%                           Numerical Method
% ============================================================================

% V(t,x) solution matrix
%               * V(n, :)    - is a known solution to step n
%               * V(n+1, :)  - this is the solution that will be calculated

V      = zeros(N, length(u0));
V(1,:) = u0;

% perform Upwind method here
for n = 1:N-1
    V(n+1, :) = V(n, :) - a.*cfl .* (V(n,:) - shift(V(n,:), 1));
end

% ============================================================================
%                           Printing to File
% ============================================================================

% Save data here and plot with gnuplot or tikz later

V = [x' V'];
a = [x' cfl*a'];

save 'output/a.dat' a
save 'output/u.dat' V