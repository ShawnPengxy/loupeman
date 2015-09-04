setwd("D:/")
library(reshape)
importdata<-`71344`
importdata<-rename(importdata,c(CTS="carat", COL="color", CLA="clarity", CUT="cut", POL="polish",SYM="symmetry",FL="fluorescence",CERTNO.="reportno",REFNO.="stoneid", DIS="back",rap="rapprice"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
measurement<-unlist(paste(importdata$Measurement,importdata$X,importdata$X.1,sep="*"))
colsh<-rep(NA, length(importdata$color))
green<-rep(NA, length(importdata$color))
milky<-rep(NA, length(importdata$color))
price<-rep(NA, length(importdata$color))

rapnetid<-rep(71344, length(importdata$color))
shape<-rep("Բ��", length(importdata$color))
report<-rep("GIA", length(importdata$color))

temp3<-importdata$COM%in%c("BR","MED BR")
colsh[temp3]<-"����"
green[temp3]<-"����"
milky[temp3]<-"����"


temp5<-importdata$COM%in%"Milky"
milky[temp5]<-"����"
colsh[temp5]<-"�޿�"
green[temp5]<-"����"

temp7<-importdata$COM%in%""
milky[temp7]<-"����"
colsh[temp7]<-"�޿�"
green[temp7]<-"����"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, shape)
OPut<-cbind(OPut, measurement)
OPut<-cbind(OPut, report)
OPut<-cbind(OPut, price)

OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71344.csv",row.names = F)