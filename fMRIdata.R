#' @title fMRI data from OpenfMRI.org website
#'
#' @description This package provides fMRI data coming from OpenfMRI.org website, a set of fMRI scans for 5 subjects. For more details please see "https://github.com/angeella/mds_fMRI/"
#'
#' @param NULL
#'
#' @return sub1, sub2, sub3, sub4, sub5
#'
#' @examples data(sub1)
#'
#' @export


sub1 <- load("C:/Users/Angela Andreella/Documents/Visual_object/data/ds000105_R2.0.2/dati_fmri_sub1.rData")
system.file(sub1, package = "fMRIdata")

sub2 <- load("C:/Users/Angela Andreella/Documents/Visual_object/data/ds000105_R2.0.2/dati_fmri_sub2.rData")
system.file(sub2, package = "fMRIdata")

sub3 <- load("C:/Users/Angela Andreella/Documents/Visual_object/data/ds000105_R2.0.2/dati_fmri_sub3.rData")
system.file(sub3, package = "fMRIdata")

sub4 <- load("C:/Users/Angela Andreella/Documents/Visual_object/data/ds000105_R2.0.2/dati_fmri_sub4.rData")
system.file(sub4, package = "fMRIdata")

sub5 <- load("C:/Users/Angela Andreella/Documents/Visual_object/data/ds000105_R2.0.2/dati_fmri_sub6.rData")
system.file(sub5, package = "fMRIdata")




