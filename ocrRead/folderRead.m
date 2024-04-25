function [matrice] = folderRead(folderPath)
%FOLDERREAD Reads OCR data from images in a folder and stores it in a matrix.
%   This function reads OCR (Optical Character Recognition) data from all images
%   in the specified folder and stores the extracted numeric values in a 9x9 matrix.
%   The images in the folder are assumed to represent a 9x9 grid, with each grid
%   cell containing a single numeric value. The function applies OCR to extract
%   the numeric values from each image and stores them in the matrix, row by row.
%
%   Inputs:
%   - folderPath: A string specifying the path to the folder containing the images.
%
%   Outputs:
%   - matrice: A 9x9 matrix containing the OCR-extracted numeric values from the
%              images. Empty grid cells in the images are represented by zeros in
%              the matrix.
%
%   Example:
%       folderPath = 'path/to/your/folder';
%       matrice = folderRead(folderPath);
%
%   Notes:
%   - The function expects the images in the folder to be in PNG format. Modify
%     the file extension in the 'dir' function call to match the format of your images.
%   - The function assumes that there are exactly 81 images in the folder, each
%     representing a single cell in a 9x9 grid.
%   - The OCR region of interest (ROI) is defined as the center 80% of each image.
%   - OCR is performed using default settings, with the character set limited to
%     digits (1-9) for Sudoku puzzle cells.
%   - If the folder does not contain exactly 81 images, the function displays an
%     error message ('EROARE') and returns an empty matrix.
%
%   See also: ocr, imbinarize, imread, dir

% Author: Cosa Andrei Valeriu
% Date: 25.04.2024

% Get a list of all files in the folder
fileList = dir(fullfile(folderPath, '*.png')); % Change '*.png' to the appropriate file extension

% Check if there are exactly 81 files in the folder
if numel(fileList) ~= 81
    disp('EROARE');
    matrice = [];
    return;
end

% Initialize a matrix to store OCR results
matrice = zeros(9, 9);


% Loop through each file
parfor i = 1:numel(fileList)
    % Get the file name
    fileName = fileList(i).name;
    
    % Read the image
    imagePath = fullfile(folderPath, fileName);
    img = imread(imagePath);
    
    % Get the size of the image
    [height, width, ~] = size(img);
    
    % Define the ROI (centered 80% of the image)
    roiWidth = width * 0.8;
    roiHeight = height * 0.8;
    roiX = (width - roiWidth) / 2;
    roiY = (height - roiHeight) / 2;
    roi = [roiX, roiY, roiWidth, roiHeight];
    
    % Perform OCR on the specified region
    ocrResults = ocr(imbinarize(img), roi,"LayoutAnalysis","character","CharacterSet","123456789");
    
    % Get the text from OCR results
    ocrText = ocrResults.Text;
    
    % Convert OCR text to numbers
    if ~isempty(ocrText)
        matrice(i) = str2double(ocrText);
    end
end

end

