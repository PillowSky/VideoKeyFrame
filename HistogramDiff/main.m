clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
video = VideoReader(file);
total = video.NumberOfFrames

% Calculate histogram
histograms = zeros(total, 256);
for i = 1:total
    histograms(i,:) = imhist(rgb2gray(read(video, i)), 256);
end

% Calculate histogram difference between two frames 
difference = zeros(total - 1, 1);
for i = 1:total-1
    difference(i) = sum(imabsdiff(histograms(i,:), histograms(i+1,:)));
end
   
% Calculate mean and standard deviation
meanValue = mean(difference)
stdValue = std(difference)
threshold = meanValue + stdValue*3

% Check folder exist
if ~exist(folder, 'dir')
	mkdir(folder);
end

% Greater than threshold select as a key frame
for i = 1:total-1
    if (difference(i) > threshold)
        imwrite(read(video, i+1), sprintf('keyframe/frame_%05d.jpg', i));
    end 
end 