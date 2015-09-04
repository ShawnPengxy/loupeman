library(reshape)
importdata<-`68526` #导入变量名转换
importdata<-rename(importdata,c(Diameter..mm.="measurement",Shape="shape",Carat="carat", Col="color", Purity="clarity", Cut="cut", Polish="polish",Symetery="symmetry",FLO="fluorescence",Certificate.No="reportno",ID.NO="stoneid", Back..="back",Rapaport="rapprice"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
report<-rep(NA, length(importdata$measurement))

rapnetid<-rep("68526", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, report)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/68526.csv",row.names = F)