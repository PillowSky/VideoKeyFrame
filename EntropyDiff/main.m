clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
video = VideoReader(file);

% Extracting frames
total = video.NumberOfFrames
entropies = zeros(total, 1);

% Calculate entropy
for i = 1:total
    now = read(video, i);
    entropies(i) = entropy(rgb2gray(now));
end

% Calculate diff
data = zeros(total - 1, 1);
for i = 1:total-1
    % Retrieve entropy
    now = entropies(i);
    next = entropies(i+1);
    % Calculate difference between two frames 
    data(i) = abs(now - next);
end
   
% Calculate mean and standard deviation and extracting frames
mean = mean(data)
std = std(data)
threshold = std + mean*4

% Make sure folder exist
if ~exist(folder, 'dir')
  mkdir(folder);
end

% Loop over frames again
for i = 1:total-1
    now = entropies(i);
    next = entropies(i+1);
    result = abs(now - next);
    % Greater than threshold select as a key frame
    if (result > threshold)
        img = read(video, i+1);
        imwrite(img, sprintf('keyframe/frame_%05d.jpg', i));
    end 
end 