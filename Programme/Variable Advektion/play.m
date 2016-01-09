function play(x, U, t_pause)
	[N, I] = size(U);
	for n = 1 : N
        hold on;
		plot(x, U(n, :));
        plot(x,)
		waitforbuttonpressed();
        hold off;
	end
end