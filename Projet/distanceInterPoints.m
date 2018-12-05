function [de_distance] = distanceInterPoints(points_image1, points_image2)
    [nb_1, d1] = size(points_image1);
    [nb_2, d2] = size(points_image2);
    de_distance = zeros(nb_1, nb_2);
    for i = 1:nb_1
        for j = 1:nb_2
            p1 = points_image1(i, 3:d1);
            p2 = points_image2(j, 3:d1);
            de_distance(i, j) = sqrt(sum((p1 - p2).^2));
        end
    end
end