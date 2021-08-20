function out = pd(x,F,thres)
    % Nonfluctuating
    out = 0.5*erfc(erfcinv(2*F)-sqrt(x));
    % Swerling1
    %out = exp(-thres/(1+(x)));
end

