library(reshape)
importdata<-`68276` #导入变量名转换
importdata<-rename(importdata, c(Milky="Milky",Shade="Shade",Measurements="measurement",Shape="shape",Wt="carat", Colour="color",Clarity="clarity",Cut="cut", Polish="polish", Symmetry="symmetry", Flourence="fluorescence",Certificate="report", CertificateNo="reportno", PacketNo="stoneid", back="back", RapPrice="rapprice"))
importdata$back<-as.numeric(gsub("%","",importdata$back))
if(length(which(importdata$back>0))>length(which(importdata$back<0))) importdata$back=-importdata$back


rapnetid<-rep(68276, length(importdata$measurement))
milky<-rep(NA, length(importdata$measurement))
colsh<-rep(NA, length(importdata$measurement))
green<-rep(NA, length(importdata$measurement))
price<-rep(NA, length(importdata$measurement))

index1<-importdata$Shade%in%c("DB","Gray","LB","LC","Mix(Grey-Green)","Mix(Lb-Green)","Mix(Lb-Grey)","Mix(Lb-Lc)","Mix(Lb-Pink)","Mix(Lc-Green)","PINK")
colsh[index1]<-"带咖"
green[index1]<-"无绿"
index2<-importdata$Shade%in%c("GREEN")
colsh[index2]<-"无咖"
green[index2]<-"带绿"
index3<-importdata$Shade%in%c("White","")
colsh[index3]<-"无咖"
green[index3]<-"无绿"
index4<-importdata$Milky%in%c("Non","")
milky[index4]<-"无奶"
index5<-importdata$Milky%in%c("Faint","Medium","Strong","Very Faint")
milky[index5]<-"带奶"
OPut<-cbind(rapnetid, colsh)
OPut<-cbind(OPut, milky)
OPut<-cbind(OPut, green)
OPut<-cbind(OPut, price)


OOPut<-cbind(OPut, importdata)



Myvars<-c("Shade","Milky","shape","carat","color","clarity","cut","polish","symmetry","fluorescence","colsh","milky","green","measurement","report","reportno","rapnetid","stoneid","back","rapprice","price")
Fin<-OOPut[Myvars]
index_Fin<-Myvars%in%c("Shade","Milky")
Fin<-Fin[!index_Fin]
write.csv(Fin,file="./R_input/68276.csv",row.names = F)
