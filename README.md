# AutoRef
"Automated reference tissue normalization of T2-weighted MR images of the prostate using object recognition"

This is an automated method for dual-reference tissue normalization of T2-weighted MRI for the prostate.

The method was developed at the MR Cancer group at the Norwegian University of Science and Technology (NTNU) in Trondheim, Norway.
https://www.ntnu.edu/isb/mr-cancer

For detailed information about this method, please read our paper: https://link.springer.com/article/10.1007%2Fs10334-020-00871-3

# How to cite AutoRef
In case of using or refering to AutoRef, please cite it as:
Sunoqrot, M.R.S., Nketiah, G.A., Selnæs, K.M. et al. Automated reference tissue normalization of T2-weighted MR images of the prostate using object recognition. Magn Reson Mater Phy (2020). https://doi.org/10.1007/s10334-020-00871-3

# How to use AutoRef
This is a MATLAB® function, the function was written and tested using MATLAB® R2019b.

To run the function you can use the AutoRef.m file and make sure to install the trained object detectors "fatDetector.mat" and "muscleDetector.mat" and the Dependency folder.
In addition, you have to install the Convert3D tool as desciped in the Dependency section below.

Make sure that all of these files are in the same folder.

To use the function, you simply have to provide the full directory (string) to your DICOM foldr or MetaIO (.mha/.mhd) image as an input to the AutoRef function.
```matlab
normalized = AutoRef('full_directory');
```
The output (normalized) is a structure that contains:
1. normalized.Data: 3D image data (the normalized image).
2. normalized.info: DICOM info, organized per slice.
3. normalized.A: affine transformation matrix to transform image to the world coordinate system.
4. normalized.R: reference image coordinate system.

Example for DICOM folders:

Let say you have a folder with the images resulted from a T2-weighted MRI scan of the prostate (Case10).
To get the normalized image (Structure in MATLAB®) you have to type this:
```matlab
normalized = AutoRef('C:\Data\Case10');
```
Example for MetaIO image:

Let say you have a the images resulted from a T2-weighted MRI scan of the prostate (Case10) in MetaIO format (3D image).
To get the normalized image (Structure in MATLAB®) you have to type this:
```matlab
normalized = AutoRef('C:\Data\Case10.mhd');
```

After that you can cinvert the matlab image to the format you find suitable for your work.
For example you can conver the normalized image to a MetaIO image.
```matlab
StrDatax = elxIm3dToStrDatax(normalized);
Filename = 'C:\Data\Case10_Normalized.mhd';
elxStrDataxToMetaIOFile(StrDatax, FilenameNorm, 0);
```

# Dependency 
This function depend on the followings, which you should make sure that you have correctly installed them on your computer:
1. Convert3D tool from ITK 
  by ITK-SNAP http://www.itksnap.org
  - You MUST install it to your computer and complie it with your system as descriped: 
    + Install the "CONVERT3D NIGHTLY BUILD" folder from: http://www.itksnap.org/pmwiki/pmwiki.php?n=Downloads.C3D
    + Follow the guide in the documents to install and compile: http://www.itksnap.org/pmwiki/pmwiki.php?n=Convert3D.Convert3D  
2. elastix toolbox (4.3<=version<=4.7):
  by: Image Sciences Institute, University Medical Center Utrecht, The Netherlands.
  - It is included in the Dependency folder, so no need to download it unless you faced a problem with it, in that case:
    + Download and compile as descriped at: http://elastix.isi.uu.nl/
    + Read and follow the section 1.2 at: http://elastix.isi.uu.nl/download/elastix-5.0.0-manual.pdf
3. ElastixFromMatlab (a MATLAB® wrapper around elastix)
  by: CNRS,France and Riverside Research, USA https://sourcesup.renater.fr/www/elxfrommatlab/
  - It is included in the Dependency folder, so no need to download it.
  - In case of you had to redownload the elastix toolbox as mentioned above, make sure to change the paths in "elxTestDefaultConfiguration.m" script.
4. loadImage3
  by: Dr. Mattijs Elschot from the MR center at the Norwegian University of Science and Technology (NTNU), Trondheim, Norway.
  Dr. Elschot allowed the function uploading. 

A function to read the DICOM images and sort them in a structure similar to that generated by ElastixFromMatlab.
  - It is included in the Dependency folder, so no need to download it.
