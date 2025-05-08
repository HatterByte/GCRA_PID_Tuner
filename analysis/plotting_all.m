clc;
clear;
close all;

numerator = [1488.4];
denominator = [1 0 -930.25];
plant = tf(numerator, denominator);

gains = struct( ...
    'ISE',  struct('Kp', 30.65,   'Ki', 1889.9395, 'Kd', 7.5218), ...
    'IAE',  struct('Kp', 37.144,  'Ki', 1744.82,   'Kd', 5.0092), ...
    'ITAE', struct('Kp', 33.5061, 'Ki', 1897.3994, 'Kd', 0.77143), ...
    'ITSE', struct('Kp', 39.4455, 'Ki', 1493.432,  'Kd', 7.0386) ...
);

% Time vector for simulation
t = 0:0.001:5;

% Initialize figure
figure;
hold on;
grid on;
title('Step Responses for Optimized PID Gains');
xlabel('Time (s)');
ylabel('Output');
colors = ['r', 'g', 'b', 'm'];
criteria_names = fieldnames(gains);
xlim([0 0.4]);   
ylim([0 1.05]);   

for i = 1:length(criteria_names)
    criterion = criteria_names{i};
    params = gains.(criterion);

    s = tf('s');
    PID = params.Kp + params.Ki/s + params.Kd*s;

    closed_loop_tf = feedback(PID * plant, 1);

    [response, t_response] = step(closed_loop_tf, t);

    plot(t_response, response, 'DisplayName', criterion, 'Color', colors(i), 'LineWidth', 1.5);
end

legend('Location', 'best');
hold off;