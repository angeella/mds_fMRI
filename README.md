# Multidimensional scaling using fMRI data

## Introduction
In this tutorial, the aim is to show a simple application of multidimensional scaling techniques using fMRI data. You can download the dataset, used as example, from the [OpenfMRI](https://openfmri.org/dataset/ds000105/) website that provides free access to neuroimaging data sets. This dataset contains a set of fMRI scans for 5 subjects. Each subject has $12$ runs, and each run is composed by 121 scans.  During each of the 121 scans, an individual is subjected to a 24-seconds stimuli followed by a 12-seconds pause. The stimulus consists on the visualization of certain objects, people, or animals images.
In this experiment, 8 different categories of grey-scale images of houses, cats, bottles, nonsense patterns,
chairs, scissors, shoes, and faces were used. For more details, please see the [OpenfMRI](https://openfmri.org/dataset/ds000105/) website.


The aim is to represent the brain activities described by voxels in two dimensions, discovering some clusters that correspond to the brain
activities due to the different stimuli. Therefore, the multidimensional scaling techniques is applied.

## Data

You can download the data using the following command from the package fMRIdata

``
install.packages("fMRIdata")
library(fMRIdata)
``

fMRIdata contains 5 lists, one for each subject: sub1, sub2, sub3, sub4, sub5. In order to load the first subject

``
data(sub1)
``
This list contains 12 matrices, one for each run. You can see the first run of the first subject as

``
sub1_run_X[[1]]
``

## Multidimensional Scaling 


## Individual Differences Scaling (INDSCAL) 


## Some diagnostics



![mds](https://github.com/angeella/mds_fMRI/blob/readme-edits/mds.png)

    
