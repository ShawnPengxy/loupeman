library(reshape)
importdata<-`98034` #导入变量名转换
importdata<-rename(importdata,c(Measurement="measurement",Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Symm="symmetry",Fluo.Int="fluorescence",Lab="report",Certificate="reportno", Disc...="back",Rap..="rapprice"))
measurement<-c(unlist(paste(importdata$Length, importdata$Width, importdata$Height, sep="*")))

stoneid<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))


temp2<-importdata$Shades%in%"White"
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"

temp3<-importdata$Milky%in%c("M1","M2","M3")
milky[temp3]<-"带奶"
temp4<-importdata$Milky%in%"M0"
milky[temp4]<-"无奶"


milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA
colsh[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA

rapnetid<-rep("98034", length(importdata$measurement))

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, stoneid)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/98034.csv",row.names = F)