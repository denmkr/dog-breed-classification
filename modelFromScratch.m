%% Labeling images by directories

labelsTable = readtable("./dog-breed-identification/labels.csv");
% createLabelDirectories.m 
createLabelDirectories(labelsTable);

%% Getting data of images

% createImageDatastore.m 
imgData = createImageDatastore();

%% Preprocessing

splitRatio = 0.8;
inputSize = [224 224 3];

[imgDataTrain, imgDataTest] = splitEachLabel(imgData, splitRatio, 'randomize');

% augmentImages.m 
augImgDataTrain = augmentImages(imgDataTrain, inputSize);
imgDataTest.ReadFcn = @(loc)imresize(imread(loc), inputSize(1:2));

%% Constructing network
 
layers = [
    imageInputLayer(inputSize)
 
    % 8 filters with 3x3 size using padding so that size[output] = [input]  
    convolution2dLayer(2, 32, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
 
    maxPooling2dLayer(2, 'Stride', 2)
 
    convolution2dLayer(2, 64, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
 
    maxPooling2dLayer(2, 'Stride', 2)
 
    convolution2dLayer(2, 128, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2, 'Stride', 2)
 
    convolution2dLayer(2, 256, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2, 'Stride', 2)
 
    fullyConnectedLayer(256)
    fullyConnectedLayer(120)
    softmaxLayer
    classificationLayer
];

%% Training network
 
learningRate = 0.001;
maxEpochs = 50;
miniBatchSize = 256;

% trainNet.m
net = trainNet(augImgDataTrain, imgDataTest, layers, learningRate, maxEpochs, miniBatchSize);
 
%% Testing network

% Save model from scratch for future use
% save customnet.net net
 
% testNet.m
accuracy = testNet(net, imgDataTest);
disp("Accuracy:" + accuracy);
 


