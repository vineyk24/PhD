% Define parameters
a = 1.0; % a > c
b = 0.9; % b > d
c = 0.9;
d = 0.8;
e = 0.5; % e < min(a, b, c, d)

% Initial conditions
x1_0 = 0.4;
y1_0 = 0.4;

% Time span
tspan = [0 50];

% Define the system of ODEs
function dydt = odesystem(t, y, a, b, c, d, e)
    x1 = y(1);
    y1 = y(2);
    dx1_dt = x1 * (e * (1 - y1) - c * (1 - x1) * (1 - y1) + a * y1 - x1 * (e * (1 - y1) + a * y1));
    dy1_dt = y1 * (b * x1 - (d * (1 - x1) + e * x1) * (1 - y1) - b * x1 * y1);
    dydt = [dx1_dt; dy1_dt];
end

% Solve the ODE system using ode45
[t, y] = ode45(@(t, y) odesystem(t, y, a, b, c, d, e), tspan, [x1_0, y1_0]);

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

