% Initialize project

clc;
clear;

% Add all folders to path
addpath(genpath(pwd));

% Loading system parameters
run('docs/system_parameters.m');

% Motor and gear calculations
run('docs/motor_gear_calculations.m');

% Trajectory planning
run('control/trajectory_planning.m');

disp('Project initialized successfully');
