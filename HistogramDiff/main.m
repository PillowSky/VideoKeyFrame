clc;
clear all;

file = '../Batman.wmv';
folder = 'keyframe';
video = VideoReader(file);

%Extracting frames, prepare data array
total = video.NumberOfFrames
data = zeros(total - 1, 1);

for i = 1:total-1
    % Retrieve data from video
    now = read(video, i);
    next = read(video, i+1);
    % Calculate histogram difference between two frames 
    data(i) = HistogramDiff(now, next);
end
   
% Calculate mean and standard deviation and extracting frames
mean = mean2(data)
std = std2(data)
threshold = std + mean*4

% Make sure folder exist
if ~exist(folder, 'dir')
  mkdir(folder);
end

% Loop over frames again
for i = 1:total-1
    now = read(video,i);
    next = read(video,i+1);
    result = HistogramDiff(now,next);
    % Greater than threshold select as a key frame
    if (result > threshold)
        imwrite(next, sprintf('keyframe/frame_%05d.jpg', i));
    end 
end 