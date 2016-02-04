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
    V = V';
end

x0 = [-2, 2];

sinus_max_err_fn = @(N,X,V,h,eta) ...
    max(abs( sin(pi*(X-(N-1)*(h+h*eta))) - V(:,N) ));

exptected_err_fn_1 = @(n,h,eta) ...
    (1+2*eta).^n*eps;
exptected_err_fn = @(n,h,eta) ...
    (1+2*eta).^n*eps+(pi^2/2)*h*eta*(h+h*eta).*n;

step_fn = @(err,eta) ...
    floor((log(err).-log(eps))./log(1+2*eta));

% beispiele = [ (eta, h) ]
beispiele = { [1e-1, 1e-2],
              [1e-1, 1e-3],
              [5e-2, 1e-3],
              [1e-2, 1e-3] };

for i = 1:length(beispiele)
    eta = beispiele{i}(1);
    h   = beispiele{i}(2);
    X = [x0(1)+h:h:x0(2)]';

    wanted_errors  = [0.1 0.5 6 100];
    steps_to_error = step_fn(wanted_errors, eta);
    len_steps = length(steps_to_error);

    max_N = steps_to_error(len_steps);
    V = beispiel(eta, h, max_N);

    indizes = 1:floor((max_N-50)/10):max_N;
    max_errors = [
      indizes;
      sinus_max_err_fn(indizes, X, V, h, eta);
      exptected_err_fn(indizes-1, h, eta);
      exptected_err_fn_1(indizes-1, h, eta)
    ]';
    file_name = sprintf('data/max_errors_eta_%.3f_h_%.3f.dat', eta, h)
    fid = fopen(file_name, "w");
    fdisp(fid, max_errors);
    fclose(fid);
    V = [X, V(:, steps_to_error)];
    file_name = sprintf('data/V_sinus_eta_%.3f_h_%.3f.dat', eta, h)
    fid = fopen(file_name, "w");
    fdisp(fid, V);
    fclose(fid);
end

eta   = 1e-3;
h     = 1e-3;
T     = 0:h*(1+eta):25;
X     = [-2+h:h:2]';
max_N = length(T);
V     = beispiel(eta, h, max_N);

N = 1:100:max_N;

max_errors = [
    T(N);
    sinus_max_err_fn(N, X, V, h, eta);
    eps*exp(2*T(N));
    eps*exp(2*T(N)) + T(N).*(pi*pi/2)*h^2;
    T(N).*(pi*pi/2)*h^2;
]';

save 'data/max_errors_eta_0.001_h_0.001.dat' max_errors