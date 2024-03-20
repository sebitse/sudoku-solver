function matrix = solveSudoku(grid)
    % Cautam o pozitie necompletata
    [row, col] = find(grid == 0, 1);

    % Daca matricea este completata, return
    if isempty(row) & isempty(col)
        matrix = grid;
        return;
    end

    % Cautam numarul ce se potriveste pe pozitia gasita la find
    for num = 1:9
        % Verificam ce nr se potriveste pe pozitia identificata
        if isSafe(grid, row, col, num)
            % Assignam nr identificat pozitiei din matrice
            grid(row, col) = num;
            
            % continuam in mod recursiv pt toata matricea
            matrix = solveSudoku(grid);

            % conditie de stop pt recursivitate
            if ~isempty(matrix)
                return;
            end
            % Daca am ajuns aici inseamna nu sunt suficiente valori in grid
            grid(row, col) = 0;
        end
    end
    % Fail
    matrix = []; 
end