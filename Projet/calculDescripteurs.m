function [descs] = calculDescripteurs(points, imgsize, gradients, resolution_octave)
  
  lambda_descr = 6;
  half_sample_size = 8; % sera multiplié par deux pour garantir un chiffre pair
  sample_size = half_sample_size * 2;
  
  [n, m] = size(points);
  descs = zeros(n, 130) % X + Y + 128 descriptors
  index_d = 1
  for index_p = 1:n
    oct = points(index_p, 1); %num d'octave
    num = points(index_p, 2); %num d'image dans l'octave
    posx = points(index_p, 3);
    posy = points(index_p, 4);
    %tester la distance a la bordure avec sqrt2 * lambda * sigma
    dist = sqrt2*lambda_descr*sigma
    if (dist < posx and posx < imgsize(1) - dist and dist < posy and posy < imgsize(2) - dist)
      descs(index_d, 1) = posx;
      descs(index_d, 2) = posy;
      sigma = points(index_p, 5);
      angle = points(index_p, 6);
      
      desc_offset = 3; %Commencer a inserer des descripteurs ici
      
      samples = zeros(sample_size);
      res = resolution_octave(oct);
      step = lambda_descr*sigma*2/sample_size;
      for i = 1:sample_size
        for j = 1:sample_size
          dx = (i - half_sample_size - 0.5)*step;
          dy = (j - half_sample_size - 0.5)*step;
          samplingx = ()/sigma
          samplingy = (dy - half_sample_size - 0.5)*sin(angle) + posy
          samples(dx, dy) = target_gradient()
        endfor
      endfor
      
      index_d  = index_d + 1;
    endif 
    
    
  endfor
endfunction
