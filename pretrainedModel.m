%% Labeling images by directories

labelsTable = readtable("./dog-breed-identification/labels.csv");
% createLabelDirectories.m 
createLabelDirectories(labelsTable);

%% Getting data of images

% createImageDatastore.m 
imgData = createImageDatastore();

%% Getting and transforming network

% Choosing pretrained model:
net = alexnet;
% net = googlenet;
% net = resnet50;
% net = inceptionresnetv2;
classesNum = numel(categories(imgData.Labels));

% replaceLayers.m
lgraph = replaceLayers(net, classesNum);

freezeLayersNum = 500;
% freezeLayers.m
layers = freezeLayers(lgraph, freezeLayersNum);

%% Preprocessing

splitRatio = 0.8;
inputSize = net.Layers(1).InputSize;

[imgDataTrain, imgDataTest] = splitEachLabel(imgData, splitRatio, 'randomize');

% augmentImages.m 
augImgDataTrain = augmentImages(imgDataTrain, inputSize);
imgDataTest.ReadFcn = @(loc)imresize(imread(loc), inputSize(1:2));

%% Training network
 
learningRate = 0.001;
maxEpochs = 30;
miniBatchSize = 64;

% trainNet.m
net = trainNet(augImgDataTrain, imgDataTest, layers, learningRate, maxEpochs, miniBatchSize);

%% Testing network

% Save model for future use
% save inceptionresnet.net net
 
% testNet.m
accuracy = testNet(net, imgDataTest);
disp("Accuracy:" + accuracy);
