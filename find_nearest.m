function [ j_min, d_min ] = find_nearest( node, In_list_ID, x, P )
% Find the nearest node from nodes in the tree (In_list_ID) to the 
% node (x,P) and the associated minimum distance
% distance is Euclidean + Frobenoius norm

% reshaping
x_node = reshape([node(In_list_ID).x], [2, numel(In_list_ID)]).';
P_node = [node(In_list_ID).P];
P_rep = repmat(P, [1, numel(In_list_ID)]);

%Euclidean distance
d = sqrt( sum( (x_node - x).^2, 2) );

%Info distance (Frobenius norm)
dist_P = sqrt( sum( reshape( sum((P_node - P_rep).^2), [2, numel(In_list_ID)] ) ) );

% Find the minimum 
[d_min, j_min] = min(d + dist_P.');

