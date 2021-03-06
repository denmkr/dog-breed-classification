%% Augmentation of images

function [augImds] = augmentImages(imds, imgSize)
    imageAugmenter = imageDataAugmenter( ...
        'RandRotation',[-45,45], ...
        'RandXTranslation',[-70 70], ...
        'RandYTranslation',[-45 45], ...
        'RandScale', [1 1.8]);
    
    augImds = augmentedImageDatastore(imgSize, imds, 'DataAugmentation', imageAugmenter);
end