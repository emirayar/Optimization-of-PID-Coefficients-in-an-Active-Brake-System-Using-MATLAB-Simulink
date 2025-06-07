clc; clear;

% 0. Simulink model
mdl = 'ActiveBrakeSystem';

% 1. Initial Variables
x0 = [2, 1];           % [Kp, Ki] initial values
LB = [0, 0];             % Lower Boundaries (Kp, Ki >= 0)
UB = [1000, 100];          % Upper Boundaries

% 2. Objective function
objective_function = @(x) costFunction(x, mdl);

% 3. Optimization with fminsearchbnd
options = optimset('Display', 'iter', 'MaxIter', 10);
[x_opt, fval, exitflag, output] = fminsearchbnd(objective_function, x0, LB, UB, options);

% 4. Print Results
fprintf('Optimized Kp = %.4f\n', x_opt(1));
fprintf('Optimized Ki = %.4f\n', x_opt(2));

% 5. Run simulation with optimized parameters
simOut = sim(mdl, 'SimulationMode', 'normal', ...
             'SaveOutput', 'on', 'OutputSaveName', 'yout', ...
             'SaveTime', 'on', 'TimeSaveName', 'tout', ...
             'LoadInitialState', 'off', ...
             'SaveFormat', 'StructureWithTime', ...
             'StopTime', '10');

Simulink.sdi.view