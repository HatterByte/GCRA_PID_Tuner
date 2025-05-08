% clear
% clc

F = 'ITAE';
[lowerbound, upperbound, dimension, fitness] = fun_info(F);

Search_Agents = 50;       
Max_iterations = 30;   

[Score, Position, FineConvergence] = gcra(Search_Agents, Max_iterations, lowerbound, upperbound, dimension, fitness);
objective_func = func2str(fitness);
disp(['=== ', objective_func, ' ===']);
disp('Optimal Gains:'); 
disp(['Kp = ', num2str(Position(1)), ', Ki = ', num2str(Position(2)), ', Kd = ', num2str(Position(3))]);
disp(['Minimum ',objective_func,':']); disp(Score);
disp('-------------------------------------------------------')



figure;
 plot(FineConvergence);
    title([F, ' Convergence']);
    xlabel('Iteration'); ylabel(F);

