function [t, q, dq, ddq] = baumgart(q0, tK, s, m, I)
    t0 = 0;
    dq0 = zeros(size(q0, 1), 1);
    Y0 = [q0; dq0];

    [t, Y] = ode45(@(t, Y) H(t, Y, s, m, I), [t0 tK], Y0);

    ddq=zeros(size(Y,1), size(Y,2));
    for iter=1:size(Y,1)-1
        ddq(iter, :) = H(t(iter), Y(iter,:)', s, m, I); 
    end
    
    q = Y(:, 1:6)';
    dq = Y(:, 7:12)';
    ddq = ddq(:, size(q0,1)+1:end)';
end

function dY= H(t, Y, s, m, I)
    alfa=5;
    beta=5;
    
    q = Y(1:6, :);
    dq = Y(7:12, :);
    [F, Fq, G, M, Q] = macierze(s, m, I, q, dq);
    A=[M, Fq'; Fq, zeros(4, 4)];
    b=[Q; G - 2*alfa*Fq*dq - beta^2*F];

    x = A\b;
    dY(1:6, 1) = dq;
    dY(7:12) = x(1:6, 1);
end