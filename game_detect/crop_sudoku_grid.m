function sudoku_grid = crop_sudoku_grid(image, colturi)
    % CROP_SUDOKU_GRID crops the Sudoku grid from the input image using the
    % provided corner coordinates.
    %
    %   sudoku_grid = CROP_SUDOKU_GRID(image, corners) takes an input image
    %   and the corner coordinates of the Sudoku grid, performs perspective
    %   transformation, and returns a cropped image containing only the
    %   Sudoku grid.
    %
    %   Input:
    %   - image: Input image containing the Sudoku puzzle.
    %   - corners: Corner coordinates of the Sudoku grid obtained from
    %     find_closest_corners function.
    %
    %   Output:
    %   - sudoku_grid: Cropped image containing only the Sudoku grid.

    % calculeaza dimensiunea gridului
    x=colturi.Location(4,1)-colturi.Location(1,1);
    y=colturi.Location(4,2)-colturi.Location(1,2);

    initial= colturi.Location;
    final= [1 1 ; 1 y; x 1; x y];

    TF = fitgeotrans(initial, final,'projective');
    outview = imref2d(size(image));
    sudoku_grid = imwarp(image,TF,'fillvalues',0,'outputview',outview);

    x=int16(x);
    y=int16(y);
    sudoku_grid=imcrop(sudoku_grid,[1 1 x y]);
end
