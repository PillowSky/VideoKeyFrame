clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
k = 5;
video = VideoReader(file);
total = video.NumberOfFrames

% Calculate entropy
entropies = zeros(total, 1);
for i = 1:total
    entropies(i) = entropy(rgb2gray(read(video, i)));
end

% Do kmeans
[idx, C, sumd, D] = kmeans(entropies, k);

% Check folder exist
if ~exist(folder, 'dir')
	mkdir(folder);
end

% Each center is a keyframe
for i = 1:k
    [M, I] = min(D(:,i));
    imwrite(read(video, I), sprintf('%s/frame_%05d.jpg', folder, i));
end