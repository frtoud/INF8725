function [descs] = calculDescripteurs(points, imgsize, images, resolution_octave)
  
  [gradients, magnitudes] = calculGradients(images);
  %Assume results to be:
  %dim 1: octave
  %dim 2: position in octave
  %dim 3: x
  %dim 4: y
  
  lambda_descr = 6;
  half_sample_size = 8; % sera multiplié par deux pour garantir un chiffre pair
  sample_size = half_sample_size * 2;
  feat_size = 4;
  
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
      
      samples_grad = zeros(sample_size);
      samples_mag = zeros(sample_size);
      res = resolution_octave(oct);
      step = lambda_descr*sigma*2/sample_size;
      
      target_gradient = gradients(oct, num)
      target_magnitude = magnitudes(oct, num)
      
      exp_det = 2 * (lambda_descr * sigma)^2;
      
      %bins: 4x4x8
      features = zeros([4, 4, 8]);
      
      %sample size 16
      for i = 1:sample_size
        for j = 1:sample_size
          %la distance entre chaque point de sampling avec le step calculé
          dx = (i - half_sample_size - 0.5)*step;
          dy = (j - half_sample_size - 0.5)*step;
          %original imagespace
          samplingx = dx*cos(angle) + dy*sin(angle) + posx;
          samplingy = dy*cos(angle) - dx*sin(angle) + posy;
          %corresponding octave's space
          oct_x = floor(samplingx/res);
          oct_y = floor(samplingy/res);
          %scale according to gauss
          gaussfactor = exp(-(dx^2 + dy^2)/exp_det);
          %collect sample orientation & magnitude
          samples_grad(dx, dy) = target_gradient(oct_x, oct_y);
          samples_mag(dx, dy) = target_magnitude(oct_x, oct_y) * gaussfactor;
          
          %place in histogram features
          
        endfor
      endfor
      
      %compute feature vector
      bins_1D = features(:);
      SRSS = 0;
      for f = 1:size(bins_1D)
        SRSS = SRSS + bins_1D(f)^2;
      endfor
      SRSS = sqrt(SRSS); %128-dim Euclidian norm
      for f = 1:size(bins_1D)
        val = min(bins_1D(f), 0.2*SRSS);
        val = min(floor(512*val/SRSS), 255)
        %Offset de 2 pour X, Y
        descs(index_d, f + 2) = int(val);
      endfor
      
      index_d  = index_d + 1;
    endif 
    
  endfor
endfunction
