library(reshape)
importdata<-`58826` #导入变量名转换
importdata<-rename(importdata,c(MEASUREMENT="measurement",Shape="shape",Carat="carat", COL="color", Clarity="clarity", CUT="cut", POL="polish",SYM="symmetry",FL="fluorescence",LAB="report",CERT_NO="reportno",Stock.NO="stoneid", Rap.="back",Rap.Vlu="rapprice"))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

milky<-rep(NA, length(importdata$measurement))


temp1<-importdata$CS%in%c("BRN1","BRN2","BRN3")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"

temp2<-importdata$CS%in%"GRN"
colsh[temp2]<-"无咖"
milky[temp2]<-"无奶"
green[temp2]<-"带绿"

temp0<-importdata$CS%in%"WH"
colsh[temp0]<-"无咖"
green[temp0]<-"无绿"

temp3<-importdata$Milky%in%c("M1","M2")
milky[temp3]<-"带奶"

temp4<-importdata$Milky%in%"M0"
milky[temp4]<-"无奶"


colsh[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA


rapnetid<-rep("58826", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/58826.csv",row.names = F)
