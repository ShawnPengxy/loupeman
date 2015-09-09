library(reshape)
importdata<-`30910` #导入变量名转换
importdata<-rename(importdata, c(MEASUREMENT="measurement",SH="shape",CRTWT="carat", CO="color",PU="clarity",CT="cut", PO="polish", SY="symmetry", FL="fluorescence",CERT="report", CERT.NO.="reportno", Stock.NO.="stoneid", Rap_Disc="back", Rap.Rte="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(30910, length(importdata$measurement))
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
write.csv(Fin,file="./R_input/30910.csv",row.names = F)
