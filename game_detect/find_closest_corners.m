function closest_corners = find_closest_corners(image)
    % FIND_CLOSEST_CORNERS finds the four corners of the Sudoku grid closest to
    % the corners of the input image.
    %
    %   closest_corners = FIND_CLOSEST_CORNERS(image) takes an input image and
    %   returns an array containing the positions of the four corners closest
    %   to the corners of the image.
    %
    %   Input:
    %   - image: Input image containing the Sudoku puzzle.
    %
    %   Output:
    %   - closest_corners: Array containing the positions of the four corners
    %     closest to the corners of the image.
    %
    %   Example:
    %   image_path = 'path/to/your/image.png'; % Provide the path to your image
    %   image = imread(image_path);
    %
    %   closest_corners = find_closest_corners(image);
    %   disp(closest_corners.Location); % Display the positions of the closest corners

    % Step 1: Preprocess the image
    gray_image = rgb2gray(image);

    % Step 2: Detect corners using the Harris corner detector
    corners = detectHarrisFeatures(gray_image);

    % Step 3: Find corners closest to image corners
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
end
