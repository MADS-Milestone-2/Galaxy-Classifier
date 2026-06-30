# Galaxy-Classifier

This repository contains the machine learning pipeline used for classifying galaxies using both structures tabular data and raw image data. This project explore both land-based surveys with the GalaxiesML database, and deep space explorations from the James Webb Telescope with the JWST database. 

The datasets used in the notebook are linked below. The source data files are extremely large, so these datasets are not hosted on GitHub. You must download the files directly to your local storage device before executing the scripts. 
We will use: 

[5x127x127_testing_with_morphology.hdf5](https://zenodo.org/records/11117528), [5x127x127_training_with_morphology.hdf5](https://datalab.astro.ucla.edu/galaxiesml.html#access) and
[5x127x127_validation_with_morphology.hdf5](https://zenodo.org/records/11117528)

JWST dataset:
[JWST datafiles](https://users.flatironinstitute.org/~polymathic/data/MultimodalUniverse/v1/jwst/), [ngdeep file](https://users.flatironinstitute.org/~polymathic/data/MultimodalUniverse/v1/jwst/ngdeep/)

# Installation & Setup

### Prerequisites
Ensure you have Python 3.8 or higher installed. `tkinter` comes pre-installed with standard Python distributions, so no separate installation is required for the file-picker GUI.

### Required Libraries
Install the necessary analytical, deep learning, and data-handling libraries using pip:

```bash
pip install torch torchvision numpy pandas scikit-learn h5py
```

# How to Run the Pipeline Using the File Picker

The scripts utilize Python's GUI toolkit, Tkinter to launch an interactive file selection window. 
Step-by-Step instructions for Tk:

1. Execute the notebook.
2. The TK window will pop up, pausing the notebook and will wait for you to click on it.
3. Once you click on the TK window, navigate your file explorer to locate the large HDF5 files you have downloaded.
4. Follow the specific selection sequence as the prompts appear:
   * **Window 1:** Select your locally saved `5x127x127_training_with_morphology.hdf5` file.
   * **Window 2:** Select your locally saved `5x127x127_testing_with_morphology.hdf5` file.
   * **Window 3:** Select your locally saved `5x127x127_validation_with_morphology.hdf5` file.
5. Resume the notebook by continuing with the following cells.



# Methodology

## Supervised Machine Learning
A logistic regression model and random forest model were trained on the tabular data from the GalaxyML. We started with a logistic regression model on the GalaxyML dataset to define an interpretable baseline for tabular morphological data. The mathematical simplicity of a logistic regression serves as a critical point of comparison. We chose the logistical regression in order to evaluate if more complex models, like the random forest, and the deep learning architecture, the CNN, yield a justifiable increase in classification accuracy.  

After the linear baseline, we implemented a random forest model on the tabular morphological data. Since galaxies tend to be complicated and morphological data typically displays nonlinear structures and interdependent features, the linear boundaries found with the logistic regression weren’t going to be robust enough. The random forest model would address the complex morphological data with very minimal manual feature engineering. Random forests also provide resistance to noise and outliers, which are important due to the size of the dataset and how varied galaxies can look when they are within the irregular class. 

As a third method, and because we had image data, we built a CNN to leverage the spatial structure and multiband image information that isn’t available in the tabular data. Most CNNs are built using three bands, representing the Red Green Blue (RGB) color bands present in most color images; there is a deep history of the RGB color scale and its persistence. However, images taken of space reach beyond the visible light spectrum into other wavelengths of the electromagnetic spectrum. For the GalaxyML data, we adjusted the standard ResNet18 CNN model to 5 bands to account for the g (green), r (red), i (infrared), z (near-infrared), and y (deep near-infrared) photometric filters used on the telescope capturing the images. The CNN was trained on just the images and the labels without any morphological data. 


## Unsupervised Machine Learning
We used DBSCAN and KMeans to find underlying patterns in the data, an unsupervised CNN model to create embeddings. We operated directly on the photometric data without the sersic index or labels. For the labeled dataset, we applied the K-Means algorithm directly to the morphological data, using the same features we used in the unsupervised portion. By withholding the class labels during the clustering process, this approach acts as an independent test to determine if standard geometric properties naturally group galaxies into distinct structural families matching the traditional Hubble Tuning Fork without human supervision.

For the unlabeled JWST dataset, we applied an unsupervised CNN and a DBSCAN model. Because the JWST data contains images, we were interested in using CNN to cluster the data. We adjusted the standard ResNet18 CNN to 7 bands for the photometric bands used in the James Webb Space Telescope.

We used the embeddings created by the unsupervise CNN as features in our supervised models which improved their performances. 

   
