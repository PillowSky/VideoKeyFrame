clc;
clear all;

file = '../News.mp4';
folder = 'keyframe';
video = VideoReader(file);
total = video.NumberOfFrames
frames = read(video, [1 Inf]);

% Calculate histogram
histograms = zeros(total, 256);
for i = 1:total
    histograms(i,:) = imhist(rgb2gray(frames(:,:,:,i)), 256);
end

% Calculate histogram difference between two frames 
differences = zeros(total - 1, 1);
for i = 1:total-1
    differences(i) = sum(imabsdiff(histograms(i,:), histograms(i+1,:)));
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
imwrite(frames(:,:,:,1), sprintf('%s/frame_%05d.jpg', folder, 0));

% Greater than threshold select as a key frame
for i = 1:total-1
    if (differences(i) > threshold)
        imwrite(frames(:,:,:,i+1), sprintf('%s/frame_%05d.jpg', folder, i));
    end 
end 