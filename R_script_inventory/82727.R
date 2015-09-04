library(reshape)
importdata<-`82727` #导入变量名转换
importdata<-rename(importdata,c(形状="shape",重量="carat", 颜色="color", 净度="clarity", 切工="cut", 打磨="polish",对称度="symmetry",荧光="fluorescence",证书="report",证书号码="reportno",库存编号="stoneid", 折扣="back",国际报价="rapprice"))
measurement<-c(unlist(paste(importdata$台面, importdata$证书, sep="*")))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))

milky<-rep(NA, length(importdata$shape))



rapnetid<-rep("82727", length(importdata$shape))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, measurement)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/82727.csv",row.names = F)
