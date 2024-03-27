function sudoku_grid = extract_sudoku_cells(image)
    % EXTRACT_SUDOKU_CELLS extracts each cell from the Sudoku grid for OCR.
    %
    %   sudoku_grid = EXTRACT_SUDOKU_CELLS(image, corners) takes an input
    %   image containing the Sudoku puzzle and the corners of the grid, and
    %   returns a 9x9 matrix representing each cell of the grid for OCR
    %   processing.
    %
    %   Input:
    %   - image: Input image containing the Sudoku puzzle.
    %   - corners: Array containing the positions of the four corners of the
    %     Sudoku grid.
    %
    %   Output:
    %   - sudoku_grid: 9x9 matrix representing each cell of the Sudoku grid
    %     for OCR processing.

    % Step 1: Preprocess the image
    image = rgb2gray(image);

    % Get image dimensions
    [rows, cols, ~] = size(image);
    
    % Determine size of subimages
    subRows = floor(rows / 9);
    subCols = floor(cols / 9);
    
    % Initialize cell array to store subimages
    subimages = cell(9, 9);
    
    % Loop to divide the image into subimages
    for i = 1:9
        for j = 1:9
            % Calculate the starting and ending row and column indices for the subimage
            startRow = (i - 1) * subRows + 1;
            endRow = min(i * subRows, rows);
            startCol = (j - 1) * subCols + 1;
            endCol = min(j * subCols, cols);
            
            % Extract the subimage
            subimages{i, j} = image(startRow:endRow, startCol:endCol, :);
        end
    end

    sudoku_grid= subimages;
end
