close all;
clear;
clc;
tic;

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

solved_matrix = solveSudoku(matrice);

disp("Intrare: ");
disp(matrice);
disp("Iesire");
disp(solved_matrix);

elapsedTime = toc;
fprintf('Execution time: %.2f seconds\n', elapsedTime);