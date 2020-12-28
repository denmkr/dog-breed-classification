All dataset is located in dog-breed-identification/train directory. Initially we run a function that divides all images in this directory into different directories based on its label.

1. modelFromScratch.m is a file for creating custom model from scratch
2. pretrainedModel.m is a file for getting pretrained model (alexnet, googlenet, resnet, inceptionresnet), removing and replacing last layers for our classification (and freezing some layers if it is needed).

3. An app for recognizing a god breed using different trained models is located in app/ folder (launch the file windowapp.fig). Trained models (already tuned for our classification) are located in the directory app/models.

4. Extra folder:
- visualizeAugmentedImages.m is for representing how images look like when we apply image augmentation.
- visualizeLayers.m is for visualizing input image on different layers of the network (inceptionresnetv2).
- test_kaggle.m is the task from the kaggle website to classify all images from dog-breed-identification/test directory.

5. matlab directory includes prepared functions from MATLAB website.