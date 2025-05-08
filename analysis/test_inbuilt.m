% Automatically tune PID for minimum ISE-like performance
clear
clc
    numerator = [1488.4];
    denominator = [1 0 -930.25]; 
system_tf = tf(numerator, denominator);
opt = pidtuneOptions('DesignFocus', 'disturbance-rejection'); % Tunes for ISE
[controller_tf, info] = pidtune(system_tf, 'PID', opt);

% Display PID gains
Kp = controller_tf.Kp;
Ki = controller_tf.Ki;
Kd = controller_tf.Kd;
disp(['Kp = ', num2str(Kp), ', Ki = ', num2str(Ki), ', Kd = ', num2str(Kd)]);

closed_loop = feedback(pid(Kp,Ki,Kd) * system_tf, 1);
step(50 * closed_loop);



closed_loop_tf = feedback(controller_tf * system_tf, 1);

% Simulate step response with fine time resolution (critical for unstable systems)
t = 0:0.001:1; % Time vector (dt = 0.001 sec, simulate for 1 sec)
[y, t] = step(closed_loop_tf, t);

% Calculate ISE
error = 1 - y; % Step input reference = 1
ISE = trapz(t, error.^2); % Integral of squared error
disp(['ISE for pidtune PID: ', num2str(ISE)]);
% 
% % pidtune vs GCRA
% pidtune_pid = pid(-5097, -3.4e5, -19.1);
% gcra_pid = pid(-7.7e4, -2.7e5, -9.4e3); % From Run 5
% 
% cl_pidtune = feedback(pidtune_pid * system_tf, 1);
% cl_gcra = feedback(gcra_pid * system_tf, 1);
% 
% step(cl_pidtune, 'r', cl_gcra, 'b--');
% legend('pidtune', 'GCRA-Optimized');
% title('Step Response Comparison');

