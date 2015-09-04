setwd("D:/")
library(reshape)
importdata<-`71306`
importdata<-rename(importdata,c(Shape="shape",Carats="carat", Color="color", Clarity="clarity", Cut="cut", Polish="polish",Symm="symmetry",Flour.="fluorescence",Lab="report",Report.No="reportno",Packet.No="stoneid", Disc..="back",Rap..Price="rapprice",Net.Rate="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
Dia<-unlist(paste(importdata$MinDia,importdata$MaxDia,sep="-"))
measurement<-unlist(paste(Dia,importdata$Depth..,sep="*"))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
rapnetid<-rep(71306, length(importdata$shape))

temp1<-importdata$Tint%in%c("G1","G2")
green[temp1]<-"带绿"
temp2<-importdata$Tint%in%"NONE"
green[temp2]<-"无绿"

temp3<-importdata$Brown%in%c("BR1","BR2","BR3")
colsh[temp3]<-"带咖"
temp4<-importdata$Brown%in%"NONE"
colsh[temp4]<-"无咖"

temp5<-importdata$Milky%in%c("M1","M2","M3","M4")
milky[temp5]<-"带奶"
temp6<-importdata$Milky%in%c("NONE","M0")
milky[temp6]<-"无奶"


OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, measurement)

OOPut<-cbind(OPut, importdata)
Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/71306.csv",row.names = F)