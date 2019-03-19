%% Data of images

function [imds] = createImageDatastore()
    digitDatasetPath = fullfile('./dog-breed-identification', 'train', 'labeled_images');
    imds = imageDatastore(digitDatasetPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
end