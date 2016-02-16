warning ("off", "Octave:broadcast");
more off;
format long e;
% calculate max difference between numerical scheme and true solution
sinus_max_err_fn = @(N,X,V,h,eta) ...
    max(abs( sin(pi*(X-(N-1)*(h+h*eta))) - V(:,N) ));

% guess iterations with same error, depending on eta
step_fn = @(err,eta) ...
    floor((log(err).-log(eps))./log(1+2*eta));

% compare errors with formulas
exptected_err_fn_1 = @(n,h,eta) ...
    (1+2*eta).^n*eps;
% compare errors with formulas
exptected_err_fn = @(n,h,eta) ...
    (1+2*eta).^n*eps+(pi^2/2)*h*eta*(h+h*eta).*n;

% examples = [ (eta, h) ]
examples = {  [1e-1, 1e-2],
              [1e-1, 1e-3],
              [5e-2, 1e-3],
              [1e-2, 1e-3] };


x0 = [-2, 2];

for i = 1:length(examples)
    eta = examples{i}(1);
    h   = examples{i}(2);
    X = [x0(1)+h:h:x0(2)]';

    % guess iteration for given errors
    wanted_error  = 100;
    max_N = step_fn(wanted_error, eta);

    T = 0:h*(1+eta):max_N*h*(1+eta);

    V = transport_example(eta, h, max_N);

    % calculate real and estimated errors and skip some indices
    indizes = 1:floor((max_N)/10):max_N;
    max_errors = [
      indizes;
      sinus_max_err_fn(indizes, X, V, h, eta);
      exptected_err_fn(indizes-1, h, eta);
      exptected_err_fn_1(indizes-1, h, eta);
      (indizes-1).*(pi*pi/2)*h*h*eta*(1+eta);
    ]';

    % save errors to files for error plot
    % note: can't use the `save`-function since we have variable file names
    file_name = sprintf('./data/max_errors_eta_%.3f_h_%.3f.dat', eta, h);
    fid = fopen(file_name, "w");
    fdisp(fid, max_errors);
    fclose(fid);
end