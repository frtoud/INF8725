% �quipe:
% Alexandre Hua - 1795724
% Anthony Lachance - 1793057
% Fran�ois Toulouse - 1788028
clear all;
close all;

%% Difference de gaussiennes
% Question 1 et 2 r�alis�es avec l'image droite; voir dans la fonction
% differenceDeGaussiennes pour l'impl�mentation.
img = imread('droite.jpg');
DgrayImg = rgb2gray(img);
[DoGs, octaves, sigmas] = differenceDeGaussiennes(DgrayImg, 3, 3);

%Reponse question 3 - ca ressemble a un filtre Laplacien.

%% Detection de points cles
points = {};
detected = 0;
contrast = 0;
edges = 0;
conserved = zeros(3, 2);
for oct = 1:3; %passer chaque octave dans la fonction
    [p, d, c, e] = detectionPointsCles(cell2mat(DoGs(oct,1)), cell2mat(octaves(oct,1)), sigmas(oct,:), 0.015, 5, oct);
    detected = detected + d;
    contrast = contrast + c;
    edges = edges + e;
    points = [points;p];
    conserved(oct, 1:2) = [oct, size(p, 1)];
end

%% Question 3: Graphes des points coserv�s � chaque octave.
figure;
plot(conserved(:, 1), conserved(:, 2))
title('Points conserv�s par octave')
xlabel('Octave')
ylabel('Nb. de points')

%%
DptMat = cell2mat(points);
scatterSIFT(DgrayImg, DptMat);
% Question 1
% On calcule le gradient du gradient de l'image: D_xx = gradient en x du
% gradient en x, D_xy = gradient en y du gradient en x, D_yy = gradient en
% y du gradient en y.

%% Attribution de descripteurs
Ddescs = calculDescripteurs(cell2mat(points), size(DgrayImg), octaves);



%% Difference de gaussiennes
% Ces prochaines sections font le processus sur l'image de gauche
img = imread('gauche.jpg');
GgrayImg = rgb2gray(img);
[DoGs, octaves, sigmas] = differenceDeGaussiennes(GgrayImg, 3, 3);
%% Detection de points cles 
points = {};
detected = 0;
contrast = 0;
edges = 0;
for oct = 1:3;
    [p, d, c, e] = detectionPointsCles(cell2mat(DoGs(oct,1)), cell2mat(octaves(oct,1)), sigmas(oct,:), 0.015, 5, oct);
    detected = detected + d;
    contrast = contrast + c;
    edges = edges + e;
    points = [points;p];
end
GptMat = cell2mat(points);
scatterSIFT(GgrayImg, GptMat);
%% Attribution de descripteurs
Gdescs = calculDescripteurs(cell2mat(points), size(GgrayImg), octaves);


%% Recherche de couples amis
distanceMatrix = distanceInterPoints(Ddescs, Gdescs);
[a, b] = size(distanceMatrix);
n_mins = 10;
minPoints1 = zeros(0, 2);
minPoints2 = zeros(0, 2);
for i = 1:n_mins
    [val, index] = min(distanceMatrix(:))
    [pos_1, pos_2] = ind2sub(size(distanceMatrix), index);
    distanceMatrix(pos_1, :) = Inf(1, b);
    distanceMatrix(:, pos_2) = Inf(a, 1);
    minPoints1(end+1, 1:2) = Ddescs(pos_1, 1:2);
    minPoints2(end+1, 1:2) = Gdescs(pos_2, 1:2);
end

%% affichage
colors = [[1, 0, 0];[0, 1, 0];[0, 0, 1];[1, 1, 0];[1, 0, 1];[0, 1, 1];[1, 0.5, 0];[1, 0, 0.5];[0.5, 1, 0];[0, 0.5, 1]];
figure;
imshow(DgrayImg, [])
for k = 1:n_mins
    hold on;
    scatter(minPoints1(k, 1), minPoints1(k, 2), 100, colors(k, :), 'o',  'LineWidth', 3);
end
figure;
imshow(GgrayImg, [])
for k = 1:n_mins
    hold on;
    scatter(minPoints2(k, 1), minPoints2(k, 2), 100, colors(k, :), 'o',  'LineWidth', 3);
end