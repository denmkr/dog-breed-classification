%% Visualize
addpath('../');

imds = imageDatastore('../dog-breed-identification/train/labeled_images/pembroke');
imshow(readimage(imds, 1));

augImages = augmentImages(imds, [224 224]);

figure;
ims = augImages.preview();
montage(ims{1:6,1}); % to visualize 6 images