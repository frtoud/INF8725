function monnaie = Compter_Monnaie(img)
    total = 0;
    %retirer les elements trop gros...
    se = strel('disk', 200);
    imgb = imerode(img, se);
    imgb = imdilate(imgb, se);
    img = img - imgb;
    %2 dollars
    se = strel('disk', 140);
    img2d = imerode(img, se);
    img2d = imdilate(img2d, se);
    [a,count] = bwlabel(img2d);
    total = total + 2*count;
    img = img - img2d;
    %25 sous
    se = strel('disk', 120);
    img25s = imerode(img, se);
    img25s = imdilate(img25s, se);
    [a,count] = bwlabel(img25s);
    total = total + 0.25*count;
    img = img - img25s;
    %5 sous
    se = strel('disk', 110);
    img5s = imerode(img, se);
    img5s = imdilate(img5s, se);
    [a,count] = bwlabel(img5s);
    total = total + 0.05*count;
    img = img - img5s;
    
    %10 sous
    se = strel('disk', 90);
    img10s = imerode(img, se);
    img10s = imdilate(img10s, se);
    [a,count] = bwlabel(img10s);
    total = total + 0.10*count;
    img = img - img10s;
    figure;
    imshow(img);
    title("image finale");
    
    monnaie = total;
end