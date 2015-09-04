library(reshape)
importdata<-`32235` #导入变量名转换
importdata<-rename(importdata, c(Measurements="measurement",Shape="shape",Color="color",Cut="cut", Pol="polish",Clarity="clarity", Certi.Cts="carat", Sym="symmetry", Fluo="fluorescence",Certi="report", Certi.No="reportno", Packet.No="stoneid", Disc="back", Rap.Rate="rapprice"))

rapnetid<-rep(32235, length(importdata$measurement))

colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/32235.csv",row.names = F)
