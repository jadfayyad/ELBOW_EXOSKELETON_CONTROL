


syms a0 a1 a2 a3 a4 a5 a6 a7 real
syms theta1 theta2 T real

% Time points
t0 = 0;
t2 = T;
t1 = T/2;

% Equations
eqns = [...
    a0 + a1*t0 + a2*t0^2 + a3*t0^3 + a4*t0^4 + a5*t0^5 + a6*t0^6 + a7*t0^7 == theta1;
    a0 + a1*t1 + a2*t1^2 + a3*t1^3 + a4*t1^4 + a5*t1^5 + a6*t1^6 + a7*t1^7 == theta1 + (theta2-theta1)/2;
    a0 + a1*t2 + a2*t2^2 + a3*t2^3 + a4*t2^4 + a5*t2^5 + a6*t2^6 + a7*t2^7 == theta2;
    a1 + 2*a2*t0 + 3*a3*t0^2 + 4*a4*t0^3 + 5*a5*t0^4 + 6*a6*t0^5 + 7*a7*t0^6 == 0;
    a1 + 2*a2*t2 + 3*a3*t2^2 + 4*a4*t2^3 + 5*a5*t2^4 + 6*a6*t2^5 + 7*a7*t2^6 == 0;
    a1 + 2*a2*t1 + 3*a3*t1^2 + 4*a4*t1^3 + 5*a5*t1^4 + 6*a6*t1^5 + 7*a7*t1^6 == (theta2-theta1)/T * 1.8;
    2*a2 + 6*a3*t1 + 12*a4*t1^2 + 20*a5*t1^3 + 30*a6*t1^4 + 42*a7*t1^5 == 0
];

vars = [a0 a1 a2 a3 a4 a5 a6 a7];

% Solve symbolically
sol = solve(eqns, vars, 'Real', true);

% Display symbolic expressions
disp('a0 ='); disp(sol.a0)
disp('a1 ='); disp(sol.a1)
disp('a2 ='); disp(sol.a2)
disp('a3 ='); disp(sol.a3)
disp('a4 ='); disp(sol.a4)
disp('a5 ='); disp(sol.a5)
disp('a6 ='); disp(sol.a6)
disp('a7 ='); disp(sol.a7)

%% Example numeric values (CHANGE for your system)
theta1_val = 0;
theta2_val = 90;
T_val = 5;

m = 3;          % mass [kg]
l_cm = 0.15;     % center of mass distance [m]
I = 0.05;       % inertia [kg*m^2]
g = 9.81;       % gravity

%% Substitute coefficients
coeffs = double(subs([sol.a0 sol.a1 sol.a2 sol.a3 sol.a4 sol.a5 sol.a6 sol.a7], ...
                     {theta1, theta2, T}, ...
                     {theta1_val, theta2_val, T_val}));

%% Time vector
t = linspace(0, T_val, 1000);

%% Position
theta_t = polyval(flip(coeffs), t);
theta_t = deg2rad(theta_t);

%% Velocity
omega_poly = polyder(flip(coeffs));
omega_t = polyval(omega_poly, t);
omega_t = deg2rad(omega_t);

%% Acceleration
alpha_poly = polyder(omega_poly);
alpha_t = polyval(alpha_poly, t);
alpha_t = deg2rad(alpha_t);

%% Torque
M = (m*l_cm^2 + I).*deg2rad(alpha_t) + m*g*l_cm.*sin(deg2rad(theta_t));

%% Power
P = M .* deg2rad(omega_t);

%% Plot everything
figure

subplot(4,1,1)
plot(t, theta_t,'LineWidth',2)
grid on
ylabel('\theta (deg)')
title('Угловое положение')

subplot(4,1,2)
plot(t, omega_t,'LineWidth',2)
grid on
ylabel('\omega (deg/s)')
title('Угловая скорость')

subplot(4,1,3)
plot(t, M,'LineWidth',2)
grid on
ylabel('M (N*m)')
title('Момент')

subplot(4,1,4)
plot(t, P,'LineWidth',2)
grid on
ylabel('P (W)')
xlabel('t (s)')
title('Мощность')



% for simulink

%% =========================
% PREPARE DATA FOR SIMULINK FROM WORKSPACE
%% =========================

% Create time-series objects for Simulink
sim_data_theta = [t' theta_t'];      % [time, theta in degrees]
sim_data_omega = [t' omega_t'];      % [time, omega in deg/s]
sim_data_alpha = [t' alpha_t'];      % [time, alpha in deg/s²]

% For torque calculation (if needed in Simulink)
sim_data_M = [t' M'];                % [time, torque in N*m]
sim_data_P = [t' P'];                % [time, power in W]

% Save to workspace with specific names
assignin('base', 'theta_trajectory', sim_data_theta);
assignin('base', 'omega_trajectory', sim_data_omega);
assignin('base', 'alpha_trajectory', sim_data_alpha);
assignin('base', 'torque_profile', sim_data_M);
assignin('base', 'power_profile', sim_data_P);

disp('Data saved to workspace for Simulink From Workspace blocks');
disp('Variables created:');
disp('  - theta_trajectory  [time, angle in degrees]');
disp('  - omega_trajectory  [time, velocity in deg/s]');
disp('  - alpha_trajectory  [time, acceleration in deg/s²]');
disp('  - torque_profile    [time, torque in N*m]');
disp('  - power_profile     [time, power in W]');
L1 = 3*12.6 ;
L2 = 3*12.6^2 ;
L3 = 12.6^3 ;
Ma = 1;
Ka = 10;
Da = 6 ;