clc;
clear all;

file = '../News.mp4';
folder = 'keyframe';
video = VideoReader(file);
total = video.NumberOfFrames
frames = read(video, [1 Inf]);

% Calculate entropy
entropies = zeros(total, 1);
for i = 1:total
    entropies(i) = entropy(rgb2gray(frames(:,:,:,i)));
end

% Calculate entropy difference between two frames
differences = zeros(total - 1, 1);
for i = 1:total-1
    differences(i) = abs(entropies(i) - entropies(i+1));
end
   
% Calculate mean and standard deviation
meanValue = mean(differences)
stdValue = std(differences)
threshold = meanValue + stdValue*3

% Check folder exist
if ~exist(folder, 'dir')
    mkdir(folder);
end

% First frame is always keyframe
imwrite(frames(:,:,:,i), sprintf('%s/frame_%05d.jpg', folder, 0));

% Greater than threshold select as a key frame
for i = 1:total-1
    if (differences(i) > threshold)
        imwrite(frames(:,:,:,i+1), sprintf('%s/frame_%05d.jpg', folder, i));
    end
end