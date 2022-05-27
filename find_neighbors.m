function [ neighbor_ID, dist_xk2node_i, dInf_xk2node_i, P_prime_nei_list ] =...
    find_neighbors( x,P,node, R, alpha, radius_nbor, In_list_no_issue_ID, Is_only_neibor_ID )
%FIND_NEIGHBORS 
% finds the neighbors of (x,P) on the node(tree), for which the distance to
% (x,P) is lower than radius_nbor
% distanc= Euclidean+ Frobenius 

dim = numel(x);

x_neighbor_vec = [node(In_list_no_issue_ID).x].';
% Size of x_nei_mat: dim * number of neighbors
x_nei_mat = reshape( x_neighbor_vec, [dim, numel(x_neighbor_vec)/dim]);

% Size of P_nei_mat: dim * (dim * number of neighbors)
P_nei_mat = [node(In_list_no_issue_ID).P];


% Row vector which has Euclidean distance between node ii and each
% neiboring nodes
dne = sqrt( sum( (x.' - x_nei_mat).^2, 1) );

% Distance of P
if ~isempty(In_list_no_issue_ID)
    P_rep = repmat(P, [1, numel(In_list_no_issue_ID)]);
    dist_P = sqrt( sum( reshape( sum((P_nei_mat - P_rep).^2), [2, numel(In_list_no_issue_ID)] ) ) );
else
    dist_P = [];
end

dist_x_P = dne + dist_P; % compute the distance
Is_neighbor = dist_x_P < radius_nbor; % compare the distance with radius of neighborhood

% find neibors
neighbor_ID = In_list_no_issue_ID( Is_neighbor );


 
if Is_only_neibor_ID
    dist_xk2node_i = [];
    dInf_xk2node_i = [];
    P_prime_nei_list = [];
else
    
    
    % Row vector which has information distance from noissue_flag nodes to node ii
    [dig, dInf, P_prime_list] = dist_ig_mat( x_nei_mat, P_nei_mat, x.', P, alpha, R);

    dist_xk2node_i = dig( Is_neighbor ); % total cost
    dInf_xk2node_i = dInf( Is_neighbor ); % information cost
    P_prime_nei_list = P_prime_list(:,:, Is_neighbor);% loss-less convarinaces from noissue_flag nodes to node ii
end
