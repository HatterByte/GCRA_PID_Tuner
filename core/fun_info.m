function [lowerbound,upperbound,dimension,fitness] = fun_info(F)


switch F
    case 'F1'
        fitness = @F1;
        lowerbound=-100;
        upperbound=100;
        dimension=30;

    case 'ISE'
            fitness = @ISE;
            lowerbound = [0, 0, 0];
            upperbound = [50, 2500, 10];
            dimension = 3;

    case 'IAE'
            fitness = @IAE;
            lowerbound = [0, 0, 0];
            upperbound = [50, 2500, 10];
            dimension = 3;
            
    case 'ITAE'
            fitness = @ITAE;
            lowerbound = [1,  0.1,  0.1];
            upperbound = [4.775,  20,  1.992];
            dimension = 3;

    case 'ITSE'
            fitness = @ITSE;
            lowerbound = [0, 0, 0];
            upperbound = [50, 2500, 10];
            dimension = 3;
           
                   
end

end



% F1
function R = F1(x)
R=sum(x.^2);
end




