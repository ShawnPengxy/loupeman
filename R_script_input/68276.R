library(reshape)
importdata<-`68276` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Wt="carat", Colour="color",Clarity="clarity",Cut="cut", Polish="polish", Symmetry="symmetry", Flourence="fluorescence",Certificate="report", CertificateNo="reportno", PacketNo="stoneid", back="back", RapPrice="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(68276, length(importdata$measurement))
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
write.csv(Fin,file="./R_input/68276.csv",row.names = F)
