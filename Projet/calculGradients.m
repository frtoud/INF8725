function [gradients,magnitudes] = calculGradients(images)
%CALCULGRADIENTS Summary of this function goes here
%   images are cells for each octave
%   X x Y x Sigmas

    [~, nb_oct] = size(images)
    gradients = {};
    magnitudes = {};
    for n = 1:nb_oct
        curr_octave = cell2mat(images(1, n));
        [sx, sy, sig] = size(curr_octave);
        cur_grad = zeros(sx, sy, sig);
        cur_mag = zeros(sx, sy, sig);
        for s = 1:sig-3
            for x = 2:(sx-1)
                for y = 2:(sy-1)
                    dx = (cur_octave(x+1, y, s) - cur_octave(x-1, y, s))/2;
                    dy = (cur_octave(x, y+1, s) - cur_octave(x, y-1, s))/2;
                end
            end
        end
    end
end

