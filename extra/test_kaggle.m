load('./app/models/inceptionresnet.mat', 'net');

imds = imageDatastore('./dog-breed-identification/test');
images = imds.Files;

for i=1:2
    image = imread(images{i});
    image = imresize(image, net.Layers(1).InputSize(1:2));
    [~, scores] = classify(net, image);
    disp(scores);
end

% numel(images)