function [gradients,magnitudes] = calculGradients(images)
%CALCULGRADIENTS Summary of this function goes here
%   images are cells for each octave
%   X x Y x Sigmas

    [nb_oct, ~] = size(images);
    gradients = {};
    magnitudes = {};
    for n = 1:nb_oct
        cur_octave = cell2mat(images(n, 1));
        [sx, sy, sig] = size(cur_octave);
        for s = 1:sig-3
            cur_grad = zeros(sx, sy);
            cur_mag = zeros(sx, sy);
            for x = 2:(sx-1)
                for y = 2:(sy-1)
                    dx = (cur_octave(x+1, y, s) - cur_octave(x-1, y, s))/2;
                    dy = (cur_octave(x, y+1, s) - cur_octave(x, y-1, s))/2;
                    g = atan2(dy, dx);
                    m = sqrt(dy^2 + dx^2);
                    cur_grad(x, y) = g;
                    cur_mag(x, y) = m;
                end
            end
            gradients{n, s} = cur_grad;
            magnitudes{n, s} = cur_mag;
        end
    end
end

