x = linspace(-2,2,400);

# a = ones(size(x));
# a(30:50) = 1.5;
graphics_toolkit("gnuplot")

a = zeros(size(x))
X = ones(size(x))
X(100:200) = x(100:200)
a = 1.4 * exp(-1./(1 - X.^2))

u0 = zeros(size(x));
u0(80:120) = 1;

dx = 0.1;
dt = 0.115;
N = 1000;
play_speed = 0.05;

U = advektion(u0, a, dx, dt, N);
% play(x, U, play_speed);


for n = 1 : N
    hold off;
    plot(x, U(n, :));
    hold on;
    plot(x, a)
    axis([-2 2 -1 3])
    waitforbuttonpress();
end
