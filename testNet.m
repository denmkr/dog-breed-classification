function [net] = testNet(net, imgDataTest)
    YPred = classify(net, imgDataTest);
    YValidation = imgDataTest.Labels;

    accuracy = sum(YPred == YValidation) / numel(YValidation);

    disp("Accuracy:" + accuracy);
end