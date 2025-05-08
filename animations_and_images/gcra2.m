function[Score,Position,FineConvergence]=gcra2(Search_Agents,Max_iterations,Lower_bound,Upper_bound,dimension,objective)
Position=zeros(1,dimension);
Score=inf; 
Gcanerats=init(Search_Agents,dimension,Upper_bound,Lower_bound);
Convergence=zeros(1,Max_iterations);
FineConvergence = [];
l=1;
% k = 0;
% filename = 'animation.gif'; 
Alpha_pos1=Position;
Alpha_score=Score;
for i=1:size(Gcanerats,1)  
        
        Gcanerats(i,:) = min(max(Gcanerats(i,:), Lower_bound), Upper_bound);               
        
        fitness=objective(Gcanerats(i,:));
        FineConvergence = [FineConvergence fitness];
        if fitness<Score
            FineConvergence = [FineConvergence fitness];
            Score=fitness; 
            Position=Gcanerats(i,:);
            Alpha_pos1=Position;
            Alpha_score=Score;
% --- Start Animation Code ---
% figure(1);
% cla; 
% 
% % 1. Calculate fitness values for each agent
% fitness_values = zeros(size(Gcanerats,1),1);
% for i = 1:size(Gcanerats,1)
%     fitness_values(i) = objective(Gcanerats(i,:));
% end
% 
% % 2. Normalize fitness for color mapping
% normalized_fitness = rescale(fitness_values); 
% 
% % 3. Scatter plot agents with colors based on fitness
% scatter3(Gcanerats(:,1), Gcanerats(:,2), Gcanerats(:,3), 50, normalized_fitness, 'filled');
% colormap(jet);  % You can change 'jet' to 'hot', 'parula', etc.
% colorbar;       % Show color scale
% hold on;
% 
% % 4. Highlight best position separately
% scatter3(Position(1), Position(2), Position(3), 100, 'r', 'filled'); % Bigger red dot
% 
% % 5. Axes and labels
% xlabel('Kp'); ylabel('Ki'); zlabel('Kd');
% title(['frame ', num2str(k)]);k = k+1;
% grid on;
% xlim([Lower_bound(1) Upper_bound(1)]);
% ylim([Lower_bound(2) Upper_bound(2)]);
% zlim([Lower_bound(3) Upper_bound(3)]);
% 
% drawnow; % Force MATLAB to draw now
% pause(0.005); % Small pause to control animation speed
% % Capture the plot as an image
% frame = getframe(gcf);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im, 256);
% 
% % Write to the GIF File
% if k == 1
%     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
% else
%     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
% end
% % --- End Animation Code ---
            
        end
        
 end

while l<Max_iterations+1
    Alpha_pos=Alpha_pos1;
   GR_m=randperm(Search_Agents-1,1); 
   GR_rho=0.5;
   GR_r= Alpha_score-l*(Alpha_score/Max_iterations);
    x = 1;
    y = 4;
    GR_mu = floor((y-x).*rand(1,1) + x);
    GR_c=rand;
    GR_alpha=2*GR_r*rand-GR_r;
    GR_beta=2*GR_r*GR_mu-GR_r;
    
    for i=1:size(Gcanerats,1)
        for j=1:size(Gcanerats,2)  
            Gcanerats(i,j)= (Gcanerats(i,j)+Alpha_pos(j))/2;
            Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));
        end
    end
    for i=1:size(Gcanerats,1)
        for j=1:size(Gcanerats,2)  
           if rand<GR_rho
                 Gcanerats(i,j)= Gcanerats(i,j)+GR_c*(Alpha_pos(j)-GR_r*Gcanerats(i,j)); 
                 Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));              
        
                 fitness=objective(Gcanerats(i,:));
                 % FineConvergence = [FineConvergence fitness];
                  if fitness<Score 
                      FineConvergence = [FineConvergence fitness];
                        Score=fitness; 
                        Position=Gcanerats(i,:);
% % --- Start Animation Code ---
% figure(1);
% cla; 
% 
% % 1. Calculate fitness values for each agent
% fitness_values = zeros(size(Gcanerats,1),1);
% for i = 1:size(Gcanerats,1)
%     fitness_values(i) = objective(Gcanerats(i,:));
% end
% 
% % 2. Normalize fitness for color mapping
% normalized_fitness = rescale(fitness_values); 
% 
% % 3. Scatter plot agents with colors based on fitness
% scatter3(Gcanerats(:,1), Gcanerats(:,2), Gcanerats(:,3), 50, normalized_fitness, 'filled');
% colormap(jet);  % You can change 'jet' to 'hot', 'parula', etc.
% colorbar;       % Show color scale
% hold on;
% 
% % 4. Highlight best position separately
% scatter3(Position(1), Position(2), Position(3), 100, 'r', 'filled'); % Bigger red dot
% 
% % 5. Axes and labels
% xlabel('Kp'); ylabel('Ki'); zlabel('Kd');
% title(['frame ', num2str(k)]);k = k+1;
% grid on;
% xlim([Lower_bound(1) Upper_bound(1)]);
% ylim([Lower_bound(2) Upper_bound(2)]);
% zlim([Lower_bound(3) Upper_bound(3)]);
% 
% drawnow; % Force MATLAB to draw now
% pause(0.005); % Small pause to control animation speed
% % Capture the plot as an image
% frame = getframe(gcf);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im, 256);
% 
% % Write to the GIF File
% if k == 1
%     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
% else
%     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
% end
% % --- End Animation Code ---
                  else
                      Gcanerats(i,j)= Gcanerats(i,j)+GR_c*(Gcanerats(i,j)-GR_alpha*Alpha_pos(j)); 
                      Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));

                       fitness=objective(Gcanerats(i,:));
                       FineConvergence = [FineConvergence fitness];
                      if fitness<Score 
                          FineConvergence = [FineConvergence fitness];
                            Score=fitness; 
                            Position=Gcanerats(i,:);
% % --- Start Animation Code ---
% figure(1);
% cla; 
% 
% % 1. Calculate fitness values for each agent
% fitness_values = zeros(size(Gcanerats,1),1);
% for i = 1:size(Gcanerats,1)
%     fitness_values(i) = objective(Gcanerats(i,:));
% end
% 
% % 2. Normalize fitness for color mapping
% normalized_fitness = rescale(fitness_values); 
% 
% % 3. Scatter plot agents with colors based on fitness
% scatter3(Gcanerats(:,1), Gcanerats(:,2), Gcanerats(:,3), 50, normalized_fitness, 'filled');
% colormap(jet);  % You can change 'jet' to 'hot', 'parula', etc.
% colorbar;       % Show color scale
% hold on;
% 
% % 4. Highlight best position separately
% scatter3(Position(1), Position(2), Position(3), 100, 'r', 'filled'); % Bigger red dot
% 
% % 5. Axes and labels
% xlabel('Kp'); ylabel('Ki'); zlabel('Kd');
% title(['frame ', num2str(k)]);k = k+1;
% grid on;
% xlim([Lower_bound(1) Upper_bound(1)]);
% ylim([Lower_bound(2) Upper_bound(2)]);
% zlim([Lower_bound(3) Upper_bound(3)]);
% 
% drawnow; % Force MATLAB to draw now
% pause(0.005); % Small pause to control animation speed
% % Capture the plot as an image
% frame = getframe(gcf);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im, 256);
% 
% % Write to the GIF File
% if k == 1
%     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
% else
%     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
% end
% % --- End Animation Code ---
                      end
                  end
            else
                
                 Gcanerats(i,j)= Gcanerats(i,j)+GR_c*(Alpha_pos(j)-GR_mu*Gcanerats(GR_m,j));
                 Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));
        
                 fitness=objective(Gcanerats(i,:));
                 % FineConvergence = [FineConvergence fitness];
                  if fitness<Score 
                      FineConvergence = [FineConvergence fitness];
                        Score=fitness; 
                        Position=Gcanerats(i,:);
% % --- Start Animation Code ---
% figure(1);
% cla; 
% 
% % 1. Calculate fitness values for each agent
% fitness_values = zeros(size(Gcanerats,1),1);
% for i = 1:size(Gcanerats,1)
%     fitness_values(i) = objective(Gcanerats(i,:));
% end
% 
% % 2. Normalize fitness for color mapping
% normalized_fitness = rescale(fitness_values); 
% 
% % 3. Scatter plot agents with colors based on fitness
% scatter3(Gcanerats(:,1), Gcanerats(:,2), Gcanerats(:,3), 50, normalized_fitness, 'filled');
% colormap(jet);  % You can change 'jet' to 'hot', 'parula', etc.
% colorbar;       % Show color scale
% hold on;
% 
% % 4. Highlight best position separately
% scatter3(Position(1), Position(2), Position(3), 100, 'r', 'filled'); % Bigger red dot
% 
% % 5. Axes and labels
% xlabel('Kp'); ylabel('Ki'); zlabel('Kd');
% title(['frame ', num2str(k)]);k = k+1;
% grid on;
% xlim([Lower_bound(1) Upper_bound(1)]);
% ylim([Lower_bound(2) Upper_bound(2)]);
% zlim([Lower_bound(3) Upper_bound(3)]);
% 
% drawnow; % Force MATLAB to draw now
% pause(0.005); % Small pause to control animation speed
% % Capture the plot as an image
% frame = getframe(gcf);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im, 256);
% 
% % Write to the GIF File
% if k == 1
%     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
% else
%     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
% end
% % --- End Animation Code ---
                  else
                      Gcanerats(i,j)= Gcanerats(i,j)+GR_c*(Gcanerats(GR_m,j)-GR_beta*Alpha_pos(j)); 
                      Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));

                      fitness=objective(Gcanerats(i,:));
                      % FineConvergence = [FineConvergence fitness];
                      if fitness<Score 
                          FineConvergence = [FineConvergence fitness];
                            Score=fitness; 
                            Position=Gcanerats(i,:);
%                             % --- Start Animation Code ---
%                             figure(1);
%                             cla;
% 
%                             % 1. Calculate fitness values for each agent
%                             fitness_values = zeros(size(Gcanerats,1),1);
%                             for i = 1:size(Gcanerats,1)
%                                 fitness_values(i) = objective(Gcanerats(i,:));
%                             end
% 
%                             % 2. Normalize fitness for color mapping
%                             normalized_fitness = rescale(fitness_values);
% 
%                             % 3. Scatter plot agents with colors based on fitness
%                             scatter3(Gcanerats(:,1), Gcanerats(:,2), Gcanerats(:,3), 50, normalized_fitness, 'filled');
%                             colormap(jet);  % You can change 'jet' to 'hot', 'parula', etc.
%                             colorbar;       % Show color scale
%                             hold on;
% 
%                             % 4. Highlight best position separately
%                             scatter3(Position(1), Position(2), Position(3), 100, 'r', 'filled'); % Bigger red dot
% 
%                             % 5. Axes and labels
%                             xlabel('Kp'); ylabel('Ki'); zlabel('Kd');
%                             title(['frame ', num2str(k)]);k = k+1;
%                             grid on;
%                             xlim([Lower_bound(1) Upper_bound(1)]);
%                             ylim([Lower_bound(2) Upper_bound(2)]);
%                             zlim([Lower_bound(3) Upper_bound(3)]);
% 
%                             drawnow; % Force MATLAB to draw now
%                             pause(0.005); % Small pause to control animation speed
%                             % Capture the plot as an image
% frame = getframe(gcf);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im, 256);
% 
% % Write to the GIF File
% if k == 1
%     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
% else
%     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
% end
%                             % --- End Animation Code ---
                      end
                  end
            end
            Alpha_pos1=Position;
            Alpha_score=Score;    
                        
        end
    end

% % --- Start Animation Code ---
% figure(1);
% cla; 
% 
% % 1. Calculate fitness values for each agent
% fitness_values = zeros(size(Gcanerats,1),1);
% for i = 1:size(Gcanerats,1)
%     fitness_values(i) = objective(Gcanerats(i,:));
% end
% 
% % 2. Normalize fitness for color mapping
% normalized_fitness = rescale(fitness_values); 
% 
% % 3. Scatter plot agents with colors based on fitness
% scatter3(Gcanerats(:,1), Gcanerats(:,2), Gcanerats(:,3), 50, normalized_fitness, 'filled');
% colormap(jet);  % You can change 'jet' to 'hot', 'parula', etc.
% colorbar;       % Show color scale
% hold on;
% 
% % 4. Highlight best position separately
% scatter3(Position(1), Position(2), Position(3), 100, 'r', 'filled'); % Bigger red dot
% 
% % 5. Axes and labels
% xlabel('Kp'); ylabel('Ki'); zlabel('Kd');
% title(['frame ', num2str(k)]);k = k+1;
% grid on;
% xlim([Lower_bound(1) Upper_bound(1)]);
% ylim([Lower_bound(2) Upper_bound(2)]);
% zlim([Lower_bound(3) Upper_bound(3)]);
% 
% drawnow; % Force MATLAB to draw now
% pause(0.005); % Small pause to control animation speed
% % Capture the plot as an image
% frame = getframe(gcf);
% im = frame2im(frame);
% [imind, cm] = rgb2ind(im, 256);
% 
% % Write to the GIF File
% if k == 1
%     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
% else
%     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
% end
% % --- End Animation Code ---
    l=l+1;    
    Convergence(l)=Score;
end
end

function Pos=init(SearchAgents,dimension,upperbound,lowerbound)

Boundary= size(upperbound,2); 
if Boundary==1
    Pos=rand(SearchAgents,dimension).*(upperbound-lowerbound)+lowerbound;
end

if Boundary>1
    for i=1:dimension
        ub_i=upperbound(i);
        lb_i=lowerbound(i);
        Pos(:,i)=rand(SearchAgents,1).*(ub_i-lb_i)+lb_i;
    end
end
end