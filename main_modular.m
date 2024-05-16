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
matrice = [
           0, 5, 1, 0, 0, 0, 0, 7, 0;
           0, 7, 3, 0, 4, 2, 8, 9, 5;
           9, 4, 2, 5, 8, 0, 6, 0, 3;
           0, 6, 9, 7, 1, 0, 3, 0, 0;
           0, 0, 0, 8, 2, 9, 7, 4, 6;
           2, 8, 0, 0, 6, 0, 0, 0, 1;
           3, 0, 6, 0, 0, 8, 0, 0, 9;
           7, 0, 4, 2, 5, 6, 1, 3, 8;
           5, 2, 8, 9, 0, 0, 4, 0, 7
                ];

% image = imread("dataset\easy_3.png");
% 
% colturi=find_closest_corners(image);
% 
% doarS=crop_sudoku_grid(image, colturi);
% 
% inputOCR=extract_sudoku_cells(doarS);
% 
% folderPath="input_OCR\";

% files = dir(fullfile(folderPath, '*'));
% for i = 1:length(files)
%     if ~files(i).isdir
%         delete(fullfile(folderPath, files(i).name));
%     end
% end

% % Iterate over subimages and save them
% for i = 1:9
%     for j = 1:9
%         % Generate filename
%         filename = sprintf('subimage_%d_%d.png', i, j);
% 
%         % Construct full file path
%         fullFilePath = fullfile(folderPath, filename);
% 
%         % Save subimage
%         imwrite(inputOCR{i, j}, fullFilePath);
%     end
% end
% 
% 
% matrice=folderRead(folderPath);

solved_matrix = solveSudoku(matrice);

disp("Intrare: ");
disp(matrice);
disp("Iesire");
disp(solved_matrix);

elapsedTime = toc;
fprintf('Execution time: %.2f seconds\n', elapsedTime);