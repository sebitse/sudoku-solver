% Get the current directory
current_directory = pwd;

% Find the last occurrence of '\' in the current directory
last_backslash_index = find(current_directory == '\', 1, 'last');

% Extract the substring up to the last '\' character
parent_directory = current_directory(1:last_backslash_index);
image_path = strcat(parent_directory, 'dataset\super_easy_1.png');

% Step 1: Read the image containing the Sudoku puzzle
image = imread(image_path);

% Step 2: Preprocess the image
gray_image = rgb2gray(image);

% Step 3: Detect corners using the Harris corner detector
corners = detectHarrisFeatures(gray_image);

% Step 4: Find corners closest to image corners
image_size = size(image);
image_corners = [1, 1; 1, image_size(2); image_size(1), 1; image_size(1), image_size(2)];
num_corners = size(corners.Location, 1);
corner_distances = zeros(num_corners, 4);

% Compute distances between each corner and image corners
for i = 1:num_corners
    corner = corners.Location(i, :);
    for j = 1:4
        distance = norm(corner - image_corners(j, :));
        corner_distances(i, j) = distance;
    end
end

% Find the closest corner to each image corner
[~, closest_indices] = min(corner_distances, [], 1);

% Select the closest corners
closest_corners = corners(closest_indices);

% Step 5: Visualize the detected corners on the original image
imshow(image);
hold on;
plot(closest_corners.Location(:,1), closest_corners.Location(:,2), 'ro', 'MarkerSize', 10); % Plot circles of red color with marker size 10
title('Closest Corners to Image Corners');
hold off;
