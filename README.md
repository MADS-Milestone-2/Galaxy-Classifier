# Galaxy-Classifier

This repository contains the machine learning pipeline used for classifying galaxies using both structures tabular data and raw image data. This project explore both land-based surveys with the GalaxiesML database, and deep space explorations from the James Webb Telescope with the JWST database. 

The datasets used in the notebook are linked below. The source data files are extremely large, so these datasets are not hosted on GitHub. You must download the files directly to your local storage device before executing the scripts. 
We will use: 

[5x127x127_testing_with_morphology.hdf5](https://zenodo.org/records/11117528), [5x127x127_training_with_morphology.hdf5](https://datalab.astro.ucla.edu/galaxiesml.html#access) and
[5x127x127_validation_with_morphology.hdf5](https://zenodo.org/records/11117528)


# How to Run the Pipeline Using the File Picker

The scripts utilize Python's GUI toolkit, Tkinter to launch an interactive file selection window. 
Step-by-Step instructions for Tk:

1. Execute the notebook.
2. The TK window will pop up, pausing the notebook and will wait for you to click on it.
3. Once you click on the TK window, navigate your file explorer to locate the large HDF5 files you have downloaded.
4. For the first window, choose the Training dataset. Another window will open, and you should choose you testing data set. When the third window opens, choose the validation dataset.
5. Resume the notebook by continuing with the following cells.

   
