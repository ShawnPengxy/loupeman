library(reshape)
importdata<-`00000` #导入变量名转换
importdata<-rename(importdata, c(Lus="Lus",CertNo="CertNo",Measurement="measurement",Shape="shape",Cts.="carat", Color="color",Clarity="clarity",Cut="cut", Pol.="polish", Sym.="symmetry", FL="fluorescence", KeyToSymbols="reportno",Rap..="back", Rap="rapprice"))
#importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep("00000", length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

report<-rep("GIA", length(importdata$measurement))
stoneid<-rep("", length(importdata$measurement))

index1<-importdata$CertNo%in%c("BR","BRN","LBR","PINK","YBR")
colsh[index1]<-"带咖"
green[index1]<-"无绿"
index2<-importdata$CertNo%in%""
colsh[index2]<-"无咖"
green[index2]<-"无绿"
index3<-importdata$Lus%in%c("ML-01","ML-1","ML-2")
milky[index3]<-"带奶"
index4<-importdata$Lus%in%c("EX","VG","")
milky[index4]<-"无奶"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)
OPut<-cbind(OPut, report)
OPut<-cbind(OPut, stoneid)
OOPut<-cbind(OPut, importdata)



Myvars<-c("Lus","CertNo","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Lus","CertNo")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/00000.csv",row.names = F)
