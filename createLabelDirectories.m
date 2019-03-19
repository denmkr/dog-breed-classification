%% Put train images in directories based on label

function [] = createLabelDirectories(labelsTable)
    mkdir ./dog-breed-identification/train labeled_images;

    for i=1:height(labelsTable)
        file_name = sprintf("%s.jpg", char(labelsTable{i,1}));
        source = sprintf("./dog-breed-identification/train/%s", file_name);

        if isfile(source)
            breed_name = char(labelsTable{i,2});
            mkdir("./dog-breed-identification/train/labeled_images", breed_name);
            direction = sprintf("./dog-breed-identification/train/labeled_images/%s/", breed_name);
            direction = strcat(direction, file_name);

            movefile(source, direction);
        end
    end
end