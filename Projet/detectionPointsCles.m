function [final_points, points_total, points_contraste, points_edges] = detectionPointsCles(DoG, octave, sigma, seuil_contraste, r_courb_principale, resolution_octave)
    [Height, Width, n] = size(DoG);
    
    r_modified = ((1+r_courb_principale)^2)/r_courb_principale;
    
    points = {};
    
    points_total = 0;
    points_contraste = 0;%éliminés par contraste
    points_edges = 0;%éliminés par Hessian
    
    for k = 2:n-1
        diff_x = imfilter(DoG(:,:,k), [1,0,-1;1,0,-1;1,0,-1]);
        diff_y = imfilter(DoG(:,:,k), [1,1,1;0,0,0;-1,-1,-1]);
        diff2_x = imfilter(diff_x, [1,0,-1;1,0,-1;1,0,-1]);
        diff_xy = imfilter(diff_x, [1,1,1;0,0,0;-1,-1,-1]);
        diff2_y = imfilter(diff_y, [1,1,1;0,0,0;-1,-1,-1]);
        
        TrH = diff2_x + diff2_y;
        DetH = diff2_x .* diff2_y - diff_xy .* diff_xy;
        Curvature = TrH .* TrH ./ DetH;
        
        
        diff_img_x = imfilter(DoG(k), [1,0,-1;1,0,-1;1,0,-1]);
        diff_img_y = imfilter(DoG(k), [1,1,1;0,0,0;-1,-1,-1]);
        
        for i = 2:Height-1
            for j = 2:Width-1
                % detection des extremas
                comp_mat = DoG(i-1:i+1, j-1:j+1, k-1:k+1);
                [max_val, max_index] = max(comp_mat(:));
                [min_val, min_index] = min(comp_mat(:));
                if((max_index == 14) || (min_index == 14))
                    %Point est un extremum local
                    points_total = points_total + 1;
                    
                    %contrast = DoG(coords(1), coords(2), coords(3));
                    contrast = abs(DoG(i,j,k));
                    if(contrast < seuil_contraste)
                        % eliminé par contraste trop bas
                        points_contraste = points_contraste + 1;
                    else
                        
                        curv = Curvature(i, j);
                        if (curv > r_modified)
                            %éliminé par detection d'aretes
                            points_edges = points_edges + 1;
                        else
                            points{end+1} = [j,i,k];
                        end
                    end
                    
                end
            end
        end
    end
    %calcul de l'histogramme de gradients
    HoG = zeros(Height, Width,n);
    OoG = zeros(Height, Width,n);
    for k = 2:n-1
        for i = 2:Height-1
            for j = 2:Width-1
                dx = octave(i+1,j,k) - octave(i-1,j,k);
                dy = octave(i,j+1,k)- octave(i,j-1,k);
                g_mag = sqrt(dx^2+dy^2);
                g_orientation = atan(dx/dy);
                HoG(i,j,k) = g_mag;
                OoG (i,j,k) = g_orientation;
            end
        end
    end
    final_points = {};
    for p=1:size(points(:))
        bins = zeros(36,1);
        coords = points{p};
        scale = 1.5*sigma(coords(3));
        gaussian = filtreGaussien(scale);
        section_size = (size(gaussian, 1) - 1)/2;
        %gaussian = fspecial('gaussian',(section_size*2)+1,scale);
        if (coords(1)-section_size > 0 && coords(1)+section_size < Height && coords(2)-section_size > 0 && coords(2)+section_size < Width)
            Hsection = HoG(coords(1)-section_size:coords(1)+section_size, coords(2)-section_size:coords(2)+section_size, coords(3));
            Osection = OoG(coords(1)-section_size:coords(1)+section_size, coords(2)-section_size:coords(2)+section_size, coords(3));
            Hgaussian = Hsection .* gaussian;
            lHgaussian = Hgaussian(:);
            lOsection = Osection(:);
            %find magnitudes
            for i = 1:size(lOsection)
                bin = mod(floor((lOsection(i)+pi)/(2*pi/36)),36)+1;
                bins(bin) = bins(bin)+ lHgaussian(i);
            end
            max_bin = max(bins);
            max_indexs = find(bins>0.8*max_bin);
            for n = 1:size(max_indexs)
                index = max_indexs(n);
                x1 = mod(index+34, 36)+1;
                x2 = index;
                x3 = mod(index, 36)+1;
                y1 = bins(x1);
                y2 = bins(x2);
                y3 = bins(x3);
                x1 = x1 - 0.5;
                x2 = x2 - 0.5;
                x3 = x3 - 0.5;

                xmas = 0.5*(y1 - y2)*(x3 - x2)^2 - (y3 - y2)*(x2 - x1)^2;
                xmax = y2 + xmas / ((y1 - y2)*(x3 - x2) + (y3 - y2)*(x2 - x1));

                xrad = mod(xmax/36.0, 1)*2*pi - pi;
                %                            X, Y, scale, Angle
                final_points{end+1, 1} = [coords(1), coords(2), coords(3), xrad];
            end
        end
    end
end