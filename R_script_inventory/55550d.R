library(reshape)
importdata<-`55550d` #导入变量名转换
importdata<-rename(importdata, c(DIAMETER="measurement",SH="shape",CTS="carat", COL="color",CLA="clarity",CUT="cut", POL="polish", SYM="symmetry", FL="fluorescence",CERT="report",REPORTNO="reportno", PKTNO="stoneid", BACK="back", RAP="rapprice"))

rapnetid<-rep(55550, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/55550c.csv",row.names = F)
