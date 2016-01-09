function U = advektion(u0, a, dx, dt, N)
    I = length(u0)
	U = zeros(N, I);
	cfl = a * dx/dt;
	U(1,:) = u0;
	for n = 1 : N-1
        V = prev(U(n,:));
		U(n+1, :) = U(n, :) - cfl.*(U(n, :) - V);
	end
end

function v = prev(u)
    I = length(u);
    v = zeros(size(u));
    v(1) = u(I);
    v(2:I) = u(1:I-1);
end