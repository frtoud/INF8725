%le masque doit etre normalise avant d'etre envoye a la fonction.
function c = Convolution(img, mask)
    [wm,hm] = size(mask);
    [wi,hi] = size(img);
    if(mod(wm,2) ~= 1 || mod(hm,2) ~= 1 || wm ~= hm)
        disp("le masque doit etre un carre de dimension impaire.")
        c = img;
    else
        padded = zeros(wi + wm - 1, hi + hm - 1);
        padded(((wm-1)/2)+1:((wm-1)/2)+wi,((hm-1)/2)+1:((hm-1)/2)+hi) = img;
        result = zeros(wi, hi);
        for i = 1:wi
            for j = 1:hi
                result(i,j) = sum(sum(padded(i:i+wm-1, j:j+hm-1).*mask));
            end
        end
        c = result;
    end
end

