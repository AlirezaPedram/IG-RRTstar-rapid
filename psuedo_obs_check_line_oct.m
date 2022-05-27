function issue_flag = psuedo_obs_check_line_oct(x, node_jj, obstacle_edge, R, chi, bound, num_props, prop)
% This function detemines if the transition from the node_jj to x is
% collison-free or not
% 0 (=false) means the transition is collision free
% 1 (=true) means collision happens
% Inputs of this function are
% x: the newly sampled point
% node_jj: The existing nodes information (See the beginning of "main.m for more information")
% obstacle_edge: The information of obstacles
% R: noise power
% chi: The scalar value which determines the confidence bound
% bound: This define the region of the enviroment


%% Initialize Issue_flag
issue_flag = false;
issue_boundary = true;

%% First pre-check
% checks if line segment connecting centers of 
% two ellipses and a obstacle edge are crossing

% Next,compute the distance between the line segment connecting centers of 
% two ellipses and a obstacle edge is
% if the distance is lower than the minor axis of P_0, the collision occurs
% if the distance is greater that major axis of P_hat, the collison does
% not occur

% initial and final position of connecting line segment
x0 = node_jj.x;
xF = x;

num_obs_edge = length(obstacle_edge); % number of obstacle edges

% reshaping the information of edges (start and end points)
obs_st = reshape([obstacle_edge(:).start], [2, num_obs_edge]).';
obs_end = reshape([obstacle_edge(:).end], [2, num_obs_edge]).';

% [obs_st1, obs_end1; obs_st2, obs_end2; ...]
obstacle_edge_list = [obs_st, obs_end];
obs_edge_delete_list = zeros(num_obs_edge, 1);


% covariance and minor axis at x_0
rb_Pst = node_jj.rb;
P0 = node_jj.P;

% compute the covarinace  and major axis before measurement at the sampled x
P_hat = P0 + R * norm(xF - x0);
[ra_Phat, ~, ~, ~] = error_ellipse(xF, P_hat, chi);

% loop over all edges
for k = 1:num_obs_edge
    x2_st = obstacle_edge(k).start;
    x2_end = obstacle_edge(k).end;
    
    % check direct collision here
    [min_dist, is_cross] = minDist_two_LineSeg_in(x0, xF, x2_st, x2_end);
    
    % If there is an obstacle_edge which minimum distance to
    % the line segment x(k)-x(k+1) is shorter than rb of P(k), then the
    % collision will happen at the some points. So if we find that
    % obstacle_edge, this code outputs issue_flag = true.
    if is_cross == true || min_dist <= rb_Pst
        issue_flag = true;
        return
    
    % If the minimum distance between them is larger than "ra" of P_hat,
    % then the collision will not happen with that obstacle edge.
    % Hence, we can delete that edge from the list used later.
    elseif min_dist > ra_Phat
        obs_edge_delete_list(k) = k;
    end
end

% deletes edges for which the collision cannot happen
obstacle_edge_list( (obs_edge_delete_list ~= 0), : ) = [];
num_obs_edge = size(obstacle_edge_list, 1);

% Similar check for outer boundry 
boundary_X_dist = min( [( x0(1) - bound(1).x(1) ), ( xF(1) - bound(1).x(1) )...
    ( bound(1).x(2) - x0(1) ), ( bound(1).x(2) - xF(1) ) ] );
boundary_Y_dist = min( [( x0(2) - bound(2).x(1) ), ( xF(2) - bound(2).x(1) )...
    ( bound(2).x(2) - x0(2) ), ( bound(2).x(2) - xF(2) ) ] );


if boundary_X_dist > ra_Phat && boundary_Y_dist > ra_Phat
    issue_boundary = false;
elseif boundary_X_dist <= rb_Pst || boundary_Y_dist <= rb_Pst
    issue_flag = true;
    return
end

if num_obs_edge == 0 && issue_boundary == false
    issue_flag = false;
    return
end

%% Second pre-check: check whether two line segments connecting the outer of two ellipses edges 
%  have intersection with obstacle edges.

% inverse of initial and final covariances
inv_P0 = inv(P0);
inv_Pend = inv(P_hat);

D = -(xF(1) - x0(1)) / ( xF(2) - x0(2));

edge_st_x = x0(1)*ones(2,1) + [1; -1]...
    * sqrt( chi/(inv_P0(1,1) + 2*inv_P0(1,2)*D + inv_P0(2,2)*D^2 ) );
edge_st_y = x0(2)*ones(2,1) + D .* (edge_st_x - x0(1));
edge_st = [edge_st_x, edge_st_y];

edge_end_x = xF(1)*ones(2,1) + [1; -1]...
    * sqrt( chi/(inv_Pend(1,1) + 2*inv_Pend(1,2)*D + inv_Pend(2,2)*D^2 ) );
edge_end_y = xF(2)*ones(2,1) + D .* (edge_end_x - xF(1));
edge_end = [edge_end_x, edge_end_y];

d_st1_end1 = norm(edge_st(1,:) - edge_end(1,:));
d_st1_end2 = norm(edge_st(1,:) - edge_end(2,:));

if d_st1_end1 < d_st1_end2
    edge_list = [edge_st(1,:), edge_end(1,:); edge_end(2,:), edge_st(2,:)];
else
    edge_list = [edge_st(1,:), edge_end(2,:); edge_end(1,:), edge_st(2,:)];
end

for k = 1:num_obs_edge
    line_seg1 = [edge_list(:,1:2), edge_list(:,3:4) - edge_list(:,1:2)];
    line_seg2 = [obstacle_edge_list(k, 1:2), ...
        obstacle_edge_list(k, 3:4) - obstacle_edge_list(k, 1:2)];
    for i = 1:2
        is_cross2 = Is_two_lineseg_cross(line_seg1(i,:), line_seg2);
        if is_cross2 == true
            issue_flag = true;
            return
        end
    end
end

% Similar check for outer boundry
edge_list_x = edge_list(:,1:3);
edge_list_y = edge_list(:,2:4);

boundary_X_dist2 = min( [ ( edge_list_x(:) - bound(1).x(1) );...
    (bound(1).x(2) - edge_list_x(:) ) ] );
boundary_Y_dist2 = min( [ ( edge_list_y(:) - bound(2).x(1) );...
    (bound(2).x(2) - edge_list_y(:) ) ] );
if boundary_X_dist2 <= 0 || boundary_Y_dist2 <= 0
    issue_flag = true;
    return
end


%% Check collisions by using the inscribing octagon or rectangle at intermediate points
move_vec = (xF - x0)/(num_props+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create bounding boxes for eiilpses with the number of "num_props"
for kk = 1:num_props
    prop(kk).x = x0 + move_vec*kk;
    if kk > 1
        dt = norm(prop(kk).x-prop(kk-1).x);
        prop(kk).P = prop(kk-1).P + R*dt;
    else
        dt = norm(prop(kk).x-x0);
        prop(kk).P = P0 + R*dt;
    end
    [prop(kk).ra,prop(kk).rb,prop(kk).ang,prop(kk).ellipse_rect] = error_ellipse(prop(kk).x,prop(kk).P,chi);    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Do you check collision with box or octagon?
is_oct = true;
if mod(prop(2).ang, pi/2) < pi/180*10
    is_oct = false;
end

for kk = 1:length(prop)
%     prop(kk).flag = 0;
    rect = prop(kk).ellipse_rect;

    if is_oct == true
        bound_para = make_octagon(prop(kk).x, prop(kk).ra, prop(kk).rb, prop(kk).ang, rect);
    else
        vertix = [rect(1), rect(2), rect(1)+rect(3), rect(2);... % bottom-horizontal
            rect(1)+rect(3), rect(2), rect(1)+rect(3), rect(2)+rect(4);... % right-vertical
            rect(1), rect(2)+rect(4), rect(1)+rect(3), rect(2)+rect(4);... % top-horizontal
            rect(1), rect(2), rect(1), rect(2)+rect(4)]; % left-vertical
        bound_para = [vertix(:,1:2), vertix(:,3:4) - vertix(:,1:2)];
    end
    
    for bb = 1:num_obs_edge
        obs_edge = [obstacle_edge_list(bb, 1:2), ...
            obstacle_edge_list(bb, 3:4) - obstacle_edge_list(bb, 1:2)];
        % For more information, please check this website.
        % https://stackoverflow.com/questions/4977491/determining-if-two-line-segments-intersect/4977569#4977569
        % for each edge of ellpse's bounding box
        for j = 1:size(bound_para,1)
            is_cross = Is_two_lineseg_cross(bound_para(j,:), obs_edge);
            if is_cross == true
                issue_flag = true;
                return
            end
        end
    end

    % In case the boundary is a rectangle that stand upright, then
    % rectangle is enough to check collision with boundaries.
    if rect(1) < bound(1).x(1) || rect(2) < bound(2).x(1) || rect(1)+rect(3) > bound(1).x(2) || rect(2)+rect(4) > bound(2).x(2)
        issue_flag = true;
        return
    end
    
end

end


