load('../app/models/inceptionresnet.mat', 'net');

disp(net.Layers);

% Show original image
image = imread('./images/dog.jpg');
imshow(image);

% Show resized image
figure;
image = imresize(image, net.Layers(1).InputSize(1:2));
imshow(image);

% Show layer conv2d_1 (Layer 3)
figure;
act1 = activations(net, image, 'conv2d_1');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I = imtile(mat2gray(act1),'GridSize',[4 8]);
imshow(I);

% Show layer conv2d_3 (Layer 9)
figure;
act1 = activations(net, image, 'conv2d_3');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I = imtile(mat2gray(act1),'GridSize',[8 8]);
imshow(I);

% Show layer conv2d_24 (Layer 77)
figure;
act1 = activations(net, image, 'conv2d_24');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I = imtile(mat2gray(act1),'GridSize',[8 8]);
imshow(I);

% Show layer conv2d_88 (Layer 328)
figure;
act1 = activations(net, image, 'conv2d_88');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I = imtile(mat2gray(act1),'GridSize',[16 12]);
imshow(I);

% Show layer conv2d_202 (Layer 806)
figure;
act1 = activations(net, image, 'conv2d_202');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I = imtile(mat2gray(act1),'GridSize',[16 14]);
imshow(I);



