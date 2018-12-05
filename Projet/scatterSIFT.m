function scatterSIFT(img, points)
%SCATTERSIFT Summary of this function goes here
%   Point matrix: O, S, X, Y, Blur, Angle
% augmenter la taille des cercles
sig = 3;

figure;
imshow(img, [])
hold on;
[nb, ~] = size(points);
for i = 1:nb
    pt = points(i, :);
    c = [0, 0, 0];
    switch pt(1)
        case 1
            c = [1, 0, 0];
        case 2
            c = [0, 1, 0];
        case 3
            c = [0, 0.5, 1];
        otherwise
            c = [1, 0, 1];
    end
    viscircles([pt(3), pt(4)], pt(5)*sig, 'Color', c, 'LineWidth', 1)
    hold on;
    line([pt(3), pt(3) + pt(5)*sig*cos(pt(6))], [pt(4), pt(4) + pt(5)*sig*sin(pt(6))], 'Color', c, 'LineWidth', 1)
    hold on;
end

end

