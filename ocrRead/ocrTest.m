%% o bucata
inP=imread("input_OCR\subimage_1_2.png");
binara=imbinarize(inP);
ocrO=ocr(inP,"LayoutAnalysis","character");

%% 2 bucati
tic;
% Specify the folder containing the files
folderPath = 'H:\Other computers\My Laptop\MatrixLab\SVA\Sudokan\input_OCR';

% Get a list of all files in the folder
fileList = dir(fullfile(folderPath, '*.png')); % Change '*.png' to the appropriate file extension

% Check if there are exactly 81 files in the folder
if numel(fileList) ~= 81
    disp('EROARE');
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
    ocrResults = ocr(imbinarize(img), roi,"LayoutAnalysis","block","CharacterSet","123456789");
    
    % Get the text from OCR results
    ocrText = ocrResults.Text;
    
    % Convert OCR text to numbers
    if ~isempty(ocrText)
        matrice(i) = str2double(ocrText);
    end
end

% Display the matrix
disp('Matrice de test:');
disp(matrice);

elapsedTime = toc;
fprintf('Execution time: %.2f seconds\n', elapsedTime);