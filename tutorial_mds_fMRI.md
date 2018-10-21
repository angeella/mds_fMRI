# Multidimensional scaling using fMRI data

## Introduction
In this tutorial, the aim is to show a simple application of multidimensional scaling techniques using fMRI data. You can download the dataset, used as example, from the [OpenfMRI](https://openfmri.org/dataset/ds000105/) website that provides free access to neuroimaging data sets. This dataset contains a set of fMRI scans for 5 subjects. Each subject has $12$ runs, and each run is composed by 121 scans.  During each of the 121 scans, an individual is subjected to a 24-seconds stimuli followed by a 12-seconds pause. The stimulus consists on the visualization of certain objects, people, or animals images.
In this experiment, 8 different categories of grey-scale images of houses, cats, bottles, nonsense patterns, chairs, scissors, shoes, and faces were used. For more details, please see the [OpenfMRI](https://openfmri.org/dataset/ds000105/) website.

The aim is to represent the brain activities described by voxels in two dimensions, discovering some clusters that correspond to the brain activities due to the different stimuli. Therefore, the multidimensional scaling techniques is applied.

## Data

You can download directly the data described previously from this [link](https://drive.google.com/open?id=1BDRSflkdmO2XrTPqutwDTtMQ5G26i6nL). It is an .Rdata file containing the data about the first subject. It is a list of $12$ numeric elements, one for each run. Each element is a matrix with dimension $(40 x 64 x 64) x 121$, where the rows represent the number of voxels and the columns the number of scans. 

So, after all you must download the rData:

```r
load("your_path/dati_fmri_sub1.rData")
```

and save the first run discarding the last settling volume considered as noise, and the correspinding labels stimuli

```r
sub1_run1_XX1 <-crossprod(sub1_run_X[[1]])[-121,-121]

label_mds1 <- c(rep("scissors",12),rep("faces",12),rep("cats",12), rep("shoes",12), rep("house",12),rep("scrambledpix",12),rep("bottle",12) , rep("chair",12),rep("pausa",12),rep("pausa",12))
```

## Multidimensional Scaling 

The <a href="https://www.codecogs.com/eqnedit.php?latex=$X^\top&space;X$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?$X^\top&space;X$" title="$X^\top X$" /></a> matrix, with dimension 120 x 120 was constructed after centring the matrix X. The matrix of Euclidean distances was calculated and classical multidimensional scaling was applied, thanks to the \textbf{vegan} package:

```r
sub1_run1_dist_eu <-vegdist(decostand(sub1_run1_XX1,method = "standardize"),method = "euclidean")
mds <- cmdscale(sub1_run1_dist_eu)
mds1<-as.data.frame(cbind(mds,label_mds1))
mds1$V1<-as.numeric(as.character(mds1$V1))
mds1$V2<-as.numeric(as.character(mds1$V2))
centroids <- aggregate(cbind(V1,V2)~label_mds1,mds1,mean)
```
and then, we plot the eulidean distances and the corresponding centroids computed:

```r
cols = c('red', 'blue', 'black', 'steelblue', 'green', 'pink','orange','yellow','brown')
plot(mds1[,1],mds1[,2], type = 'n',xlab="First dimension",ylab="Second dimension",main = "First Run")
points(mds1[,1],mds1[,2], col = cols[as.factor(mds1[,3])], pch = 18)
points(centroids[,2:3], col = cols[as.factor(centroids[,1])], pch = 17,cex=2)
legend('topright', col=cols, legend=levels(as.factor(mds1[,3])),pch=18, cex = 0.7)
```
![mds](https://github.com/angeella/mds_fMRI/blob/readme-edits/mds.png)

We can see that the multidimensional scaling technique permits to represent this heavy matrix into two-dimensional space, also, we can see that are some clusters.
All brain activities given by a particular category of stimulus are represented by closer points, for example, all brain activities due to viewing a house are plotted in the same cluster. Then, the y-axis can describe the stimulus categories and the x-axis the various scans applied. It is a very useful plot that summarizes our multidimensional data.
We can note, also, that the brain activities given by animate objects, as faces and cats, are closer together with respect to inanimate objects, as bottles, scissors and so, but to test this aspect we need more computation that is outside of this project.
Another important aspect, that we analyzed, is how the brain activities representations change across runs. Therefore, we have applied the procedure just explained for each run of the first subject, thus we have 12 2-dimensional representations of our data.

![plot_sub1_runALL](https://github.com/angeella/mds_fMRI/blob/readme-edits/plot_sub1_runALL.pdf)

Figure \ref{plot_sub1_runALL} represents the same plot, as \ref{mds}, for the run 3, 6, 9 and 12 of the first subject. We can note something strange, across the time the division of cluster gets worse, this may be due to a decrease in the attention of the subject in looking at the proposed stimuli run after run. 

We must note, also, that this method of multidimensional scaling applied refers to classical multidimensional scaling that provides the same results coming from the \textbf{principal component analysis} as we can see in Figure \ref{plot_sub1_run1_pca}. Below, the code used to do the principal component analysis:

```r
pca <-prcomp(sub1_run1_XX1,center = TRUE,scale. = TRUE)
PC_fmri<-data.frame(pca$x,label_mds1=label_mds1)
centroids_PCA <- aggregate(cbind(PC1,PC2)~label_mds1,PC_fmri,mean)
ggplot(PC_fmri,aes(x=PC1,y=PC2,color=label_mds1)) +
  geom_point(size=3)+ geom_point(data=centroids_PCA,size=5) + scale_shape_manual(values=c(3,23)) + 
  scale_x_reverse() + scale_colour_manual(values = cols)
```

![plot_sub1_run1_pca](https://github.com/angeella/mds_fMRI/blob/readme-edits/plot_sub1_run1_pca.pdf)

Finally, we want to see how much, by reducing the dimensionality of our data, the multidimensional scaling preserves the distances. In Figure \ref{diagnosticplot_sub1_run1} we represent the original distances versus the distances obtained from the configurations of multidimensional scaling.

```r
distOR<-dist(sub1_run1_dist_eu)
distMDS <- dist(mds[,1:2])
dist_plot<-as.data.frame(cbind(distMDS,distOR))
#pdf("C:/Users/acer/Dropbox/Project AMT/proposal/diagnosticplot_sub1_run1.pdf")
ggplot(dist_plot,aes(x=distOR,y=distMDS))+
  geom_point(size=3) + geom_smooth(method = "lm", se = FALSE)+
  labs(title = "Original distance vs mds configuration distance") +
  xlab("Original distance") + ylab("Mds distance")
```

![diagnosticplot_sub1_run1](https://github.com/angeella/mds_fMRI/blob/readme-edits/diagnosticplot_sub1_run1.png)


## Individual Differences Scaling (INDSCAL) 

In this second part, we want to analyze our collected data of all 5 individuals across 12 runs. There are several methods to aggregate individual proximity matrices into a single analysis, the aim is to analyze the individual differences scaling. Our approach refers to the INDISCAL algorithm created by the SMACOF (Scaling by MAjorizing a COmplicated Function) package, that provides a various approach
to optimization algorithms to minimize the stress function. At first, we created the 12 matrices $X^\topX$ for each individual.

```r
sub1_covariance <- list()
sub_1_dist <-list()
for (i in 1:nrun){
  sub1_covariance[[i]] <- crossprod(sub1_run_X[[i]])
}
```

Then, we calculate the matrix Riemann distance between these 12 covariances:

```r
distR_1 <- outer(seq_along(sub1_covariance), seq_along(sub1_covariance), 
                 FUN= Vectorize(function(i,j) distcov(sub1_covariance[[i]], sub1_covariance[[j]],method = "Riemannian")))
```
We redo these steps for all subjects, so, we will have $5$ objects saved into distr_all list.

```r
dist_all <- list(distR_1, distR_2, distR_3, distR_4, distR_5)
```
Finally, we applied metric multidimensional scaling INDSCAL to these 5 matrices of dissimilarity, one for each subject. The transformation used within the metric multidimensional scaling technique is spline, a piecewise polynomial parametric curves:

```r
ind_fmri <- smacofIndDiff(dist_all, type = "mspline",spline.intKnots = 50,itmax = 1000,spline.degree = 5,ndim = 2)
```
In Figure \ref{plot_INDSCAL} we can observe the similarities between brain activities due to different stimuli between individuals. It is noted that the individual 2 reacted similarly to the individual 5 regarding to the individual 3. This output saws the similarity spaces across 5 subjects. Homogeneities between subjects and/or any outliers could be noted. Figure \ref{plot_INDSCAL_ind} represents the weights of each subject for the creation of the common space plot. We can note that subject 3 is more involved in the creation of the second dimension than in the first dimension, instead, the reverse situation is found for subjects 2 and 5. Figure \ref{plot_INDSCAL_ind} indicates, also, the (dis)similarity calculated for each run across all individuals. We can see that the brain activities detected during the first run are far from the brain activities of the other runs. 

![plot_INDSCAL](https://github.com/angeella/mds_fMRI/blob/readme-edits/plot_INDSCAL.png)
![plot_INDSCAL_ind](https://github.com/angeella/mds_fMRI/blob/readme-edits/plot_INDSCAL_ind.png)

Below, the code used for the plot \ref{plot_INDSCAL}

```r
plot(ind_fmri$gspace[, 1], ind_fmri$gspace[, 2],type = "p",cex=1,pch=20,col="blue",ylim = c(min(ind_fmri$gspace[, 2]),max(ind_fmri$gspace[, 2])*1.4),main = "INDSCAL Configuration",xlab = "First dimension",ylab = "Second dimension")
text(ind_fmri$gspace[, 1], ind_fmri$gspace[, 2],pos=3,labels = c(1:12),col="blue",cex=0.85)
```

and for the plot \ref{plot_INDSCAL_ind}

```r
sub1_w <- as.data.frame(ind_fmri$cweights[[1]])
sub2_w <- as.data.frame(ind_fmri$cweights[[2]])
sub3_w <- as.data.frame(ind_fmri$cweights[[3]])
sub4_w <- as.data.frame(ind_fmri$cweights[[4]])
sub5_w <- as.data.frame(ind_fmri$cweights[[5]])
plot(sub1_w[1,1],sub1_w[2,2],xlab="Weight of dimension 1",ylab="Weight of dimension 2",type = "n",main="INDSCAL weights of 5 subjects")
text(sub1_w[1,1],sub1_w[2,2],labels = "1",cex = 1)
text(sub2_w[1,1],sub2_w[2,2],labels = "2",cex = 1)
text(sub3_w[1,1],sub3_w[2,2],labels = "3",cex = 1)
text(sub4_w[1,1],sub4_w[2,2],labels = "4",cex = 1)
text(sub5_w[1,1],sub5_w[2,2],labels = "5",cex = 1)
```

## Conclusions




    
