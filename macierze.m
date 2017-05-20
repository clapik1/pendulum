function [F, Fq, G, M, Q] = macierze(s, m, I, q, dq)
    F = [q(1) - s(1)*cos(q(3))/2; q(2) - s(1)*sin(q(3))/2];
    
    Fq = zeros(2, 3);
    Fq(1:2, 1:2) = eye(2);
    Fq(1, 3) = s(1)*sin(q(3))/2;
    Fq(2, 3) = -s(1)*cos(q(3))/2;
    
    G = [-s(1)/2*cos(q(3))*dq(3)^2; -s(1)/2*sin(q(3))*dq(3)^2];
    
    M = zeros(3);
    M(1, 1) = m(1);
    M(2, 2) = m(1);
    M(3, 3) = I(1);
    
    g = [0; -9.81];
    Q = [m(1)*g; 0];
end
