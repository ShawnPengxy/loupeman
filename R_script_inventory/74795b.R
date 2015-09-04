setwd("D:/")
library(reshape)
importdata<-`74795b`
importdata<-rename(importdata,c(MEASUREMENT="measurement",SHAPE="shape",CARAT="carat", COLOR="color", CLARITY="clarity", CUT="cut", POL="polish",SYM="symmetry",FLR="fluorescence",CERT.="report",REPORT="reportno",NO="stoneid",P.CT="price"))

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))
cut<-rep(NA, length(importdata$measurement))
back<-rep(NA, length(importdata$measurement))
rapprice<-rep(NA, length(importdata$measurement))

rapnetid<-rep(74795, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, back)
OPut<-cbind(OPut, rapprice)

OPut<-cbind(OPut, cut)

OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/74795b.csv",row.names = F)