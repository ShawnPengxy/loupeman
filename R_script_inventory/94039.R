library(reshape)
importdata<-`94039` #导入变量名转换
importdata<-rename(importdata, c(Tinch="Tinch",L.W.Diam="measurement",Shape="shape",Cts="carat", Color="color",Clar="clarity",Cut="cut", Polish="polish", Symm="symmetry", Fl="fluorescence",Lab="report", Cert.No="reportno",Hopno="stoneid", Disc.="back", Rap.="rapprice",Rate.="price"))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back
importdata$shape[which(importdata$shape=="RN")]<-"圆形"
importdata$shape[which(importdata$shape=="RP")]<-"梨形"

rapnetid<-rep(94039, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))

index1<-importdata$Tinch%in%"N"
milky[index1]<-"无奶"
colsh[index1]<-"无咖"
green[index1]<-"无绿"
index2<-importdata$Tinch%in%"Y"
milky[index2]<-"无奶"
colsh[index2]<-"带咖"
green[index2]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OOPut<-cbind(OPut, importdata)



Myvars<-c("shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
write.csv(Fin,file="./R_input/94039.csv",row.names = F)
