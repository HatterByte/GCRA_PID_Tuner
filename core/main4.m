clear
clc

F = {'ISE','IAE','ITAE','ITSE'};
colors = {'r', 'b', 'g', 'k'};
figure;
% hold on; 
for i = 1:4

[lowerbound, upperbound, dimension, fitness] = fun_info(F{i});

Search_Agents = 30;       
Max_iterations = 10;   


[Score, Position, Convergence] = gcra(Search_Agents, Max_iterations, lowerbound, upperbound, dimension, fitness);

objective_func = func2str(fitness);
disp(['=== ', objective_func, ' ===']);
disp('Optimal Gains:'); 
disp(['Kp = ', num2str(Position(1)), ', Ki = ', num2str(Position(2)), ', Kd = ', num2str(Position(3))]);
disp(['Minimum ',objective_func,':']); disp(Score);
disp('-------------------------------------------------------')
 subplot(2, 2, i);
 plot(Convergence, colors{i}, 'LineWidth', 1.5);
    title([F{i}, ' Convergence']);
    xlabel('Iteration'); ylabel(F{i});
 % plot(Convergence, colors{i}, 'LineWidth', 1.5, 'DisplayName', objective_func);
end 
% xlabel('Iteration');
% ylabel('Objective Value');
% title('GCRA Convergence for All Performance Criteria');
% legend('show', 'Location', 'best');
grid on;
grid minor;
% hold off;

