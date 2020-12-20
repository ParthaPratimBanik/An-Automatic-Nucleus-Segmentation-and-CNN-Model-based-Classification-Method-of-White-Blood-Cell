# WBC Nucleus Segmentation-based Localization
- WBC Nucleus Segmentation method is developed on BCCD, ALL-IDB2, JTSC, and CellaVision dataset.
- A new CNN model is designed on BCCD database.
- The WBC nucleus is segmented using the information of different color spaces and several MATLAB image processing functions (the functions can be found in the .m file). After nucleus segmentation, based on the statistical survey of nucleus and WBC ratio, the WBC is localized into the blood smear image.

- To feed the localized WBCs to the CNN model (for training), the localized WBCs are cropped with an approximate resolution from the blood smear image and saved to a folder.