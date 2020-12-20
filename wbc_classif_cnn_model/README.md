## CNN Model-based 4 types of WBC (leukocytes) Classification
The CNN model is proposed based on the BCCD dataset. The dataset is consisted of four types of WBC images: __Neutrophil__, __Eosinophil__, __Monocyte__ and __Lymphocyte__. The dataset is collected from [here](https://www.kaggle.com/paultimothymooney/blood-cells/, "Blood Cell Images") and it is __augmented dataset__. The following steps are recommended for using the code. 
- First we run __.m__ file to crop the localized WBC from the blood smear image of BCCD dataset and save them in a folder.
- Then we load the images from that folder and store them in a __.npz__ file.
- The images of that file are grouped in training and testing set.
- We load the __.npz__ file and feed the images to the CNN model for training and testing.

>Note: The details of the proposed CNN model can be found in this [manuscript](https://www.sciencedirect.com/science/article/abs/pii/S0957417420300373 "An Automatic Nucleus Segmentation and CNN Model based Classification Method of White Blood Cell"). Please take a look on it.