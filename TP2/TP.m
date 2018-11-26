close all;
clear;

%% Exercice 1
%Question 5: Le bruit poivre et sel est augmente a cause du masque
%laplacien car celui-ci le detecte comme contour. Pour diminuer le bruit
%poivre et sel, on pourrait utiliser un filtre median.

src = imread('theArtist.png');
figure;
imshow(src);
title("Image de depart");
src_egal = Egalisation_Histogramme(src);

%Egalisation_Histogramme
type Egalisation_Histogramme.m;

figure;
imshow(src_egal);
title("Question 1 - Image avec egalisation d'Histogramme");
mask = [1,2,1,2,1; 2,4,8,4,2; 1,8,18,8,1; 2,4,8,4,2; 1,2,1,2,1]/90;
result = Convolution(src_egal, mask);

%Convolution
type Convolution.m;

figure;
imshow(result);
title("Question 2 et 3 - Image avec gaussienne et egalisation d'Histogramme")
img_contour = Rehaussement_Contour(src_egal, 1.2);

%Rehaussement_Contour
type Rehaussement_Contour.m;

figure;
imshow(img_contour);
title("Question 4 - Image avec rehaussement de contour")

%% Exercice 2

color_img = imread('pieces.jpg');
gray_img = rgb2gray(color_img);
figure;
imshow(gray_img);
title("Question 1 - Image en niveau de gris")

bin_img = Binariser(gray_img, 250);

%Binariser
type Binariser.m;

inverse_bin_img = imcomplement(bin_img);
figure;
imshow(inverse_bin_img);
title("Question 2 - Image binarise inverse")

se = strel('disk', 10);
closed_img = imclose(inverse_bin_img,se);
figure;
imshow(closed_img);
title("Question 3 - Image refermee");

monnaie = Compter_Monnaie(closed_img);

%Compter_Monnaie
type Compter_Monnaie.m;

disp("il y a "); disp(monnaie); disp(" $ dans cette photo.");

%% Exercice 3

%Question 1
vert = imread('Barres_Verticales.png');
obl = imread('Barres_Obliques.png');
hor = imread('Barres_Horizontales.png');

figure;
imshow(vert);
title("Question 1 - Barres Verticales");

figure;
imshow(obl);
title("Question 1 - Barres Obliques");

figure;
imshow(hor);
title("Question 1 - Barres Horizontales");

%Question 2
fftv = fftshift(abs(fft2(vert)));
figure;
imshow(log(1+fftv),[]);
title("Question 2 - fft barres verticales");

ffto = fftshift(abs(fft2(obl)));
figure;
imshow(log(1+ffto),[]);
title("Question 2 - fft barres obliques");

ffth = fftshift(abs(fft2(hor)));
figure;
imshow(log(1+ffth),[]);
title("Question 2 - fft barres horizontales");

%Question 3
rotate_vert = imrotate(vert, 70, 'bilinear', 'crop');
figure;
imshow(rotate_vert);
title("Question 3 - Barres vertiales avec rotation.");
fftrv = fftshift(abs(fft2(rotate_vert)));
figure;
imshow(log(1+fftrv),[]);
title("Question 3 - fft barres verticales avec rotation");

%Question 4
% La TFD d'une image (signal 2d) composee de traits verticaux va donner une
% ligne horizontale. De même pour une image composee de traits horizontaux,
% ce qui donne une ligne verticale. La ligne la plus lumineuse de la TFD
% est toujours perpendiculaire aux traits dominants de l'image.

%% Exercice 4

%Question 1
src = imread('maillot.png');
figure;
imshow(src);
title("Image de depart");

ffti = fft2(src);
spectre = fftshift(abs(ffti));
figure;
imshow(log(1+spectre), []);
title("Question 1 - spectre de l'image");
phase = angle(ffti);
figure;
imshow(phase, []);
title("Question 1 - phase de l'image");

%Question 2
q2 = imread('E4_Q2.png');
figure;
imshow(q2, []);
title("Question 2");

%Question 3
[w,h] = size(spectre);
gaussian_mask = fspecial('gaussian', [w,h], 20);
spectre_gauss = gaussian_mask.*spectre;
fft_gauss = ifftshift(spectre_gauss).*cos(phase) + ifftshift(spectre_gauss) .* sin(phase)*1i;
img_gauss = ifft2(fft_gauss);
figure;
imshow(img_gauss, []);
title("Question 3 - image avec filtrage spectral passe-bas");

%Question 4

high_gaussian_mask = fspecial('gaussian', [w,h], 100);
i_gauss = zeros(w,h);
i_gauss(1:w, 1:h) = max(high_gaussian_mask(:));
high_gaussian_mask = i_gauss - high_gaussian_mask;
high_spectre_gauss = high_gaussian_mask.*spectre;
high_fft_gauss = ifftshift(high_spectre_gauss).*cos(phase) + ifftshift(high_spectre_gauss) .* sin(phase)*1i;
high_img_gauss = ifft2(high_fft_gauss);
figure;
imshow(high_img_gauss, []);
title("Question 4 - image avec filtrage spectral passe-haut");

%Question 5

low_gaussian_mask = fspecial('gaussian', [w,h], 28);
low_gaussian_mask = low_gaussian_mask./max(low_gaussian_mask(:));
high_gaussian_mask = fspecial('gaussian', [w,h], 32);
high_gaussian_mask = ones(w,h) - (high_gaussian_mask./max(high_gaussian_mask(:)));
filter = ones(w,h);
filter = filter - low_gaussian_mask - high_gaussian_mask;
figure;
imshow(filter);
title("Question 5 - filtre passe-bande gaussien avant normalisation");
filter = filter./norm(filter,1);
band_pass = filter.*spectre;
band_pass_fft = ifftshift(band_pass).*cos(phase) + ifftshift(band_pass) .* sin(phase)*1i;
band_pass_img = ifft2(band_pass_fft);
BI = imbinarize(band_pass_img,-0.8);
figure;
imshow(band_pass_img, []);
title("Question 5 - image avec filtrage spectral passe-bande");
figure;
imshow(BI, []);
title("Question 5 - image avec filtrage spectral passe-bande seuillé, manches conservees");

%Question 6

low_gaussian_mask = fspecial('gaussian', [w,h], 11);
low_gaussian_mask = low_gaussian_mask./max(low_gaussian_mask(:));
high_gaussian_mask = fspecial('gaussian', [w,h],15);
high_gaussian_mask = ones(w,h) - (high_gaussian_mask./max(high_gaussian_mask(:)));
filter = ones(w,h);
filter = filter - low_gaussian_mask - high_gaussian_mask;
figure;
imshow(filter);
title("Question 6 - filtre passe-bande gaussien avant normalisation");
filter = filter./norm(filter,1);
band_pass = filter.*spectre;
band_pass_fft = ifftshift(band_pass).*cos(phase) + ifftshift(band_pass) .* sin(phase)*1i;
band_pass_img = ifft2(band_pass_fft);
BI = imbinarize(band_pass_img,-2.7);
BI = imerode(BI, strel('rectangle',[10,30]));
BI = imcomplement(BI);
figure;
imshow(band_pass_img, []);
title("Question 6 - image avec filtrage spectral passe-bande");
figure;
imshow(BI, []);
title("Question 6 - image avec filtrage spectral passe-bande seuillé");
img = im2double(src);
filtered_img = img + BI;
filtered_img(filtered_img>1)=1;
figure;
imshow(filtered_img, []);
title("Question 6 - image avec les rayures verticales du torse retirées");

%Question 7
%Le filtre idéal va introduire du bruit à cause de la fonction porte (sinus
%cardinal). Le filtre Butterworth diminue ce bruit en ayant une trasition
%plus lente entre les valeurs de 0 et les valeurs de 1.

%Question 8
%Si on retire la fréquence 0 de l'image (ou qu'on la diminue), on va perdre
% ou diminuer l'intensité des régions continues de l'image (Fréquence = 0).

%Question 9
%C'est un filtre Homorphique où on diminue le paramètre D0 à chaque
%itération: On obtient les éléments de fréquence de plus en plus basses
%jusqu'à ce qu'on obtienne la couleur moyenne de l'image (fréquence 0).