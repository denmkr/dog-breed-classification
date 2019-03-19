function [lgraph] = replaceLayers(net, classesNum)
    addpath('./matlab');
    
    if isa(net,'SeriesNetwork') 
      lgraph = layerGraph(net.Layers); 
    else
      lgraph = layerGraph(net);
    end 

    [learnableLayer, classLayer] = findLayersToReplace(lgraph);

    if isa(learnableLayer,'nnet.cnn.layer.FullyConnectedLayer')
        newLearnableLayer = fullyConnectedLayer(classesNum, ...
            'Name','new_fc', ...
            'WeightLearnRateFactor',10, ...
            'BiasLearnRateFactor',10);

    elseif isa(learnableLayer,'nnet.cnn.layer.Convolution2DLayer')
        newLearnableLayer = convolution2dLayer(1,classesNum, ...
            'Name','new_conv', ...
            'WeightLearnRateFactor',10, ...
            'BiasLearnRateFactor',10);
    end

    lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);

    newClassLayer = classificationLayer('Name','new_output');
    lgraph = replaceLayer(lgraph, classLayer.Name, newClassLayer);
end