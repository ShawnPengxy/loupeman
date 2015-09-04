setwd("D:/")
library(reshape)
importdata<-`85749`
importdata<-rename(importdata,c(Measurements="measurement",SHAPE="shape",SIZE="carat", COLOR="color", CLARITY="clarity", CUT="cut", POL="polish",SYM="symmetry",FLUO="fluorescence",Lab="report",Certificate..="reportno",L.NO="stoneid", DISC.="back",Rap.Price="rapprice"))

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapnetid<-rep(85749, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/85749.csv",row.names = F)