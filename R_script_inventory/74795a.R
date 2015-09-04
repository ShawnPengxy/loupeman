setwd("D:/")
library(reshape)
importdata<-`74795a`
importdata<-rename(importdata,c(MEASUREMENT="measurement",SHAPE="shape",CARAT="carat", COLOR="color", CLARITY="clarity", CUT="cut", POL="polish",SYM="symmetry",FLR="fluorescence",LAB="report",REPORT="reportno",NO="stoneid", DISC="back",RAP="rapprice",P.CT="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapnetid<-rep(74795, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/74795a.csv",row.names = F)