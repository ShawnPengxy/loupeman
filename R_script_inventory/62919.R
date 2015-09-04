library(reshape)
importdata<-`62919` #导入变量名转换
importdata<-rename(importdata, c(Shp="shape",Cts="carat", Col="color",Clr="clarity",Cut="cut", Pol="polish", Sym="symmetry", Flr="fluorescence",Lab="report", Rep.No="reportno", Stone.No="stoneid",Disc.="back", Rap="rapprice",Price="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back



Diameter<-c(unlist(paste(importdata$Min, importdata$Max,sep=" - ")))
measurement<-c(unlist(paste(Diameter, importdata$Hgt, sep="*")))
rapnetid<-(rep(62919, length(measurement)))
milky<-rep(NA, length(measurement))
colsh<-rep(NA, length(measurement))
green<-rep(NA, length(measurement))

temp1<-importdata$Col.Dis%in%""
colsh[temp1]<-"无咖"
green[temp1]<-"无绿"

temp2<-importdata$Col.Dis%in%c("BRN1","BRN2","Brn1","Brn2","BRN3","BRN4")
colsh[temp2]<-"带咖"
green[temp2]<-"无绿"

temp3<-importdata$Lus%in%c("M1","M2","M3","M4")
milky[temp3]<-"带奶"

temp4<-importdata$Lus%in%""
milky[temp4]<-"无奶"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)

OPut<-cbind(OPut, measurement)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/62919.csv",row.names = F)
