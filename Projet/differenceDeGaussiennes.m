function [DoGs, octaves, sigmas]=differenceDeGaussiennes(image_initiale, s, nb_octave)
    % Initial convolution to get sigma = 0.8 (initial sigma = 0.5)
    sigmaFirst = sqrt(0.8^2 - 0.5^2);
    hsize = round(3*sigmaFirst);
    if mod(hsize,2) == 0
        hsize = hsize + 1;
    end
    gaussian = filtreGaussien(sigmaFirst);%fspecial('gaussian',hsize,sigmaFirst);
    img = imfilter(image_initiale, gaussian, 'replicate');
    %img = imgaussfilt(image_initiale, sigmaFirst);
    disp(size(img));
    % Doubling image dimension using bilinear interpolation
    img = imresize(img, 2, 'bilinear');
    disp(size(img));
    sigma_zero = 0.8;
    % creating the octaves
    k = 2^(1.0/s);
    resizedImg = img;
    [height, width] = size(resizedImg);
    octaves=cell(nb_octave,1);
    octave = zeros(height, width, s+3);
    octave(:,:,1) = resizedImg;
    octaves{1,1} = octave;
    sigmas = zeros(nb_octave, s+3);
    % get the gaussians
    for i=1:nb_octave
        distPixel = 0.5 * 2^(i-1);
        currentOctave = octaves{i,1};
        [height, width, n] = size(currentOctave);
        %first image is set as the downscale of the first image of the last
        %octave, we determine the other levels of the pyramid of gradients
        %based on that image.
        sigmas(i,1) = sigma_zero/distPixel;
        for j=2:s+3
            sigma = sigma_zero*sqrt(k^(2*(j-1))-k^(2*(j-2)))/distPixel;
            sigmas(i,j) = sigma_zero*k^((j-1))/distPixel;
            hsize = round(3*sigma);
            if mod(hsize,2) == 0
                hsize = hsize + 1;
            end
            gaussian = filtreGaussien(sigma);%fspecial('gaussian',hsize,sigma);
            currentOctave(:,:,j) = imfilter(currentOctave(:,:,j-1), gaussian, 'replicate');
            %currentOctave(:,:,j) = imgaussfilt(currentOctave(:,:,j-1), sigma);
        end
        octaves{i,1} = currentOctave;
        if i ~= nb_octave
            %downsampling resizedImg
            nextOctaveBase = currentOctave(1:2:height, 1:2:width, 1);
            [nextHeight, nextWidth] = size(nextOctaveBase);
            nextOctave = zeros(nextHeight, nextWidth, s+3);
            nextOctave(:,:,1) = nextOctaveBase;
            octaves{i+1,1} = nextOctave;
        end
    end
    test = octaves{3,1};
    figure;
    %Reponse question 2
    for j=1:s+3
        img2show = test(:,:,j)./255;
        subplot(2,3,j);
        imshow(img2show);
        title(sprintf("sigma = %f", sigmas(1,j)));
    end
    
    DoGs = cell(nb_octave,1);
    for i = 1:nb_octave
        currentOctave = octaves{i,1};
        [height, width, n] = size(currentOctave);
        currentDog = zeros(height, width, n-1);
        for j = 2:s+3
            %La difference de gaussienne est faite selon l'article, ce qui
            %nous donne des intensites inversees par rapport a l'exemple.
            currentDog(:,:,j-1) = (currentOctave(:,:,j)-currentOctave(:,:,j-1))/(sigmas(i,j)-sigmas(i,j-1));
        end
        DoGs{i,1} = currentDog;
    end
    
    test = DoGs{1,1};
    figure;
    %Reponse question 3 - ca ressemble a un filtre Laplacien.
    for j=1:s+2
        img2show = test(:,:,j);
        subplot(2,3,j);
        imshow(img2show,[]);
        title(sprintf("sigma = %f", sigmas(1,j)))
    end
    diff = DoGs;
end