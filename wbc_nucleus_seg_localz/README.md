# WBC (a.k.a. Leukocytes) Nucleus Segmentation-based Localization
- The WBC nucleus is segmented using the information of different color spaces, the k-means clustering algorithm, and several MATLAB image processing functions (the functions can be found in the .m file).
- After nucleus segmentation, based on the statistical survey of the nucleus and WBC ratio, the WBC is localized into the blood smear image.
- The above nucleus segmentation-based cell localization method is further tuned and applied to the BCCD, ALL-IDB2, JTSC, and CellaVision datasets.
- To feed the localized WBCs to the CNN model (for training), the localized WBCs are cropped with an approximate resolution from the blood smear image and saved to a folder.
