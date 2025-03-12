% Define parameters
a = 0.7; % a > c
b = 0.5; % d > b
c = 0.4;
d = 0.9;
e = 0.35;
k = 0.45;

% Time span
tspan = [0 1000];

% Define the grid of initial conditions
step_size = 0.01;
[X1_0, Y1_0] = meshgrid(0:step_size:1, 0:step_size:1);

% Initialize a matrix to store results
colors = nan(size(X1_0)); % NaN indicates undecided region

% Loop through each initial condition
for i = 1:numel(X1_0)
    % Initial conditions
    x1_0 = X1_0(i);
    y1_0 = Y1_0(i);
    
    % Solve the ODE system
    [~, y] = ode45(@(t, y) odesystem(t, y, a, b, c, d, e, k), tspan, [x1_0, y1_0]);
    
    % Get the final values
    x1_final = y(end, 1);
    y1_final = y(end, 2);
    
    % Determine the color based on the criteria
    if x1_final < 0.01 && y1_final < 0.01
        colors(i) = 1; % RED
    elseif x1_final > 0.99 && y1_final > 0.99
        colors(i) = 2; % BLUE
    end
end

% Plot the results
figure;
hold on;
for i = 1:numel(X1_0)
    if colors(i) == 1
        plot(X1_0(i), Y1_0(i), 'r.', 'MarkerSize', 10); % RED
    elseif colors(i) == 2
        plot(X1_0(i), Y1_0(i), 'b.', 'MarkerSize', 10); % BLUE
    end
end
xlabel('x_1(0)');
ylabel('y_1(0)');
title('Basin of Attraction');
grid on;
hold off;

% Define the ODE system as a nested function
function dydt = odesystem(t, y, a, b, c, d, e, k)
    x1 = y(1);
    y1 = y(2);
    dx1_dt = x1 * (e * (1 - y1) - k * c * (2 - x1 - y1) * (1 - x1) * (1 - y1) + a * y1 - x1 * (e * (1 - y1) + a * y1));
    dy1_dt = y1 * (b * x1 - (k * d * (2 - x1 - y1) * (1 - x1) + e * x1) * (1 - y1) - b * x1 * y1);
    dydt = [dx1_dt; dy1_dt];
end
