% create plots for section 2.2 "Ein Beispiel fuer instabiles Verhalten"
%
% save gnuplot table data in data/max_errors_*.dat and data/V_sinus_*.dat
% files.

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
    wanted_errors  = [0.1 0.5 6 100];
    num_errors = length(wanted_errors);
    steps_to_error = step_fn(wanted_errors, eta);

    % make as many iterations as needed for the largest error
    max_N = steps_to_error(num_errors);
    V = transport_example(eta, h, max_N);

    % calculate real and estimated errors and skip some indices
    indizes = 1:floor((max_N-50)/10):max_N;
    max_errors = [
      indizes;
      sinus_max_err_fn(indizes, X, V, h, eta);
      exptected_err_fn(indizes-1, h, eta);
      exptected_err_fn_1(indizes-1, h, eta)
    ]';

    % save errors to files for error plot
    % note: can't use the `save`-function since we have variable file names
    file_name = sprintf('./data/max_errors_eta_%.3f_h_%.3f.dat', eta, h)
    fid = fopen(file_name, "w");
    fdisp(fid, max_errors);
    fclose(fid);

    % save numerical solution to file for example plot
    V = [X, V(:, steps_to_error)];
    file_name = sprintf('./data/V_sinus_eta_%.3f_h_%.3f.dat', eta, h)
    fid = fopen(file_name, "w");
    fdisp(fid, V);
    fclose(fid);
end