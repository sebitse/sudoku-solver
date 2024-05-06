close all;
clear;
clc;
tic;

addpath("algorithm\");
addpath("image_acquisition\");
addpath("game_detect\");
addpath("ocrRead\");
addpath("dataset\");

% Achizitionarea imaginii folosind camera web
%image = img_acquisition();
%figure; 
% imshow(image);

% Matrice de test
matrice = [3, 0, 6, 5, 0, 8, 4, 0, 0;
           5, 2, 0, 0, 0, 0, 0, 0, 0;
           0, 8, 7, 0, 0, 0, 0, 3, 1;
           0, 0, 3, 0, 1, 0, 0, 8, 0;
           9, 0, 0, 8, 6, 3, 0, 0, 5;
           0, 5, 0, 0, 9, 0, 6, 0, 0;
           1, 3, 0, 0, 0, 0, 2, 5, 0;
           0, 0, 0, 0, 0, 0, 0, 7, 4;
           0, 0, 5, 2, 0, 6, 3, 0, 0];

image = imread("dataset\easy_3.png");

colturi=find_closest_corners(image);

doarS=crop_sudoku_grid(image, colturi);

inputOCR=extract_sudoku_cells(doarS);

folderPath="input_OCR\";

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

matrice=folderRead(folderPath);

solved_matrix = solveSudoku(matrice');

disp("Intrare: ");
disp(matrice');
disp("Iesire");
disp(solved_matrix);

elapsedTime = toc;
fprintf('Execution time: %.2f seconds\n', elapsedTime);