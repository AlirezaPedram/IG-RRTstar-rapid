function obstacle_edge = obstacle_multi()
% Defines an obstacle as a set of edges 
% each edge is defined by: start point, end point, slope, and Y_axis
% intercept

% Obstacle_1
x(1).vertex = [0.12,0.4] +[0.025 0];
vertex_index= length(x);
x(end+1).vertex = [0.08,0.34]+ [0.025 0];
x(end+1).vertex = [0.20,0.3]+ [0.025 0]; 
x(end+1).vertex = [0.20,0.36]+ [0.025 0]; 
for i=vertex_index:length(x)
obstacle_edge(i).start = x(i).vertex;
if (i~=length(x))
obstacle_edge(i).end = x(i+1).vertex;
else
   obstacle_edge(i).end = x(vertex_index).vertex; 
end
obstacle_edge(i).slope = (obstacle_edge(i).start(2)-obstacle_edge(i).end(2))/...
    (obstacle_edge(i).start(1)-obstacle_edge(i).end(1));
obstacle_edge(i).y_inter = obstacle_edge(i).start(2) -...
    obstacle_edge(i).slope*obstacle_edge(i).start(1);
end

% Obstacle_2
x(end+1).vertex = [0.21,0.63]; 
vertex_index= length(x);
x(end+1).vertex = [0.35,0.6];
x(end+1).vertex = [0.33,0.72]; 
for i=vertex_index:length(x)
obstacle_edge(i).start = x(i).vertex;
if (i~=length(x))
obstacle_edge(i).end = x(i+1).vertex;
else
   obstacle_edge(i).end = x(vertex_index).vertex; 
end
obstacle_edge(i).slope = (obstacle_edge(i).start(2)-obstacle_edge(i).end(2))/...
    (obstacle_edge(i).start(1)-obstacle_edge(i).end(1));
obstacle_edge(i).y_inter = obstacle_edge(i).start(2) -...
    obstacle_edge(i).slope*obstacle_edge(i).start(1);
end

% Obstacle_3
x(end+1).vertex = [0.22,0.25]; 
vertex_index= length(x);
x(end+1).vertex = [0.18,0.12];
x(end+1).vertex = [0.39,0.09]; 
for i=vertex_index:length(x)
obstacle_edge(i).start = x(i).vertex;
if (i~=length(x))
obstacle_edge(i).end = x(i+1).vertex;
else
   obstacle_edge(i).end = x(vertex_index).vertex; 
end
obstacle_edge(i).slope = (obstacle_edge(i).start(2)-obstacle_edge(i).end(2))/...
    (obstacle_edge(i).start(1)-obstacle_edge(i).end(1));
obstacle_edge(i).y_inter = obstacle_edge(i).start(2) -...
    obstacle_edge(i).slope*obstacle_edge(i).start(1);
end

% Obstacle_4
x(end+1).vertex = [0.27,0.54]; 
vertex_index= length(x);
x(end+1).vertex = [0.27,0.41];
x(end+1).vertex = [0.33,0.23]; 
x(end+1).vertex = [0.43,0.29]; 
for i=vertex_index:length(x)
obstacle_edge(i).start = x(i).vertex;
if (i~=length(x))
obstacle_edge(i).end = x(i+1).vertex;
else
   obstacle_edge(i).end = x(vertex_index).vertex; 
end
obstacle_edge(i).slope = (obstacle_edge(i).start(2)-obstacle_edge(i).end(2))/...
    (obstacle_edge(i).start(1)-obstacle_edge(i).end(1));
obstacle_edge(i).y_inter = obstacle_edge(i).start(2) -...
    obstacle_edge(i).slope*obstacle_edge(i).start(1);
end


% Obstacle_5
x(end+1).vertex = [0.49,0.3]; 
vertex_index= length(x);
x(end+1).vertex = [0.5,0.2];
x(end+1).vertex = [0.65,0.14]; 
x(end+1).vertex = [0.69,0.27];
for i=vertex_index:length(x)
obstacle_edge(i).start = x(i).vertex;
if (i~=length(x))
obstacle_edge(i).end = x(i+1).vertex;
else
   obstacle_edge(i).end = x(vertex_index).vertex; 
end
obstacle_edge(i).slope = (obstacle_edge(i).start(2)-obstacle_edge(i).end(2))/...
    (obstacle_edge(i).start(1)-obstacle_edge(i).end(1));
obstacle_edge(i).y_inter = obstacle_edge(i).start(2) -...
    obstacle_edge(i).slope*obstacle_edge(i).start(1);
end

% Obstacle_6
x(end+1).vertex = [0.43,0.53]; 
vertex_index= length(x);
x(end+1).vertex = [0.46,0.39];
x(end+1).vertex = [0.6,0.4]; 
x(end+1).vertex = [0.6,0.55]; 
for i=vertex_index:length(x)
obstacle_edge(i).start = x(i).vertex;
if (i~=length(x))
obstacle_edge(i).end = x(i+1).vertex;
else
   obstacle_edge(i).end = x(vertex_index).vertex; 
end
obstacle_edge(i).slope = (obstacle_edge(i).start(2)-obstacle_edge(i).end(2))/...
    (obstacle_edge(i).start(1)-obstacle_edge(i).end(1));
obstacle_edge(i).y_inter = obstacle_edge(i).start(2) -...
    obstacle_edge(i).slope*obstacle_edge(i).start(1);
end