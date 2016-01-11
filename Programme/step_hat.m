% ============================================================================
%                          Auxiliary Functions
% ============================================================================

function u0 = initial_value_step_function(x, a, b)
    u0 = (a <= x) .* (x <= b);
end

function a = velocity_hat(x, epsilon=0.4)
    y = x .* (abs(x) <= 1) + ones(size(x)) .* (abs(x) > 1);
    a = 1 + epsilon * (1 - abs(y));
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
x = x0(1):dx:x0(2)-dx;

% advection velocity
a = velocity_hat(x, 0.3);

% initial values
u0 = 0.8 * initial_value_step_function(x, -2, -1.5);

% ============================================================================
%                           Numerical Method
% ============================================================================

V = upwind(u0, a, cfl, N);

% ============================================================================
%                           Printing to File
% ============================================================================

% Save data here and plot with gnuplot or tikz later

V = [x' V'];
a = [x' cfl*a'];

save 'output/a_step_hat.dat' a
save 'output/u_step_hat.dat' V