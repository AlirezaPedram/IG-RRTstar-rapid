function obstacle_edge = obstacle_diag_line()
% LINE (diagonal)
obstacle_edge(1).start = [0.2,0.05]*1.5;
obstacle_edge(1).end = [1.7,0.425];
obstacle_edge(1).slope = (obstacle_edge(1).start(2)-obstacle_edge(1).end(2))/...
    (obstacle_edge(1).start(1)-obstacle_edge(1).end(1));
obstacle_edge(1).y_inter = obstacle_edge(1).start(2) -...
    obstacle_edge(1).slope*obstacle_edge(1).start(1);


