function shortest_path(m, n, startCell, goalCell, obstacles, weights)
    % Visualize the shortest path from start to goal using Dijkstra's distances
    % Follows the gradient of decreasing distance (like Grassfire) but with weights

    % Default to uniform weights if not provided
    if nargin < 6 || isempty(weights)
        weights = ones(m, n);
    end

    % Display the grid with distances as background
    display_distances(m, n, startCell, goalCell, obstacles, weights);

    % Generate the distance matrix using Dijkstra's algorithm
    [distances, ~, ~] = dijkstra_algorithm(m, n, goalCell, obstacles, weights);

    % Convert goal to row and column
    [goalRow, goalCol] = index_to_rowcol(goalCell, m, n);

    % Initialize current position at the start cell
    [currentRow, currentCol] = index_to_rowcol(startCell, m, n);

    hold on;

    % Mark the start cell with the robot
    draw_robot(currentCol - 0.5, m - currentRow + 0.5);

    % Path tracking
    path = [currentRow, currentCol];

    % Directions for moving: up, down, left, right
    directions = [0, 1; 0, -1; -1, 0; 1, 0];

    % Follow the gradient of decreasing distance to the goal
    while true
        if currentRow == goalRow && currentCol == goalCol
            break; % Reached the goal
        end

        % Find the neighbor with the smallest distance
        minDistance = Inf;
        nextCell = [currentRow, currentCol];

        for i = 1:size(directions, 1)
            newRow = currentRow + directions(i, 1);
            newCol = currentCol + directions(i, 2);

            if newRow >= 1 && newRow <= m && newCol >= 1 && newCol <= n
                if distances(newRow, newCol) < minDistance
                    minDistance = distances(newRow, newCol);
                    nextCell = [newRow, newCol];
                end
            end
        end

        % Move to the next cell
        currentRow = nextCell(1);
        currentCol = nextCell(2);

        % Store the path
        path(end + 1, :) = [currentRow, currentCol];

        % Plot the path cell with robot
        draw_robot(currentCol - 0.5, m - currentRow + 0.5);

        % Pause to visualize the movement
        pause(0.75);
    end

    % Mark the goal cell with robot
    draw_robot(goalCol - 0.5, m - goalRow + 0.5);

    % Display distance value at the goal cell
    text(goalCol - 0.5, m - goalRow + 0.5, '0', ...
        'HorizontalAlignment', 'center', 'Color', 'k', ...
        'FontSize', 12, 'FontWeight', 'bold');

    % Display values for all path cells
    for idx = 1:size(path, 1)
        row = path(idx, 1);
        col = path(idx, 2);
        distanceValue = distances(row, col);
        text(col - 0.5, m - row + 0.5, num2str(distanceValue), ...
            'HorizontalAlignment', 'center', 'Color', 'k', ...
            'FontSize', 12, 'FontWeight', 'bold');
    end

    hold off;
end
