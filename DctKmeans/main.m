clc;
clear all;

file = '../News.mp4';
folder = 'keyframe';
k = 40;
video = VideoReader(file);
total = video.NumberOfFrames
frames = read(video, [1 Inf]);

% Calculate dct coefficient
dcts = zeros(total, 256);
for i = 1:total
    freq = dct2(imresize(rgb2gray(frames(:,:,:,i)), [64, 64]));
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
    imwrite(frames(:,:,:,I), sprintf('%s/frame_%05d.jpg', folder, i));
end