#install.packages("R.matlab")

getwd()
setwd("C:/Users/Sally/Dropbox/Master/SFSU/Computing for life science/Papers/Project/Data/")library(R.matlab)
Pdata <- readMat("C:/Users/Sally/Dropbox/Master/SFSU/Computing for life science/Project/Data/example_dataset/example_data.mat")


dt_smoothed = as.data.frame(t(Pdata$P.smooth))
colnames(dt_smoothed) = unlist(Pdata$descriptor.names)
Ptsid = unique(dt_smoothed$series_id)
Ptsid_subset <- c(1097, 1219, 162, 1229, 858, 125) # same random sample used in MPdist #Ptsid[1:6]
lengthOfData <- length(Ptsid)

all<-NULL;
labels<-NULL;
for (id in Ptsid_subset)  {  
  parasiteData = subset(dt_smoothed, series_id == id)
  #all <- c(all,paste( parasiteData$area, collapse = "," ))
  all = rbind(all,parasiteData$area)
  labelabb = toString(Pdata$tsid.labels[[id]]);
  labelabb = gsub("-control-", "ctr", labelabb);
  labelabb = gsub("-praziquantel-", "pzq", labelabb);
  labelabb = gsub("-simvastatin-", "sim", labelabb);
  labelabb = gsub("-atorvastatin-", "atr", labelabb);
  labels <- c(labels,paste(labelabb, collapse = "," ))
  print(labelabb)
} 
print(dim(all));
all = t(all)
#print(all)
colnames(all) = labels
#distMatrix <- dist(all, method="euclidean")
distMatrix <- dist(t(all), method="DTW")
print(distMatrix)
hc <- hclust(distMatrix, method="average")

plot(as.dendrogram(hc), horiz=F)
