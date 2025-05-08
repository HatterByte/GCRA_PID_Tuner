function ISE = ISE(gains)
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
    % reference_input = ones(size(t));
    
    % system_output = lsim(closed_loop_tf, reference_input, t);
    [system_output, t] = step(closed_loop_tf, t);

    error = 1 - system_output;

        ISE_value = trapz(t, error.^2);

    penalty = 0;
    limit = [40,1500,10];
    if Kp > limit(1)
        penalty = penalty + (Kp - limit(1))^2;
    end
    if Ki > limit(2)
        penalty = penalty + (Ki - limit(2))^2;
    end
    if Kd > limit(3)
        penalty = penalty + (Kd - limit(3))^2;
    end
    ISE = ISE_value + 1e-5 * penalty;
end

