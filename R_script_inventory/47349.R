setwd("D:/")
library(reshape)
importdata<-`47349`
importdata<-rename(importdata,c(Measurements="measurement",Shape="shape",Weight="carat", Color="color", Clarity="clarity", Cut.Grade="cut", Polish="polish",Symmetry="symmetry",Fluorescence.Intensity="fluorescence",Lab="report",Certificate..="reportno",Stock..="stoneid", Rapnet..Discount..="back"))

colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
rapnetid<-rep(47349, length(importdata$measurement))
rapprice<-rep(NA, length(importdata$measurement))###################### No rapprice#####################
OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, rapprice)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin1<-OOPut[Myvars]
write.csv(Fin1,file="./R_input/47349.csv",row.names = F)