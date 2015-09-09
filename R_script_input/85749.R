library(reshape)
importdata<-`85749` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",SHAPE="shape",SIZE="carat", COLOR="color",CLARITY="clarity",CUT="cut", POL="polish", SYM="symmetry", FLUO="fluorescence",Lab="report", Certificate..="reportno", L.NO="stoneid", DISC.="back", Rap.Price="rapprice"))
#importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
importdata$shape[which(importdata$shape=="RBC")]<-"圆形"

rapnetid<-rep(85749, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)


OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/85749.csv",row.names = F)
