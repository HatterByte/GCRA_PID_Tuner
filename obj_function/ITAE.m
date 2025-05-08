function ITAE = ITAE(gains)
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
    limit = [3, 11, 1];
    if Kp > limit(1)
        penalty = penalty + (1 - limit(1)/Kp)^2;
    end
    if Ki > limit(2)
        penalty = penalty + (1 - limit(2)/Ki)^2;
    end
    if Kd > limit(3) || Kd==0.1
        penalty = penalty + (1 - limit(3)/Kd)^2;
    end

    ITAE = ITAE_value + 1e-1 * penalty;
end
