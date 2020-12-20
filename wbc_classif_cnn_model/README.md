## CNN Model-based 4 types of WBC (leukocytes) Classification
The CNN model is proposed based on the BCCD dataset. The dataset is consisted of four types of WBC images: __Neutrophil__, __Eosinophil__, __Monocyte__ and __Lymphocyte__. The dataset is collected from [here](https://www.kaggle.com/paultimothymooney/blood-cells/, "Blood Cell Images") and it is __augmented dataset__. In this research work, the augmented and original BCCD dataset are used. Table-1 (for training) and Table-2 (for testing) show the number of original and augmented BCCD WBC images that are considered for training and testing the proposed CNN model in this [manuscript](https://www.sciencedirect.com/science/article/abs/pii/S0957417420300373 "An Automatic Nucleus Segmentation and CNN Model based Classification Method of White Blood Cell").

---
Table-1: __Training__
<br>
| Types of WBC | Original | Augmented | Total |
| ------------ | -------- | --------- | ----- |
| Eosinophil	  | 75       | 2497      | 2572  |
| Neutrophil	  | 158      | 2499      | 2657  |
| Monocyte	    | 16       | 2478      | 2494  |
| Lymphocyte	  | 27       | 2483      | 2510  |
| __Total__    | 276      | 9957      | 10233 |
---
<br>

Table-2: __Testing__
<br>
| Types of WBC | Original | Augmented | Total |
| ------------ | -------- | --------- | ----- |
Eosinophil	    | 13       | 623       | 636   | 
Neutrophil	    | 48       | 624       | 672   |
Monocyte	      | 4        | 620       | 624   |
Lymphocyte	    | 6        | 620       | 626   |
| __Total__    | 71       | 2487      | 2558  |
---
<br>

The following steps are recommended for using the code. 
- First we run __.m__ file to crop the localized WBC from the blood smear image of BCCD dataset and save them in a folder.
- Then we load the images from that folder and store them in a __.npz__ file.
- The images of that file are grouped in training and testing set.
- We load the __.npz__ file and feed the images to the CNN model for training and testing.
<br>
<br>

>Note: __The details of the proposed CNN model can be found in this [manuscript](https://www.sciencedirect.com/science/article/abs/pii/S0957417420300373 "An Automatic Nucleus Segmentation and CNN Model based Classification Method of White Blood Cell"). Please take a look on it__.