% Équipe:
% Alexandre Hua - 1795724
% Anthony Lachance - 1793057
% François Toulouse - 1788028
clear all;
close all;

%% Difference de gaussiennes
% Question 1 et 2
img = imread('droite.jpg');
grayImg = rgb2gray(img);
[DoGs, octaves, sigmas] = differenceDeGaussiennes(grayImg, 3, 3);

%Reponse question 3 - ca ressemble a un filtre Laplacien.

%% Detection de points cles                DOGs                     OCTs              SIGs        Contrast, R factor, num. octave
points = {};
detected = 0;
contrast = 0;
edges = 0;
for oct = 1:3;
    [p, d, c, e] = detectionPointsCles(cell2mat(DoGs(oct,1)), cell2mat(octaves(oct,1)), sigmas(oct,:), 0.015, 10, oct);
    detected = detected + d;
    contrast = contrast + c;
    edges = edges + e;
    points = [points;p];
end

%%
ptMat = cell2mat(points);
scatterSIFT(grayImg, ptMat);
% Question 1
% On calcule le gradient du gradient de l'image: D_xx = gradient en x du
% gradient en x, D_xy = gradient en y du gradient en x, D_yy = gradient en
% y du gradient en y.

%% Attribution de descripteurs
descs = calculDescripteurs(cell2mat(points), size(grayImg), octaves);