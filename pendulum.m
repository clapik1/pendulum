m = [10];
s = [0.2];
I = [m(1) * s(1)^2 / 12];

q0 = [s(1)/2; 0; 0];
tK = 10;

[t, q, dq, ddq] = baumgart(q0, tK, s, m, I);

figure('units','points','Position', [10, 10, 500, 700])
anim = subplot(1, 2, 1);
ener = subplot(1, 2, 2);
set(anim, 'units','points','Position', [50, 25, 440, 450])
set(ener, 'units','points','Position', [50, 525, 440, 150])
axis(anim, [-0.5 0.5 -0.5 0.5])

g = 9.81;
e = g * m(1)*q(2,:) + (m(1)*(dq(1,:).^2 + dq(2,:).^2) + I(1)*dq(3,:).^2) / 2;
plot(ener, t, e);
plot(ener, t, g * m(1)*q(2,:));

for i = 1:size(q, 2) - 1
    x1 = q(1, i) - s(1)*cos(q(3, i))/2;
    y1 = q(2, i) - s(1)*sin(q(3, i))/2;
    x2 = q(1, i) + s(1)*cos(q(3, i))/2;
    y2 = q(2, i) + s(1)*sin(q(3, i))/2;
    
    h1 = line(anim, [x1 x2], [y1 y2]);
    pause(t(i + 1) - t(i))
    delete(h1)
end
