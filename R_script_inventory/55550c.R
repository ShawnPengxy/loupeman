library(reshape)
importdata<-`55550c` #导入变量名转换
importdata<-rename(importdata, c(SH="shape",CTS="carat", COL="color",CLA="clarity",CUT="cut", POL="polish", SYM="symmetry", FL="fluorescence",CERT="report",CERT.NO="reportno", PKTNO="stoneid", BACK="back", RAP="rapprice"))

measurement<-paste(importdata$DIMENSION,importdata$X,sep="*")
rapnetid<-rep(55550, length(measurement))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)

Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/55550c.csv",row.names = F)
