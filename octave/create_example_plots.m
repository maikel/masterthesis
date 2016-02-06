% create plots for section 2.2 "Ein Beispiel fuer instabiles Verhalten"
%
% save gnuplot table data in data/max_errors_*.dat and data/V_sinus_*.dat
% files.

% guess iterations with same error, depending on eta
step_fn = @(err,eta) ...
    floor((log(err).-log(eps))./log(1+2*eta));

% examples = [ (eta, h) ]
examples = {  [1e-1, 1e-2],
              [1e-1, 1e-3],
              [5e-2, 1e-3] };

x0 = [-2, 2];

for i = 1:length(examples)
    eta = examples{i}(1);
    h   = examples{i}(2);
    X = [x0(1)+h:h:x0(2)]';

    % guess iteration for given errors
    % make as many iterations as needed for the largest error
    wanted_error  = 1;
    max_N = step_fn(wanted_error, eta);
    V = transport_example(eta, h, max_N);

    % save numerical solution to file for example plot
    V = [X, V(:, max_N)];
    file_name = sprintf('./data/V_sinus_eta_%.3f_h_%.3f.dat', eta, h);
    fid = fopen(file_name, "w");
    fdisp(fid, V);
    fclose(fid);
end