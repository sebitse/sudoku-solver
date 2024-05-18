clear all;

addpath("algorithm\");
addpath("image_acquisition\");
addpath("game_detect\");
addpath("ocrRead\");
addpath("dataset\");

% Achizitionarea imaginii folosind camera telefonului
img = img_acquisition();

image = imcrop(img);
figure; imshow(image );

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
disp(matrice);
disp("Iesire");
disp(solved_matrix);
