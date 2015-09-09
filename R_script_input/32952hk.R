library(reshape)
importdata<-`32952hk` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Weight="carat", Color="color",Clarity="clarity",Cut.Grade="cut", Polish="polish", Symmetry="symmetry", FLO="fluorescence",Lab="report", Certificate..="reportno", Stock..="stoneid", Rapnet..Discount..="back", Rap.Price="rapprice",Per.carat="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back



rapnetid<-rep("32952hk", length(importdata$shape))
green<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
#addd<-rep(" in HK",length(importdata$shape))
#importdata$stoneid<-paste(importdata$stoneid,addd,sep="")

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/32952hk.csv",row.names = F)
