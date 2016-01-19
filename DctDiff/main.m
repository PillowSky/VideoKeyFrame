clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
video = VideoReader(file);
total = video.NumberOfFrames

% Calculate dct coefficient
dcts = zeros(total, 64, 64);
for i = 1:total
    freq = dct2(imresize(rgb2gray(read(video, i)), [128, 128]));
    dcts(i,:,:) = freq(1:64, 1:64);
end

% Calculate dct difference between two frames 
differences = zeros(total - 1, 1);
for i = 1:total-1
    temp = imabsdiff(squeeze(dcts(i,:,:)), squeeze(dcts(i+1,:,:)));
    differences(i) = sum(temp(:));
end

% Calculate mean and standard deviation
meanValue = mean(differences)
stdValue = std(differences)
threshold = meanValue + stdValue*2

% Check folder exist
if ~exist(folder, 'dir')
	mkdir(folder);
end

% First frame is always keyframe
imwrite(read(video, 1), sprintf('%s/frame_%05d.jpg', folder, 0));

% Greater than threshold select as a key frame
for i = 1:total-1
    if (differences(i) > threshold)
        imwrite(read(video, i+1), sprintf('%s/frame_%05d.jpg', folder, i));
    end 
end 
   