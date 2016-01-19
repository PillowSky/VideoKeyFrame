clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
k = 5;
video = VideoReader(file);
total = video.NumberOfFrames

% Calculate dct coefficient
dcts = zeros(total, 256);
for i = 1:total
    freq = dct2(imresize(rgb2gray(read(video, i)), [64, 64]));
    part = freq(1:16, 1:16);
    dcts(i,:) = part(:);
end

% Do kmeans
[idx, C, sumd, D] = kmeans(dcts, k);

% Check folder exist
if ~exist(folder, 'dir')
	mkdir(folder);
end

% Each center is a keyframe
for i = 1:k
    [M, I] = min(D(:,i));
    imwrite(read(video, I), sprintf('%s/frame_%05d.jpg', folder, i));
end