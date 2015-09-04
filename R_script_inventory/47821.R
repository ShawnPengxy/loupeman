library(reshape)
importdata<-`47821` #导入变量名转换
importdata<-rename(importdata, c(Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", Flrcnt="fluorescence",Lab="report", ReportNo.="reportno", Packet.Id.="stoneid", Back.="back", Rap="rapprice",Price.Cts.="price"))

options(digits=10)

if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

Diameter<-c(unlist(paste(importdata$W.Min., importdata$L.Max.,sep=" - ")))
measurement<-c(unlist(paste(Diameter, importdata$Depth.MM, sep="*")))
rapnetid<-as.numeric(rep("47821", length(measurement)))
green<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
milky<-rep(NA, length(measurement))

milk1<-importdata$Milky%in%"NONE"
milky[milk1]<-"无奶"
milk2<-importdata$Milky%in%c("HEAVY","LIGHT","MEDIUM")
milky[milk2]<-"带奶"

##################Shade#############
temp1<-importdata$Shade%in%c("FBR")
colsh[temp1]<-"带咖"
green[temp1]<-"无绿"
temp2<-importdata$Shade%in%""
colsh[temp2]<-"无咖"
green[temp2]<-"无绿"

OPut<-cbind(measurement,rapnetid)
OPut<-cbind(OPut, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/47821.csv",row.names = F)
