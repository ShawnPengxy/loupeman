library(reshape)
importdata<-`84769` #导入变量名转换
importdata<-rename(importdata,c(Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Sym="symmetry",Flrcnt="fluorescence",Lab="report",ReportNo.="reportno",Packet.Id.="stoneid", Back.="back",Rap="rapprice"))
Dia<-c(unlist(paste(importdata$W.Min., importdata$L.Max, sep="-")))

measurement<-c(unlist(paste(Dia, importdata$Depth.MM, sep="*")))


colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))

temp1<-importdata$Shade%in%"FBR"
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"

temp2<-importdata$Shades%in%""
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"

temp3<-importdata$Milky%in%c("CLDY","CLOUDY","HEAVY","LIGHT","MEDIUM")
milky[temp3]<-"带奶"
temp4<-importdata$Milky%in%"NONE"
milky[temp4]<-"无奶"


milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA
colsh[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA
green[which(is.na(milky)&!is.na(green)&!is.na(colsh))]<-NA

rapnetid<-rep("84769", length(measurement))

OPut<-cbind(rapnetid, colsh)

OPut<-cbind(OPut, measurement)

OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/84769.csv",row.names = F)