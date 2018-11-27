function [filtre] = filtreGaussien(sigma)
%FILTREGAUSSIEN retourne un filtre gaussien tronque pour convolution
%correspondant au Sigma souhaite.

%taille du filtre
t = ceil(sigma * 4);

filtre = zeros(2*t + 1);

%determinant de l'exposant constant, ne depends que de sigma
%negatif de l'exposant aussi inclut, for good measure
det = -(2*sigma*sigma);

%Iteration sur le filtre
for x = -t:t
    for y = -t:t
        %Calcul de la valeur de la fonction gaussienne pour x et y
        % [0, 0] etant le centre de la matrice
        
        %exposant
        v = (x*x + y*y)/det;
        
        %besoin de faire +t pour remettre dans le range [0, 2t] du filtre
        %besoin de faire +1 parce que matlab
        filtre(x+t+1,y+t+1) = exp(v);
    end
end

%multiplier le tout par le facteur commun 1/(2pisigma2)
filtre = filtre / (2*pi*sigma*sigma);

%devrait toujours etre 1 (ou assez proche de)
filtre = filtre / sum(sum(filtre));

end

