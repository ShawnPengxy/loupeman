library(reshape)
importdata<-`47821_84769` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", Flrcnt="fluorescence",Lab="report", ReportNo.="reportno", Packet.Id.="stoneid", Back.="back", Rap="rapprice"))

options(digits=10)


Diameter<-c(unlist(paste(importdata$W.Min., importdata$L.Max.,sep=" - ")))
measurement<-c(unlist(paste(Diameter, importdata$Depth.MM, sep="*")))
rapnetid<-rep(47821.84769, length(measurement))
green<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))
milk1<-importdata$Milky%in%"ML0"
milky[milk1]<-"无奶"
milk2<-importdata$Milky%in%c("ML1","ML2","ML3")
milky[milk2]<-"带奶"
colsh[milk2]<-"无咖"
green[milk2]<-"无绿"
##################Shade#############
temp1<-importdata$Shade%in%c("FBR")
colsh[temp1]<-"带咖"
milky[temp1]<-"无奶"
green[temp1]<-"无绿"
milky[which(!is.na(milky)&is.na(green)&is.na(colsh))]<-NA

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/47821_84769.csv",row.names = F)
