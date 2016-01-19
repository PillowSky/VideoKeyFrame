clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
k = 5;
video = VideoReader(file);
total = video.NumberOfFrames

% Calculate thumbnails 
thumbnails = zeros(total, 4096);
for i = 1:total
    temp = imresize(rgb2gray(read(video, i)), [64, 64]);
    thumbnails(i) = sum(temp(:));
end

% Do kmeans
[idx, C, sumd, D] = kmeans(thumbnails, k);

% Check folder exist
if ~exist(folder, 'dir')
	mkdir(folder);
end

% Each center is a keyframe
for i = 1:k
    [M, I] = min(D(:,i));
    imwrite(read(video, I), sprintf('%s/frame_%05d.jpg', folder, i));
end