close all;
clear;
clc;

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

image = imread("dataset\easy_1.png");

colturi=find_closest_corners(image);

doarS=crop_sudoku_grid(image, colturi);

inputOCR=extract_sudoku_cells(doarS);

% Initialize a matrix to store OCR results
matrice = zeros(9, 9);

 % Get the size of the image
    [height, width, ~] = size(inputOCR{1,1});
    
    % Define the ROI (centered 80% of the image)
    roiWidth = width * 0.8;
    roiHeight = height * 0.8;
    roiX = (width - roiWidth) / 2;
    roiY = (height - roiHeight) / 2;
   roi = [roiX, roiY, roiWidth, roiHeight];
tic;

% Loop through each file

% Flatten the 9x9 cell array into a 81x1 cell array
inputOCR_flat = inputOCR(:);
% Initialize an array to store execution times
execution_times = zeros(numel(inputOCR_flat), 1);


% Loop through each cell in parallel
parfor i = 1:numel(inputOCR_flat)
    start_time = tic; % Start timer
    
    % Perform OCR on the specified region
    ocrResults = ocr(imbinarize(inputOCR_flat{i}), roi,"LayoutAnalysis","block","CharacterSet","123456789");
    
    % Get the text from OCR results
    ocrText = ocrResults.Text;
    
    % Convert OCR text to numbers
    if ~isempty(ocrText)
        matrice(i) = str2double(ocrText);
        %disp(ocrText);
    end
     
    % Store execution time
    execution_times(i) = toc(start_time); % End timer
end

% Display execution times
disp("Execution times:");
disp(sum(execution_times));

disp("Intrare: ");
disp(matrice);

solved_matrix = solveSudoku(matrice');


disp("Iesire");
disp(solved_matrix');

elapsedTime = toc;
fprintf('Execution time: %.2f seconds\n', elapsedTime);