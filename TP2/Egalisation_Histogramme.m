function eg = Egalisation_Histogramme(src)
hist = imhist(src);
cumhist = cumsum(hist);
normcumhist = cumhist/max(cumhist);
[h,w] = size(src);
result = zeros(h,w);
for i = 1:h
    for j = 1:w
        result(i,j) = normcumhist(src(i,j)+1);
    end
end
eg = result;
end

