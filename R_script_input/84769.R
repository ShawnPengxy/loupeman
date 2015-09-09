library(reshape)
importdata<-`84769` #导入变量名转换
importdata<-rename(importdata, c(Milky="Milky",Shade="Shade",Shape="shape",Carats="carat", Color="color",Clarity="clarity",Cut="cut", Polish="polish", Sym="symmetry", Flrcnt="fluorescence",Lab="report", ReportNo.="reportno", Packet.Id.="stoneid", Back.="back", Rap="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back

measurement<-paste(importdata$Avg.Dia,importdata$W.Min.,importdata$L.Max.,sep="*")
rapnetid<-rep(84769, length(importdata$shape))
milky<-rep(NA, length(importdata$shape))
colsh<-rep(NA, length(importdata$shape))
green<-rep(NA, length(importdata$shape))
price<-rep(NA, length(importdata$shape))

index1<-importdata$Shade%in%c("FBR","MXD")
colsh[index1]<-"带咖"
green[index1]<-"无绿"
index2<-importdata$Shade%in%""
colsh[index2]<-"无咖"
green[index2]<-"无绿"
index3<-importdata$Milky%in%c("CLDY","CLOUDY","HEAVY","LIGHT MEDIUM")
milky[index3]<-"带奶"
index4<-importdata$Milky%in%c("","-","*","NONE")
milky[index4]<-"无奶"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, measurement)
OOPut<-cbind(OPut, importdata)



Myvars<-c("Milky","Shade","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Milky","Shade")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/84769.csv",row.names = F)
