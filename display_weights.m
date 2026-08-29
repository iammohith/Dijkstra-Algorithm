function display_weights(m, n, startCell, goalCell, obstacles, weights)
    % Display the terrain weight map with color-coded cells
    % Shows the cost of entering each cell, helping visualize
    % why Dijkstra's algorithm may choose a different path than BFS
    % Inputs:
    %   m, n      - Grid dimensions
    %   startCell - Linear index of the start cell
    %   goalCell  - Linear index of the goal cell
    %   obstacles - Array of obstacle cell indices
    %   weights   - m x n matrix of terrain weights

    % Create the grid figure
    figure;
    hold on;
    title('Terrain Weight Map');
    axis equal;
    xlim([0 n]);
    ylim([0 m]);
    set(gca, 'XTick', [], 'YTick', []);
    axis off;

    % Get weight range for color scaling (excluding obstacles)
    validWeights = weights;
    for i = 1:length(obstacles)
        [obsRow, obsCol] = index_to_rowcol(obstacles(i), m, n);
        validWeights(obsRow, obsCol) = NaN;
    end
    minW = min(validWeights(:), [], 'omitnan');
    maxW = max(validWeights(:), [], 'omitnan');
    if minW == maxW
        maxW = minW + 1; % Prevent division by zero
    end

    % Draw the grid cells with weight-based coloring
    for row = 1:m
        for col = 1:n
            cellIndex = (row - 1) * n + col;

            % Determine cell color
            if any(obstacles == cellIndex)
                color = [0 0 0]; % Black for obstacles
                textColor = 'w';
                displayValue = 'X';
            elseif cellIndex == goalCell
                color = [1 0 0]; % Red for goal
                textColor = 'k';
                displayValue = num2str(weights(row, col));
            elseif cellIndex == startCell
                color = [0 1 0]; % Green for start
                textColor = 'k';
                displayValue = num2str(weights(row, col));
            else
                % Color gradient based on weight (light green = low, dark orange = high)
                t = (weights(row, col) - minW) / (maxW - minW);
                color = [1.0, 1.0 - 0.6*t, 0.8 - 0.7*t]; % Light yellow to deep orange
                textColor = 'k';
                displayValue = num2str(weights(row, col));
            end

            rectangle('Position', [col-1, m-row, 1, 1], 'EdgeColor', 'k', 'FaceColor', color);

            % Display weight value in the center of each cell
            text(col - 0.5, m - row + 0.5, displayValue, ...
                'HorizontalAlignment', 'center', 'Color', textColor, ...
                'FontSize', 12, 'FontWeight', 'bold');
        end
    end

    % Draw robot at start position
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    draw_robot(startCol - 0.5, m - startRow + 0.5);

    hold off;
end
