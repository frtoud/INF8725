clear all;
close all;

%% Difference de gaussiennes
% Question 1 et 2
img = imread('Prova.jpg');
grayImg = rgb2gray(img);
[DoGs, octaves, sigmas] = differenceDeGaussiennes(grayImg, 3, 3);

%Reponse question 3 - ca ressemble a un filtre Laplacien.

%% Detection de points cles
detectionPointsCles(cell2mat(DoGs(1,1)), cell2mat(octaves(1,1)), sigmas(1,:), 0.1, 10, 1)

% Question 1
% On calcule le gradient du gradient de l'image: D_xx = gradient en x du
% gradient en x, D_xy = gradient en y du gradient en x, D_yy = gradient en
% y du gradient en y.