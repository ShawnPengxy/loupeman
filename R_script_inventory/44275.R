library(reshape)
importdata<-`44275` #导入变量名转换
importdata<-rename(importdata, c(Measurement.="measurement",Shape="shape",Col="color",Cut="cut", Pol="polish",Clarit="clarity", Carat="carat", Sym.="symmetry", Flo="fluorescence",Certi="report", GIA.RepNo="reportno", Stone.No="stoneid", Disc.="back", Rap="rapprice"))

rapnetid<-rep(44275, length(importdata$measurement))

colsh<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/44275.csv",row.names = F)
