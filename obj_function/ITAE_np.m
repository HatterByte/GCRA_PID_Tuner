function ITAE = ITAE_np(gains)
    Kp = gains(1);
    Ki = gains(2);
    Kd = gains(3);
    
    numerator = [1488.4];
    denominator = [1 0 -930.25]; 
    % numerator = [-24.525];
    % denominator = [1 0 -2180]; 
   
    system_tf = tf(numerator, denominator);
    controller_tf = pid(Kp, Ki, Kd);
    
    closed_loop_tf = feedback(controller_tf * system_tf, 1);
    
    t = 0:0.001:10;
    [system_output, t] = step(closed_loop_tf, t);
    error = 1 - system_output;
    ITAE_value = trapz(t, t .* abs(error));
    
    penalty = 0;
    % limit = [3.5, 11, 1];
    % if Kp > limit(1)
    %     penalty = penalty + (1 - limit(1))^2;
    % end
    % if Ki > limit(2)
    %     penalty = penalty + (1 - limit(2))^2;
    % end
    % if Kd > limit(3)
    %     penalty = penalty + (1 - limit(3))^2;
    % end

    ITAE = ITAE_value + 1e-3 * penalty;
end
