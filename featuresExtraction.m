%% Labeling images by directories

labelsTable = readtable("./dog-breed-identification/labels.csv");
% createLabelDirectories.m 
createLabelDirectories(labelsTable);

%% Getting data of images

% createImageDatastore.m 
imgData = createImageDatastore();

%% Getting and transforming network

% Choosing pretrained model:
% net = alexnet;
% net = googlenet;
% net = resnet50;
net = inceptionresnetv2;
disp(net.Layers);


%% Preprocessing

splitRatio = 0.8;
inputSize = net.Layers(1).InputSize;

[imgDataTrain, imgDataTest] = splitEachLabel(imgData, splitRatio, 'randomize');

augImgDataTrain = augmentedImageDatastore(inputSize(1:2), imgDataTrain);
augImgDataTest = augmentedImageDatastore(inputSize(1:2), imgDataTest);

%% Features extraction
 
% layer = 'drop7';
% layer = 'pool5-drop_7x7_s1';
layer = 'avg_pool';

featuresTrain = activations(net, augImgDataTrain, layer, 'OutputAs', 'rows');
featuresTest = activations(net, augImgDataTest, layer, 'OutputAs', 'rows');

YTrain = imgDataTrain.Labels;
YTest = imgDataTest.Labels;

classifier = fitcecoc(featuresTrain, YTrain);

%% Testing network
 
YPred = predict(classifier, featuresTest);
accuracy = mean(YPred == YTest);

disp("Accuracy:" + accuracy);
