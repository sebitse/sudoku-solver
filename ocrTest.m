%% o bucata
inP=imread("input_OCR\subimage_1_2.png");
binara=imbinarize(inP);
ocrO=ocr(inP,"LayoutAnalysis","character");

%% 2 bucati

% Specify the folder containing the files
folderPath = 'F:\WIP\MatrixLab\SVA\Sudokan\input_OCR';

% Get a list of all files in the folder
fileList = dir(fullfile(folderPath, '*.png')); % Change '*.png' to the appropriate file extension

% Loop through each file
for i = 1:numel(fileList)
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
    
    % Display file name and OCR text in console
    fprintf('%s : %s\n', fileName, ocrText);
end
