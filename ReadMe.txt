===============================================================================================================================
Basic information
By running "main.m", you can start the modified IG-RRT* path-planning algorithm. 
===============================================================================================================================

Codes related with the Path-planning simulation:

main.m: The main function to run IG-RRT*

obstacle_multi.m & obstacle_polyshape.m :  specify the obstacles position and their shape for "multiple obstacles" enviroment

sample_x_P_randomly.m: It samples x and P randomly 

sample_polyshape_check.m: samples x outside of all obstacle. It is used in sample_x_P_randomly.m

find_nearest.m: It finds the nearest nodes based on the vector 2-norm and Frobenius norm

find_neighbors.m: It finds the set of neighboring nodes based on the vector 2-norm and Frobenius norm

find_parent.m: find parent of a node from the RRT* tree

scale_rrt_point.m: It conducts scaling in RRT* algorithm

error_ellipse.m: Calculate the length of the long & short axes, angle, and bounding box of a given ellipse

dist_ig_mat.m & dist_ig_mat2.m: The functions which calculate the RI-distance. The difference between these two functions is whether we want to measure the distance from the set of nodes to one node, or from one node to the set of nodes.

branch_and_bound_2D.m: It conducts branch and bound algorithm

find_optimal_path_2D.m: The function which find the optimal path from the existing nodes

check_lossless.m: check if a transition is lossless 

obstacle_multi.m: a definition of a sample enviroment
obstacle_polyshape: definition of obstacles to use polyshape functionalities of MATLAB

******** The function related for obstacle checking ********
boundary_check.m: It checks whether an ellipse intersect with regions's boundary

psuedo_obs_check_line_oct.m: It checks if a collision with obstacles during the transition between nodes occurs. 
psuedo_obs_check_line2_oct.m: The same with the above 

Is_two_lineseg_cross.m: check if two line segment intersect
make_octagon.m: generate a octagon from a bounding box for better obstacle checking
minDist_two_LineSeg_in.m: compute the minimum distance between two line segments. It is used for collision pre-checking
**********************************************************
===============================================================================================================================
Codes related with the plotting
plot_for_paper_multipleObs: This function plots results for "multiple obstacles" enviroment
plot_path_cost: It plots the path length as a function of number of samples. It should be run right after main.m
===============================================================================================================================