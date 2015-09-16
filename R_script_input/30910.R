library(reshape)
importdata<-`30910` #导入变量名转换
importdata<-rename(importdata, c(TTLBGIA="TTLBGIA",MEASUREMENT="measurement",SH="shape",CRTWT="carat", CO="color",PU="clarity",CT="cut", PO="polish", SY="symmetry", FL="fluorescence",CERT="report", CERT.NO.="reportno", Stock.NO.="stoneid", Rap_Disc="back", Rap.Rte="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(30910, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

index1<-importdata$TTLBGIA%in%c("NO BGM","")
colsh[index1]<-"无咖"
milky[index1]<-"无奶"
green[index1]<-"无绿"
index2<-importdata$TTLBGIA%in%c("LB","TLB","TTLB")
colsh[index2]<-"带咖"
milky[index2]<-"无奶"
green[index2]<-"无绿"

OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)


OOPut<-cbind(OPut, importdata)



Myvars<-c("TTLBGIA","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("TTLBGIA")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/30910.csv",row.names = F)
