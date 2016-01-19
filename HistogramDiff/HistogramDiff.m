function [r] = HistogramDiff(f1, f2)
    % Convert into gray scale
    g1 = rgb2gray(f1);
    g2 = rgb2gray(f2);
    % Histogram of data
    h1 = imhist(g1);  
    h2 = imhist(g2);
    % Absolute difference of two images
    r = sum(imabsdiff(h1, h2));
end