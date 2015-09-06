library(reshape)
importdata<-`51500` #导入变量名转换
importdata<-rename(importdata,c(奶="奶",咖="咖",形状="shape",重量="carat", 颜色="color", 净度="clarity", 切工="cut", 抛光="polish",对称="symmetry",荧光="fluorescence",证书号="reportno",货号="stoneid", 折扣="back",国际报价="rapprice",折后单价="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

Dia<-c(unlist(paste(importdata$最小直径, importdata$最大直径, sep=" - ")))
measurement<-c(unlist(paste(Dia, importdata$亭深比, importdata$台面宽, sep="*")))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))

importdata$fluorescence[which(importdata$fluorescence=="FL0")]<-"None"
importdata$fluorescence[which(importdata$fluorescence=="FL1")]<-"F"
importdata$fluorescence[which(importdata$fluorescence=="FL2")]<-"M"
importdata$fluorescence[which(importdata$fluorescence=="FL3")]<-"S"
importdata$fluorescence[which(importdata$fluorescence=="FL4")]<-"VS"

report<-rep("GIA", length(measurement))########检查是否带证书名称#######

temp1<-importdata$咖%in%c("BR","FTBR","BYL","FP","FTYLB","YL","YLB")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"

temp2<-importdata$咖%in%c("WH","OWH")
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"

temp3<-importdata$咖%in%c("GNY","GNGR","YLGN","GRYLG")
colsh[temp3]<-"无咖"
green[temp3]<-"无绿"



temp4<-importdata$奶%in%c("EX","VG")
milky[temp4]<-"无奶"
milky[!temp4]<-"带奶"



rapnetid<-as.numeric(rep("51500", length(measurement)))



OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, measurement)


OPut<-cbind(OPut, report)

OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("奶","咖","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("奶","咖")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/51500.csv",row.names = F)
