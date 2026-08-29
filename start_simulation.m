function start_simulation(m, n, startCell, goalCell, obstacles)
    % Dijkstra's Algorithm Pathfinding Simulation
    % Entry point that orchestrates the complete simulation workflow:
    %   1. Display the problem statement (grid with start, goal, obstacles)
    %   2. Display the terrain weight map
    %   3. Display the weighted distances computed by Dijkstra
    %   4. Animate the shortest path simulation

    % --- Terrain Weights ---
    % Default: uniform weights (all cells cost 1 to enter)
    % This matches the Grassfire/A* results for consistent comparison.
    weights = ones(m, n);

    % --- OPTIONAL: Uncomment below for weighted terrain demo ---
    % This demonstrates Dijkstra's unique ability to handle non-uniform costs.
    % With these weights, cells (2,1) and (3,1) cost 8 to enter,
    % forcing Dijkstra to prefer a longer but cheaper right-side path.
    %
    % weights = [1 1 2 1 1;
    %            8 1 1 1 1;
    %            8 1 1 1 1;
    %            1 1 1 1 1;
    %            1 2 1 1 1];

    % First output: Grid display (Problem Statement)
    display_grid(m, n, startCell, goalCell, obstacles);
    title('Problem Statement');
    pause(5); % Pause for 5 seconds to view the grid

    % Second output: Terrain weight map
    display_weights(m, n, startCell, goalCell, obstacles, weights);
    title('Terrain Weight Map');
    pause(5); % Pause for 5 seconds to view the weights

    % Third output: Distances from Dijkstra's Algorithm
    display_distances(m, n, startCell, goalCell, obstacles, weights);
    title('Distances from Dijkstra''s Algorithm');
    hold on;
    pause(5); % Pause for 5 seconds to view the distances

    % Fourth output: Shortest path simulation
    shortest_path(m, n, startCell, goalCell, obstacles, weights);
    title('Shortest Path Simulation');
end
