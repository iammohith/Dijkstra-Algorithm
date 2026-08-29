function display_distances(m, n, startCell, goalCell, obstacles, weights)
    % Display the distances computed by Dijkstra's algorithm
    % Shows the weighted shortest distance from each cell to the goal

    % Default to uniform weights if not provided
    if nargin < 6 || isempty(weights)
        weights = ones(m, n);
    end

    % Generate the distance matrix using Dijkstra's algorithm
    [distances, ~, ~] = dijkstra_algorithm(m, n, goalCell, obstacles, weights);

    % Call display_grid to create the base grid
    display_grid(m, n, startCell, goalCell, obstacles);

    % Hold on to overlay distances
    hold on;

    % Draw the robot at the start position
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    draw_robot(startCol - 0.5, m - startRow + 0.5);

    % Overlay distance values in the center of each cell
    for row = 1:m
        for col = 1:n
            distanceValue = distances(row, col);

            if isinf(distanceValue)
                textColor = 'w'; % White for obstacles (Inf)
                displayValue = 'Inf';
            else
                textColor = 'k'; % Black for non-obstacle cells
                displayValue = num2str(distanceValue);
            end

            % Display the distance at the center of each cell
            text(col - 0.5, m - row + 0.5, displayValue, ...
                'HorizontalAlignment', 'center', 'Color', textColor, ...
                'FontSize', 12, 'FontWeight', 'bold');
        end
    end

    hold off;
end
