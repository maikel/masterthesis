% -*- texinfo -*-
% @deftypefn {Function File} {@var{V} =} upwind (@var{u0}, @var{a}, @var{lambda}, @var{N})
% Compute @var{N} time steps with the Upwind method and stores the results into 
% the solution matrix @var{V}. It applies the following scheme
% @tex
% $$v^{n+1}_i = v^n_i - a_i \lambda (v^n_i - v^n_{i-1}), \quad v^0 = u_0$$
% @end tex
% @ifnottex
%
% V(0, i) = U0(i)
%
% V(n+1,i) = V(n,i) - A(i)*LAMBDA*(V(n,i) - V(n, i-1))
% @end ifnottex
% @end deftypefn
function V = upwind(u0, a, lambda, N)
    I = length(u0);
    V = zeros(N, I);
    V(1,:) = u0;
    for n = 1:N-1
        V(n+1,:) = V(n,:) - a*lambda .* (V(n,:) - shift(V(n, :), 1));
    end
end