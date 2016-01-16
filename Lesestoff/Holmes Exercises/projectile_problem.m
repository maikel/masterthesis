% ===========================================================================
% Solving y'' = -(1 + epsilon y)^(-2) for small epsilon
% ===========================================================================

% x_1 = y
% x_2 = y'

% x'_1 = x_2
% x'_2 = -(1 + epsilon x_1)^(-2)

% f(x) = (x_2, (1 + epsilon x_1)^(-2))

epsilon = 0.1;
dt = 0.01;
max_T = 3;

time = 0:dt:max_T;
N = length(time);

X = zeros(N, 2);
X(1,:) = [0, 1]; % y(0) = 0, y'(0) = 1
N_0 = 0;
% forward euler
f = @(x) [x(2), -(1 + epsilon*x(1))^(-2)];
for n = 1:N-1
    X(n+1,:) = X(n, :) + dt*f(X(n, :));
    if X(n+1,1) < eps
        N_0 = n;
        break;
    end
end

t = time(1:N_0);
% asymptotic solutions
y_0 = t.*(1 - 0.5*t);
y_1 = 0.333*t.^3.*(1 - 0.25*t);

hold on
plot(t, X(1:N_0,1), '-;numerical solution;', 'linewidth', 2)
plot(t, y_0, ':k;y_0;', 'linewidth', 2)
plot(t, y_0 + epsilon*y_1, '--k;y_0 + \epsilon y_1;', 'linewidth', 2)