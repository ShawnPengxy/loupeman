setwd("D:/")
library(reshape)
importdata<-`71344`
importdata<-rename(importdata,c(SHP="shape",CTS="carat", COL="color", CLA="clarity", CUT="cut", POL="polish",SYM="symmetry",FL="fluorescence",CERTNO.="reportno",REFNO.="stoneid", DIS="back",RAP="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
measurement<-unlist(paste(importdata$Measurement,importdata$X,importdata$X.1,sep="*"))
colsh<-rep(NA, length(importdata$color))
green<-rep(NA, length(importdata$color))
milky<-rep(NA, length(importdata$color))
price<-rep(NA, length(importdata$color))

rapnetid<-rep(71344, length(importdata$color))

index1<-importdata$COM%in%"BR"
colsh[index1]<-"����"
milky[index1]<-"����"
green[index1]<-"����"
index1<-importdata$COM%in%"Milky"
colsh[index1]<-"�޿�"
milky[index1]<-"����"
green[index1]<-"����"
index1<-importdata$COM%in%""
colsh[index1]<-"�޿�"
milky[index1]<-"����"
green[index1]<-"����"



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
#OPut<-cbind(OPut, shape)
OPut<-cbind(OPut, measurement)
#OPut<-cbind(OPut, report)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71344.csv",row.names = F)