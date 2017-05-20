m = [10; 5];
s = [0.2; 0.1];
I = [m(1) * s(1)^2 / 12; m(2) * s(2)^2 / 12];

q0 = [s(1)/2; 0; 0; s(1)+s(2)/2; 0; 0];
tK = 20;

[t, q, dq, ddq] = baumgart(q0, tK, s, m, I);

figure('units','points','Position', [10, 10, 500, 700])
anim = subplot(1, 2, 1);
ener = subplot(1, 2, 2);
set(anim, 'units','points','Position', [25, 25, 450, 450])
set(ener, 'units','points','Position', [25, 525, 450, 150])
axis(anim, [-0.5 0.5 -0.5 0.5])

g = 9.81;
e = g * (m(1)*q(2,:) + m(2)*q(5,:)) + (m(1)*(dq(1,:).^2 + dq(2,:).^2) + m(2)*(dq(4,:).^2 + dq(5,:).^2) + I(1)*dq(3,:).^2 + I(2)*dq(6,:).^2) / 2;
plot(ener, t, e);

for i = 1:size(q, 2) - 1
    x1 = q(1, i) - s(1)*cos(q(3, i))/2;
    y1 = q(2, i) - s(1)*sin(q(3, i))/2;
    x2 = q(1, i) + s(1)*cos(q(3, i))/2;
    y2 = q(2, i) + s(1)*sin(q(3, i))/2;
    
    x3 = q(4, i) - s(2)*cos(q(6, i))/2;
    y3 = q(5, i) - s(2)*sin(q(6, i))/2;
    x4 = q(4, i) + s(2)*cos(q(6, i))/2;
    y4 = q(5, i) + s(2)*sin(q(6, i))/2;
    
    h1 = line(anim, [x1 x2], [y1 y2]);
    h2 = line(anim, [x3 x4], [y3 y4]);
    pause(t(i + 1) - t(i))
    disp(q(6,i))
    delete(h1)
    delete(h2)
end
