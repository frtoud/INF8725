function [descs] = calculDescripteurs(points, imgsize, images)
  
  [gradients, magnitudes] = calculGradients(images);
  %Assume results to be:
  %cell 1: octave
  %dim 1: x
  %dim 2: y
  %dim 3: position in octave
  
  lambda_descr = 6;
  half_sample_size = 8; % sera multiplié par deux pour garantir un chiffre pair
  sample_size = half_sample_size * 2;
  feat_size = 4;
  angle_bins = 8;
  
  sample_per_feat = sample_size/feat_size;
  
  [n, ~] = size(points);
  descs = zeros(n, 130); % X + Y + 128 descriptors
  index_d = 1;
  for index_p = 1:n
    oct = points(index_p, 1); %num d'octave
    num = points(index_p, 2); %num d'image dans l'octave
    posx = points(index_p, 3);
    posy = points(index_p, 4);
    sigma = points(index_p, 5);
    angle = points(index_p, 6);
    %tester la distance a la bordure avec sqrt2 * lambda * sigma
    dist = sqrt(2)*lambda_descr*sigma;
    if (dist < posx && posx < imgsize(2) - dist && dist < posy && posy < imgsize(1) - dist)
      descs(index_d, 1) = posx;
      descs(index_d, 2) = posy;
      
      res = 2^(oct-1) /2;
      step = lambda_descr*sigma*2/sample_size;
      
      target_gradient = cell2mat(gradients(oct,num - 1));
      target_magnitude = cell2mat(magnitudes(oct, num - 1));
      
      exp_det = 2 * (lambda_descr * sigma)^2;
      
      %bins: 4x4x8
      features = zeros([feat_size, feat_size, angle_bins]);
      
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
          sample_grad = target_gradient(oct_y, oct_x);
          sample_mag = target_magnitude(oct_y, oct_x) * gaussfactor; %C^descr_m,n
          
          %place in histogram features, according to i & j
          for fi = 1:feat_size
              for fj = 1:feat_size
                  hi = fi * sample_per_feat - sample_per_feat/2;
                  hj = fj * sample_per_feat - sample_per_feat/2;
                  if (abs(hi-i) <= sample_per_feat) && (abs(hj-j) <= sample_per_feat)
                      contribfactor = (1 - abs(hi-i))*(1 - abs(hj-j));
                      %modulus sur 2pi
                      normgrad = mod(pi + sample_grad - angle, 2*pi);
                      for ft = 1:angle_bins
                          %equation 28
                          angle_distance = mod(normgrad - (pi*(ft*2-1)/angle_bins - pi), 2*pi);
                          if angle_distance <= 2*pi/angle_bins
                             anglefactor = (1 - angle_distance*angle_bins/(2*pi));
                             adjusted_mag = sample_mag * contribfactor * anglefactor;
                             features(fi, fj, ft) = features(fi, fj, ft) + adjusted_mag; 
                          end
                      end
                  end
              end
          end
        end
      end
      
      %compute feature vector
      bins_1D = features(:);
      SRSS = 0;
      for f = 1:size(bins_1D)
        SRSS = SRSS + bins_1D(f)^2;
      end
      SRSS = sqrt(SRSS); %128-dim Euclidian norm
      for f = 1:size(bins_1D)
        val = min(bins_1D(f), 0.2*SRSS);
        val = min(floor(512*val/SRSS), 255);
        %Offset de 2 pour X, Y
        descs(index_d, f + 2) = int8(val);
      end
      
      index_d  = index_d + 1;
    end
    
  end
  descs = descs(1:index_d-1,:);
end
