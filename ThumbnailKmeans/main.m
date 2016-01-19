clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
k = 5;
video = VideoReader(file);
total = video.NumberOfFrames
frames = read(video, [1 Inf]);

% Calculate thumbnails 
thumbnails = zeros(total, 256);
for i = 1:total
    temp = imresize(rgb2gray(frames(:,:,:,i)), [16, 16]);
    thumbnails(i,:) = temp(:);
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
    imwrite(frames(:,:,:,I), sprintf('%s/frame_%05d.jpg', folder, i));
end