% Use the upwind(u0, lambda, N) method to solve
%
%       u_t(t,x) + u_x(t,x) = 0,   u(0,x) = sin(x)
%
% With lambda = 1 + eta. Returns data to use as gnuplot table.
% Parameter
%       eta - measure of "instabilty"
%       h   - grid length
%       N   - number of time steps
function V = transport_example(eta, h, N)
    % Setup Properties and Initial Conditions        
    % space dimensions [x0, xN]
    x0 = [-2,2];
    % grid ratios
    lambda = 1 + eta;

    % space vector
    x = x0(1)+h:h:x0(2);
    % initial values
    u0 = sin(pi*x);

    % Call Numerical Method
    V = upwind(u0, lambda, N);
    V = V';
end