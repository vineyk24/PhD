% Define parameters
a = 0.7; % a > c
b = 0.5; % d > b
c = 0.4;
d = 0.9;
e = 0.35;
k = 0.45;

% Initial conditions
x1_0 = 0.05;
y1_0 = 0.15;
k = 0.15;

% Time span
tspan = [0 500];

% Define the system of ODEs
function dydt = odesystem(t, y, a, b, c, d, e,k)
    x1 = y(1);
    y1 = y(2);
    dx1_dt = x1 * (e * (1 - y1) - k*c*(2-x1-y1) * (1 - x1) * (1 - y1) + a * y1 - x1 * (e * (1 - y1) + a * y1));
    dy1_dt = y1 * (b * x1 - (k*d*(2-x1-y1) * (1 - x1) + e * x1) * (1 - y1) - b * x1 * y1);
    dydt = [dx1_dt; dy1_dt];
end

% Solve the ODE system using ode45
[t, y] = ode45(@(t, y) odesystem(t, y, a, b, c, d, e, k), tspan, [x1_0, y1_0]);

% Plot the results
figure;
plot(t, y(:, 1), 'r-', 'LineWidth', 1.5); % x1 vs. time
hold on;
plot(t, y(:, 2), 'b--', 'LineWidth', 1.5); % y1 vs. time
xlabel('Time');
ylabel('State Variables');
legend('x_1(t)', 'y_1(t)');
title('Simulation of the Differential Equations');
grid on;
hold off;
