warning ("off", "Octave:broadcast");
format long e;
% calculate max difference between numerical scheme and true solution
sinus_max_err_fn = @(N,X,V,h,eta) ...
    max(abs( sin(pi*(X-(N-1)*(h+h*eta))) - V(:,N) ));

eta   = 1e-3;
h     = 1e-3;
T     = 0:h*(1+eta):25;
X     = [-2+h:h:2]';
max_N = length(T);
V     = transport_example(eta, h, max_N);

N = 1:100:max_N;

max_errors = [
    T(N);
    sinus_max_err_fn(N, X, V, h, eta);
    eps*exp(2*T(N));
    eps*exp(2*T(N)) + T(N).*(pi*pi/2)*h^2;
    T(N).*(pi*pi/2)*h^2;
]';

save 'data/max_errors_small_eta_0.001.dat' max_errors