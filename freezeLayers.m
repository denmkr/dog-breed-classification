function [lgraph] = freezeLayers(lgraph, freezeLayersNum)
    addpath('./matlab');
    
    layers = lgraph.Layers;
    connections = lgraph.Connections;

    layers(1:freezeLayersNum) = freezeWeights(layers(1:freezeLayersNum));
    lgraph = createLgraphUsingConnections(layers,connections);
end