function obs_poly = obstacle_polyshape()
%This function defines an obstacle as a set of polyshapes
% This function is defined to use polyshape functionalities of Matlab

n=6; % number of obstacles
obs_poly(1:n)= struct('x',[], 'y',[]);

% Obstacle_1
obs_poly(1).x = [0.12 0.08 0.20 0.20] + [0.025 0.025 0.025 0.025];
obs_poly(1).y = [0.40 0.34 0.30 0.36];

% Obstacle_2
obs_poly(2).x = [0.21 0.35 0.33];
obs_poly(2).y = [0.63 0.60 0.72];


% Obstacle_3
obs_poly(3).x = [0.22 0.18 0.39];
obs_poly(3).y = [0.25 0.12 0.09];

% Obstacle_4
obs_poly(4).x = [0.27 0.27 0.33 0.43];
obs_poly(4).y = [0.54 0.41 0.23 0.29];

% Obstacle_5
obs_poly(5).x = [0.49 0.50 0.65 0.69];
obs_poly(5).y = [0.3 0.2 0.14 0.27];

% Obstacle_6
obs_poly(6).x = [0.43 0.46 0.60 0.60];
obs_poly(6).y = [0.53 0.39 0.40 0.55];
end

