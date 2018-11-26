function rc = Rehaussement_Contour(img, k)
    gaussian = [1,2,1;2,4,2;1,2,1]/16;
    laplacian = [-1,-1,-1;-1,8,-1;-1,-1,-1];
    img_gauss = Convolution(img, gaussian);
    img_laplacian = Convolution(img_gauss,laplacian);
    rc = img_gauss+k*img_laplacian;
end 

