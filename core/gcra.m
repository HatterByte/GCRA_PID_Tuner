function[Score,Position,Convergence]=gcra(Search_Agents,Max_iterations,Lower_bound,Upper_bound,dimension,objective)
Position=zeros(1,dimension);
Score=inf; 
Gcanerats=init(Search_Agents,dimension,Upper_bound,Lower_bound);
Convergence=zeros(1,Max_iterations);
l=1;
Alpha_pos=Position;
Alpha_score=Score;
for i=1:size(Gcanerats,1)  
        
        Gcanerats(i,:) = min(max(Gcanerats(i,:), Lower_bound), Upper_bound);               
        
        fitness=objective(Gcanerats(i,:));
        if fitness<Score
            Score=fitness; 
            Position=Gcanerats(i,:);
            Alpha_pos=Position;
            Alpha_score=Score;
        end
        
 end

while l<Max_iterations+1
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
                  if fitness<Score 
                        Score=fitness; 
                        Position=Gcanerats(i,:);
                  else
                      Gcanerats(i,j)= Gcanerats(i,j)+GR_c*(Gcanerats(i,j)-GR_alpha*Alpha_pos(j)); 
                      Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));

                       fitness=objective(Gcanerats(i,:));
                      if fitness<Score 
                            Score=fitness; 
                            Position=Gcanerats(i,:);
                      end
                  end
            else
                
                 Gcanerats(i,j)= Gcanerats(i,j)+GR_c*(Alpha_pos(j)-GR_mu*Gcanerats(GR_m,j));
                 Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));
        
                 fitness=objective(Gcanerats(i,:));
                  if fitness<Score 
                        Score=fitness; 
                        Position=Gcanerats(i,:);
                  else
                      Gcanerats(i,j)= Gcanerats(i,j)+GR_c*(Gcanerats(GR_m,j)-GR_beta*Alpha_pos(j)); 
                      Gcanerats(i,j) = min(max(Gcanerats(i,j), Lower_bound(j)), Upper_bound(j));

                      fitness=objective(Gcanerats(i,:));
                      if fitness<Score 
                            Score=fitness; 
                            Position=Gcanerats(i,:);
                      end
                  end
            end
            Alpha_pos=Position;
            Alpha_score=Score;    
                        
        end
    end
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