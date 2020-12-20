# An Automatic Nucleus Segmentation and CNN Model based Classification Method of White Blood Cell
## **Overview:**
This work is about the WBC (leukocyte) nucleus segmentation, localization and a new CNN model based classification of four types of WBCs (leukocytes).The complete description of the nucleus segmentation algorithm, localization and CNN model can be found [here](https://www.sciencedirect.com/science/article/abs/pii/S0957417420300373 "An Automatic Nucleus Segmentation and CNN Model based Classification Method of White Blood Cell"). Here is the summary of the work:
* Developed a generalized algorithm for WBC nucleus segmentation and valided on four WBC public datasets.
* The WBC (leukocyte) is localized based on the statistical analysis of nucleus and WBC ratio.
* A new CNN model is designed to classify four types of localized and cropped WBC (leukocyte) image.


The code of WBC nucleus segmentation, localization and cropping method are shared in *"wbc_nucleus_seg_localz"* directory. Please see the code and run it on MATLAB (Recommended Version: MATLAB 2017a or 2019a or above).

The code of the dataset generation of cropped WBC image, training of CNN modeland inference of the trained model are shared in *"wbc_classif_cnn_model"* directory.

## **Limitations:**
1. The proposed WBC nucleus and localization method cannot segment and localize joint WBCs.
2. The purpose of the proposed localization method is to focus only on WBC cell not other property of blood (*e.g. RBC, platelets, plasma etc.*) but sometimes it localizes WBC with other blood cells (*ie. mostly happens in BCCD dataset)*.
3. The performance of the proposed CNN model is sensitive to the input image resolution and the height-width ratio of WBC nucleus and WBC (*i.e. explained in "crop_seg_wbc.m" file*).