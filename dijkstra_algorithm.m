function [distances, cells_explored, exploration_order] = dijkstra_algorithm(m, n, goalCell, obstacles, weights)
    % Dijkstra's Algorithm for pathfinding with weighted terrain support
    % Computes shortest weighted distances from the goal cell to all reachable cells.
    % Inputs:
    %   m, n      - Grid dimensions (rows, columns)
    %   goalCell  - Linear index of the goal cell (row-major order)
    %   obstacles - Array of linear indices representing obstacle cells
    %   weights   - m x n matrix of terrain weights (cost to enter each cell)
    %               If not provided, defaults to uniform weights of 1
    % Outputs:
    %   distances         - m x n matrix of shortest weighted distances from goal
    %   cells_explored    - Number of cells explored during search
    %   exploration_order - m x n matrix showing exploration order (0 = unexplored)

    % Default to uniform weights if not provided
    if nargin < 5 || isempty(weights)
        weights = ones(m, n);
    end

    % Initialize the distances matrix with Inf
    distances = Inf(m, n);
    exploration_order = zeros(m, n);

    % Convert goalCell to row and column indices (row-major order)
    [goalRow, goalCol] = index_to_rowcol(goalCell, m, n);

    % Set the goal cell distance to 0
    distances(goalRow, goalCol) = 0;

    % Create obstacle map and mark obstacles
    obstacle_map = false(m, n);
    for i = 1:length(obstacles)
        [obsRow, obsCol] = index_to_rowcol(obstacles(i), m, n);
        obstacle_map(obsRow, obsCol) = true;
    end

    % Priority queue: [row, col, distance]
    % Simulated using a sorted list (smallest distance first)
    pq = [goalRow, goalCol, 0];
    visited = false(m, n);
    cells_explored = 0;

    % Directions for moving: up, down, left, right (4-connectivity)
    directions = [0, 1; 0, -1; -1, 0; 1, 0];

    while ~isempty(pq)
        % Extract the node with the smallest distance (priority queue pop)
        [~, idx] = min(pq(:, 3));
        current = pq(idx, :);
        pq(idx, :) = []; % Remove from queue

        currRow = current(1);
        currCol = current(2);

        % Skip if already visited
        if visited(currRow, currCol)
            continue;
        end

        % Mark as visited and record exploration order
        visited(currRow, currCol) = true;
        cells_explored = cells_explored + 1;
        exploration_order(currRow, currCol) = cells_explored;

        % Explore all 4 adjacent neighbors
        for i = 1:size(directions, 1)
            newRow = currRow + directions(i, 1);
            newCol = currCol + directions(i, 2);

            % Check if the new cell is within bounds
            if newRow >= 1 && newRow <= m && newCol >= 1 && newCol <= n
                % Skip obstacles and already-visited cells
                if ~obstacle_map(newRow, newCol) && ~visited(newRow, newCol)
                    % Cost to reach neighbor = current distance + weight of neighbor cell
                    newDist = distances(currRow, currCol) + weights(newRow, newCol);

                    % Update if this path is shorter
                    if newDist < distances(newRow, newCol)
                        distances(newRow, newCol) = newDist;
                        pq(end + 1, :) = [newRow, newCol, newDist];
                    end
                end
            end
        end
    end

    % Mark obstacles as Inf for display purposes
    distances(obstacle_map) = Inf;
end
