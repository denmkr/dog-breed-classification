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

splitRatio = 0.5;
[imgDataValidation, imgDataTest] = splitEachLabel(imgDataTest, splitRatio, 'randomize');

%% Constructing network
 
layers = [
    imageInputLayer(inputSize)
 
    
    fullyConnectedLayer(120)
    softmaxLayer
    classificationLayer
];

%% Training network
 
learningRate = 0.001;
maxEpochs = 1;
miniBatchSize = 1;

% trainNet.m
net = trainNet(augImgDataTrain, imgDataValidation, layers, learningRate, maxEpochs, miniBatchSize);
 
%% Testing network

% Save model from scratch for future use
% save customnet.net net
 
% testNet.m
accuracy = testNet(net, imgDataTest);
disp("Accuracy:" + accuracy);
 


