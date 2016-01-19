clc;
clear all;

file = '../News.mp4';
folder = 'keyframe';
k = 40;
video = VideoReader(file);
total = video.NumberOfFrames
frames = read(video, [1 Inf]);

% Calculate entropy
entropies = zeros(total, 1);
for i = 1:total
    entropies(i) = entropy(rgb2gray(frames(:,:,:,i)));
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
    imwrite(frames(:,:,:,I), sprintf('%s/frame_%05d.jpg', folder, i));
end