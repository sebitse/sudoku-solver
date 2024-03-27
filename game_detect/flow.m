tic;

% Get the current directory
current_directory = pwd;

% Find the last occurrence of '\' in the current directory
last_backslash_index = find(current_directory == '\', 1, 'last');

% Extract the substring up to the last '\' character
parent_directory = current_directory(1:last_backslash_index);
image_path = strcat(parent_directory, 'dataset\super_easy_1.png');

% Step 1: Read the image containing the Sudoku puzzle
image = imread(image_path);

colturi=find_closest_corners(image);

doarS=crop_sudoku_grid(image, colturi);

inputOCR=extract_sudoku_cells(doarS);

% Stop the timer and display elapsed time
elapsedTime = toc;
fprintf('Execution time: %.2f seconds\n', elapsedTime);

% Provide the folder path where you want to save the subimages
folderPath = strcat(parent_directory, 'input_OCR');

% Delete all files inside the folder
files = dir(fullfile(folderPath, '*'));
for i = 1:length(files)
    if ~files(i).isdir
        delete(fullfile(folderPath, files(i).name));
    end
end

% Iterate over subimages and save them
for i = 1:9
    for j = 1:9
        % Generate filename
        filename = sprintf('subimage_%d_%d.png', i, j);
        
        % Construct full file path
        fullFilePath = fullfile(folderPath, filename);
        
        % Save subimage
        imwrite(inputOCR{i, j}, fullFilePath);
    end
end
