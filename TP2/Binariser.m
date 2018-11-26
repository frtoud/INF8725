function b = Binariser(img, threshold)
    [w, h] = size(img);
    for i = 1:w
        for j = 1:h
            if img(i,j) < threshold
                img(i,j) = 0;
            else
                img(i,j) = 255;
            end
        end
    end
    b = img;
end
