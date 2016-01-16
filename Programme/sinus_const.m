% ============================================================================
%                          Auxiliary Functions
% ============================================================================

function u0 = initial_value_sin_function(x, w=1.0, p=0.0)
    u0 = sin(w*x + p);
end

function a = velocity_const(x, delta=0.4)
    a = ones(size(x)) * (1 + delta);
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
a = velocity_const(x, 0.3);

% initial values
u0 = 0.8 * initial_value_sin_function(x, pi);

% ============================================================================
%                           Numerical Method
% ============================================================================

V = upwind(u0, a, cfl, N);

% calculate reference solution
U = zeros(size(V));
U(1,:) = u0;
for n = 2:N
    U(n, :) = 0.8 * initial_value_sin_function(x-a*n*dt, pi);
end

% ============================================================================
%                           Printing to File
% ============================================================================

% Save data here and plot with gnuplot or tikz later

V = [x' V'];
U = [x' U'];
a = [x' cfl*a'];

save 'output/a_sin_const.dat' a
save 'output/u_sin_const.dat' 
save 'output/ref_sin_const.dat' U