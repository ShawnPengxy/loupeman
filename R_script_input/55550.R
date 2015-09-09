library(reshape)
importdata<-`55550` #导入变量名转换
importdata<-rename(importdata, c(SH="shape",CTS="carat", COL="color",CLA="clarity",CUT="cut", POL="polish", SYM="symmetry", FL="fluorescence",DIAMETER="measurement",CERT="report",REPORTNO="reportno", PKTNO="stoneid", BACK="back", RAP="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
importdata$rapprice<-importdata$rapprice*100
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(55550, length(importdata$measurement))
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
write.csv(Fin,file="./R_input/55550.csv",row.names = F)
